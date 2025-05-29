Use COURSE

-- Запит для отримання інформації про штат співробітників

SELECT 
    e.id AS 'ID_співробітника',
    p.name AS 'Ім''я',
    p.surname AS 'Прізвище',
    p.patronymic AS 'По_батькові',
    pos.name AS 'Посада',
    pos.salary AS 'Зарплата',
    e.start_date AS 'Дата_прийому'
FROM (SELECT e.* FROM employees e WHERE e.end_date IS NULL) as e
JOIN persons p ON e.person_id = p.id
JOIN positions pos ON e.position_id = pos.id
ORDER BY p.surname, p.name;

-- Запит для отримання інформації про стан складу

SELECT 
    p.name AS 'Назва товару',
    pt.name AS 'Тип товару',
    m.name AS 'Виробник',
    ws.current_quantity AS 'Кількість на складі',
    p.storage_conditions AS 'Умови зберігання',
    p.created_at AS 'Дата виробництва',
    p.expiration_at AS 'Термін придатності',
    pkg.name AS 'Упаковка',
    pkg.description AS 'Опис упаковки',
    CASE 
        WHEN p.expiration_at < GETDATE() THEN 'Прострочений'
        WHEN p.expiration_at <= DATEADD(day, 7, GETDATE()) THEN 'Термін придатності закінчується'
        ELSE 'Придатний'
    END AS 'Статус терміну придатності'
FROM warehouse_stock ws
JOIN product p ON ws.product_id = p.id
JOIN product_type pt ON p.product_type_id = pt.id
JOIN manufacturer m ON p.manufacturer_id = m.id
JOIN packaging pkg ON p.packaging_id = pkg.id
ORDER BY 
    CASE 
        WHEN p.expiration_at < GETDATE() THEN 1
        WHEN p.expiration_at <= DATEADD(day, 7, GETDATE()) THEN 2
        ELSE 3
    END,
    p.name;

-- Запит для отримання транспортних накладних

SELECT 
    d.delivery_document_number AS 'Номер накладної',
    d.delivery_date AS 'Дата накладної',
    s.name AS 'Постачальник',
    c.name AS 'Отримувач',
    p.name AS 'Товар',
    pt.name AS 'Тип товару',
    m.name AS 'Виробник',
    di.quantity AS 'Кількість',
    di.unit_price AS 'Ціна за одиницю',
    di.total_price AS 'Загальна вартість',
    dm.name AS 'Спосіб доставки',
    CONCAT(per.name, ' ', per.surname) AS 'Відповідальна особа',
    d.total_cost AS 'Загальна сума накладної',
    d.notes AS 'Примітки'
FROM deliveries d
JOIN delivery_items di ON d.id = di.delivery_id
JOIN product p ON di.product_id = p.id
JOIN product_type pt ON p.product_type_id = pt.id
JOIN manufacturer m ON p.manufacturer_id = m.id
JOIN suppliers s ON d.supplier_id = s.id
JOIN customers c ON d.id = c.id
JOIN delivery_methods dm ON d.delivery_method_id = dm.id
JOIN employees e ON d.employee_id = e.id
JOIN persons per ON e.person_id = per.id
ORDER BY d.delivery_date DESC, d.delivery_document_number;

-- Запит для отримання невиконаних замовлень

SELECT 
    o.id AS 'Номер замовлення',
    o.order_date AS 'Дата замовлення',
    CASE 
        WHEN o.status = 'NEW' THEN 'Новий'
        WHEN o.status = 'PROCESSING' THEN 'В обробці'
    END AS 'Статус замовлення',
    c.name AS 'Клієнт',
    p.name AS 'Товар',
    pt.name AS 'Тип товару',
    m.name AS 'Виробник',
    oi.quantity AS 'Кількість',
    oi.unit_price AS 'Ціна за одиницю',
    oi.total_price AS 'Загальна вартість',
    o.total_amount AS 'Загальна сума замовлення',
    CONCAT(per.name, ' ', per.surname) AS 'Відповідальна особа',
    o.notes AS 'Примітки',
    o.created_at AS 'Дата створення',
    o.updated_at AS 'Дата оновлення'
FROM (SELECT o.* FROM orders o WHERE o.status IN ('NEW', 'PROCESSING')) AS o
JOIN order_items oi ON o.id = oi.order_id
JOIN product p ON oi.product_id = p.id
JOIN product_type pt ON p.product_type_id = pt.id
JOIN manufacturer m ON p.manufacturer_id = m.id
JOIN customers c ON o.customer_id = c.id
JOIN employees e ON o.created_by = e.id
JOIN persons per ON e.person_id = per.id
ORDER BY 
    CASE o.status
        WHEN 'NEW' THEN 1
        WHEN 'PROCESSING' THEN 2
    END,
    o.order_date DESC,
    o.id;

-- Аналіз продажів за період (за місяць)
SELECT 
    YEAR(o.order_date) AS 'Рік',
    MONTH(o.order_date) AS 'Місяць',
    COUNT(DISTINCT o.id) AS 'Кількість замовлень',
    SUM(o.total_amount) AS 'Загальна сума продажів',
    AVG(o.total_amount) AS 'Середній чек',
    COUNT(DISTINCT o.customer_id) AS 'Кількість унікальних клієнтів'
FROM orders o WHERE o.status = 'COMPLETED'
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY YEAR(o.order_date) DESC, MONTH(o.order_date) DESC;

-- Топ продаваних товарів
SELECT 
    p.name AS 'Товар',
    pt.name AS 'Тип товару',
    m.name AS 'Виробник',
    SUM(oi.quantity) AS 'Загальна кількість продажів',
    SUM(oi.total_price) AS 'Загальна сума продажів',
    COUNT(DISTINCT o.id) AS 'Кількість замовлень'
FROM (SELECT o.* FROM orders o WHERE o.status = 'COMPLETED') AS o
JOIN order_items oi ON o.id = oi.order_id
JOIN product p ON oi.product_id = p.id
JOIN product_type pt ON p.product_type_id = pt.id
JOIN manufacturer m ON p.manufacturer_id = m.id
GROUP BY p.name, pt.name, m.name
ORDER BY SUM(oi.quantity) DESC;

-- Аналіз постачальників
SELECT 
    s.name AS 'Постачальник',
    COUNT(DISTINCT d.id) AS 'Кількість поставок',
    SUM(d.total_cost) AS 'Загальна сума поставок',
    COUNT(DISTINCT di.product_id) AS 'Кількість різних товарів',
    AVG(d.total_cost) AS 'Середня сума поставки',
    MAX(d.delivery_date) AS 'Остання поставка'
FROM suppliers s
JOIN deliveries d ON s.id = d.supplier_id
JOIN delivery_items di ON d.id = di.delivery_id
GROUP BY s.name
ORDER BY SUM(d.total_cost) DESC;

-- Топ клієнтів
SELECT 
    c.name AS 'Клієнт',
    COUNT(DISTINCT o.id) AS 'Кількість замовлень',
    SUM(o.total_amount) AS 'Загальна сума замовлень',
    AVG(o.total_amount) AS 'Середній чек',
    MAX(o.order_date) AS 'Останнє замовлення',
    COUNT(DISTINCT oi.product_id) AS 'Кількість різних товарів'
FROM customers c
JOIN orders o ON c.id = o.customer_id AND o.status = 'COMPLETED'
JOIN order_items oi ON o.id = oi.order_id
GROUP BY c.name
ORDER BY SUM(o.total_amount) DESC;


