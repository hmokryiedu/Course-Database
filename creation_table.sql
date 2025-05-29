USE Course

EXEC drop_table 'order_items';
EXEC drop_table 'orders';
EXEC drop_table 'deliveries';
EXEC drop_table 'delivery_methods';
EXEC drop_table 'employees';
EXEC drop_table 'position_requirements';
EXEC drop_table 'position_responsibilities';
EXEC drop_table 'requirements';
EXEC drop_table 'responsibilities';
EXEC drop_table 'positions';
EXEC drop_table 'id_cards';
EXEC drop_table 'passports';
EXEC drop_table 'person_phones';
EXEC drop_table 'persons';
EXEC drop_table 'addresses';
EXEC drop_table 'streets';
EXEC drop_table 'cities';
EXEC drop_table 'phones';
EXEC drop_table 'suppliers';
EXEC drop_table 'customers';
EXEC drop_table 'delivery_items';
EXEC drop_table 'product';
EXEC drop_table 'product_type';
EXEC drop_table 'packaging';
EXEC drop_table 'manufacturer';
EXEC drop_table 'warehouse_stock';

CREATE TABLE cities (
    id TINYINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE streets (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    city_id TINYINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    FOREIGN KEY (city_id) REFERENCES cities (id) ON DELETE CASCADE,
    UNIQUE(city_id, name)
);

CREATE TABLE addresses (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    street_id INT NOT NULL,
    house VARCHAR(5) NOT NULL,
    postal_code VARCHAR(6) NOT NULL,
    apartment VARCHAR(10) NULL,
    FOREIGN KEY (street_id) REFERENCES streets (id) ON DELETE CASCADE,
    UNIQUE(street_id, house, postal_code)
);

CREATE TABLE phones (
    id INT IDENTITY(1,1) PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE persons (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    address_id INT NOT NULL,
    birth_date DATE NOT NULL,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    patronymic VARCHAR(50),
    gender BIT NOT NULL,
    FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE CASCADE
);

CREATE TABLE person_phones (
    person_id INT NOT NULL,
    phone_id INT NOT NULL,
    PRIMARY KEY (person_id, phone_id),
    FOREIGN KEY (person_id) REFERENCES persons (id) ON DELETE CASCADE,
    FOREIGN KEY (phone_id) REFERENCES phones (id) ON DELETE CASCADE
);

CREATE TABLE passports (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    person_id INT NOT NULL,
    series VARCHAR(2) NOT NULL,
    number VARCHAR(6) NOT NULL,
    issue_date DATE NOT NULL,
    issue_place VARCHAR(100) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES persons (id) ON DELETE CASCADE,
    UNIQUE(person_id),
    UNIQUE(series, number),
    CONSTRAINT chk_passport_format CHECK (
        series LIKE '[A-Z][A-Z]' AND 
        number LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]'
    )
);

CREATE TABLE id_cards (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    person_id INT NOT NULL,
    number VARCHAR(9) NOT NULL,
    issue_date DATE NOT NULL,
    expiration_date DATE NOT NULL,
    issue_place VARCHAR(100) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES persons (id) ON DELETE CASCADE,
    UNIQUE(person_id),
    UNIQUE(number),
    CONSTRAINT chk_id_card_format CHECK (
        number LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    ),
    CONSTRAINT chk_expiration_date CHECK (
        expiration_date > issue_date
    )
);

CREATE TABLE positions (
    id SMALLINT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

CREATE TABLE employees (
    id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    person_id INT NOT NULL,
    position_id SMALLINT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (person_id) REFERENCES persons(id) ON DELETE CASCADE,
    FOREIGN KEY (position_id) REFERENCES positions(id) ON DELETE CASCADE,
    UNIQUE(person_id),
    CONSTRAINT chk_employment_dates CHECK (end_date IS NULL OR end_date > start_date)
);

CREATE TABLE responsibilities (
    id SMALLINT PRIMARY KEY IDENTITY(1,1),
    description VARCHAR(MAX) NOT NULL
);

CREATE TABLE requirements (
    id SMALLINT PRIMARY KEY IDENTITY(1,1),
    description VARCHAR(MAX) NOT NULL
);

CREATE TABLE position_responsibilities (
    position_id SMALLINT,
    responsibility_id SMALLINT,
    PRIMARY KEY (position_id, responsibility_id),
    FOREIGN KEY (position_id) REFERENCES positions(id),
    FOREIGN KEY (responsibility_id) REFERENCES responsibilities(id)
);

CREATE TABLE position_requirements (
    position_id SMALLINT,
    requirement_id SMALLINT,
    PRIMARY KEY (position_id, requirement_id),
    FOREIGN KEY (position_id) REFERENCES positions(id),
    FOREIGN KEY (requirement_id) REFERENCES requirements(id)
);

CREATE TABLE suppliers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address_id INT NOT NULL,
    phone_id INT NOT NULL,
    responsible_person_id INT NOT NULL,
    notes VARCHAR(200) NOT NULL,
    FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE CASCADE,
    FOREIGN KEY (phone_id) REFERENCES phones (id) ON DELETE CASCADE
);

CREATE TABLE customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address_id INT NOT NULL,
    phone_id INT NOT NULL,
    responsible_person_id INT NOT NULL,
    FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE CASCADE,
    FOREIGN KEY (phone_id) REFERENCES phones (id) ON DELETE CASCADE
);

CREATE TABLE delivery_methods (
    id TINYINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE deliveries (
    id INT IDENTITY(1,1) PRIMARY KEY,
    delivery_date DATE NOT NULL,
    delivery_document_number VARCHAR(50) NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    delivery_method_id TINYINT NOT NULL,
    supplier_id INT NOT NULL,
    employee_id INT NOT NULL,
    notes VARCHAR(500),
    FOREIGN KEY (delivery_method_id) REFERENCES delivery_methods (id) ON DELETE NO ACTION,
    FOREIGN KEY (supplier_id) REFERENCES suppliers (id) ON DELETE NO ACTION,
    FOREIGN KEY (employee_id) REFERENCES employees (id) ON DELETE NO ACTION
);

CREATE TABLE manufacturer (
    id SMALLINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_id INT NOT NULL,
    city_id TINYINT NOT NULL,
    responsible_person_id INT NOT NULL,
    FOREIGN KEY (phone_id) REFERENCES phones(id) ON DELETE NO ACTION,
    FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE NO ACTION,
    FOREIGN KEY (responsible_person_id) REFERENCES persons(id) ON DELETE NO ACTION
);

CREATE TABLE packaging (
    id TINYINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500) NOT NULL
);

CREATE TABLE product_type (
    id TINYINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500) NOT NULL,
    characteristics VARCHAR(1000) NOT NULL
);

CREATE TABLE product (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    product_type_id TINYINT NOT NULL,
    manufacturer_id SMALLINT NOT NULL,
    storage_conditions VARCHAR(500) NOT NULL,
    packaging_id TINYINT NOT NULL,
    created_at DATE NOT NULL DEFAULT GETDATE(),
    expiration_at DATE,
    FOREIGN KEY (product_type_id) REFERENCES product_type(id),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(id),
    FOREIGN KEY (packaging_id) REFERENCES packaging(id),
    CONSTRAINT chk_product_dates CHECK (expiration_at IS NULL OR expiration_at > created_at)
);

CREATE TABLE delivery_items (
    delivery_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price AS (quantity * unit_price),
    PRIMARY KEY (delivery_id, product_id),
    FOREIGN KEY (delivery_id) REFERENCES deliveries(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    CONSTRAINT chk_positive_quantity CHECK (quantity > 0),
    CONSTRAINT chk_positive_unit_price CHECK (unit_price >= 0)
);

CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_date DATE NOT NULL DEFAULT GETDATE(),
    customer_id INT NOT NULL,
    delivery_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'NEW',
    notes VARCHAR(500),
    created_at DATE NOT NULL DEFAULT GETDATE(),
    updated_at DATE NOT NULL DEFAULT GETDATE(),
    created_by INT NOT NULL,
    updated_by INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE NO ACTION,
    FOREIGN KEY (delivery_id) REFERENCES deliveries(id) ON DELETE NO ACTION,
    FOREIGN KEY (created_by) REFERENCES employees(id) ON DELETE NO ACTION,
    FOREIGN KEY (updated_by) REFERENCES employees(id) ON DELETE NO ACTION,
    CONSTRAINT chk_order_status CHECK (status IN ('NEW', 'PROCESSING', 'COMPLETED', 'CANCELLED'))
);

CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price AS (quantity * unit_price),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    CONSTRAINT chk_positive_order_quantity CHECK (quantity > 0),
    CONSTRAINT chk_positive_order_unit_price CHECK (unit_price >= 0)
);

CREATE TABLE warehouse_stock (
    product_id INT NOT NULL PRIMARY KEY,
    current_quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
    CONSTRAINT chk_positive_stock_quantity CHECK (current_quantity >= 0)
);

GO

CREATE TRIGGER trg_prevent_dual_documents_passport
ON passports
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN id_cards ic ON i.person_id = ic.person_id
    )
    BEGIN
        RAISERROR ('Person cannot have both passport and ID card', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

GO

CREATE TRIGGER trg_prevent_dual_documents_id_card
ON id_cards
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN passports p ON i.person_id = p.person_id
    )
    BEGIN
        RAISERROR ('Person cannot have both passport and ID card', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

GO

CREATE TRIGGER trg_delete_deliveries_on_delivery_method_delete
ON delivery_methods
AFTER DELETE
AS
BEGIN
    DELETE FROM deliveries WHERE delivery_method_id IN (SELECT id FROM deleted)
END;

GO

CREATE TRIGGER trg_delete_deliveries_on_supplier_delete
ON suppliers
AFTER DELETE
AS
BEGIN
    DELETE FROM deliveries WHERE supplier_id IN (SELECT id FROM deleted)
END;

GO

CREATE TRIGGER trg_delete_deliveries_on_employee_delete
ON employees
AFTER DELETE
AS
BEGIN
    DELETE FROM deliveries WHERE employee_id IN (SELECT id FROM deleted)
END;

GO

CREATE TRIGGER trg_update_stock_on_delivery
ON delivery_items
AFTER INSERT
AS
BEGIN
    MERGE warehouse_stock AS target
    USING (
        SELECT product_id, SUM(quantity) as total_quantity
        FROM inserted
        GROUP BY product_id
    ) AS source
    ON (target.product_id = source.product_id)
    WHEN MATCHED THEN
        UPDATE SET current_quantity = target.current_quantity + source.total_quantity
    WHEN NOT MATCHED THEN
        INSERT (product_id, current_quantity)
        VALUES (source.product_id, source.total_quantity);
END;

GO

CREATE TRIGGER trg_update_stock_on_order
ON order_items
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN warehouse_stock ws ON i.product_id = ws.product_id
        WHERE ws.current_quantity < i.quantity
    )
    BEGIN
        RAISERROR ('Недостатня кількість товару на складі', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
    
    UPDATE ws
    SET current_quantity = ws.current_quantity - i.quantity
    FROM warehouse_stock ws
    INNER JOIN inserted i ON ws.product_id = i.product_id;
END;