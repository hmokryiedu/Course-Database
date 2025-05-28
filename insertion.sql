USE Course;

INSERT INTO cities (name) VALUES
	('Дніпро'), ('Київ'), ('Львів'), ('Харків'), ('Одеса'), ('Варшава');

DECLARE
    @dnipro_id TINYINT = (SELECT id FROM cities WHERE name = 'Дніпро'),
    @kyiv_id TINYINT = (SELECT id FROM cities WHERE name = 'Київ'),
    @lviv_id TINYINT = (SELECT id FROM cities WHERE name = 'Львів'),
    @kharkiv_id TINYINT = (SELECT id FROM cities WHERE name = 'Харків'),
    @odesa_id TINYINT = (SELECT id FROM cities WHERE name = 'Одеса'),
    @warsaw_id TINYINT = (SELECT id FROM cities WHERE name = 'Варшава');

INSERT INTO streets (city_id, name) VALUES
	(@dnipro_id, 'Проспект Гагаріна'), (@dnipro_id, 'Проспект Яворницького'), (@dnipro_id, 'Вулиця Набережна Перемоги'),
	(@kyiv_id, 'Вулиця Хрещатик'), (@lviv_id, 'Проспект Свободи'),(@kharkiv_id, 'Вулиця Сумська'),
	(@odesa_id, 'Вулиця Дерибасівська'),(@warsaw_id, 'Вулиця Маршалковська'), (@dnipro_id, 'Вулиця Казакова'),
	(@dnipro_id, 'Вулиця Лазаряна');

DECLARE
    @gagarina_prospect_dnipro_id INT = (SELECT id FROM streets WHERE name = 'Проспект Гагаріна' AND city_id = @dnipro_id),
    @yavornytskoho_prospect_dnipro_id INT = (SELECT id FROM streets WHERE name = 'Проспект Яворницького' AND city_id = @dnipro_id),
    @naberezhna_peremohy_street_dnipro_id INT = (SELECT id FROM streets WHERE name = 'Вулиця Набережна Перемоги' AND city_id = @dnipro_id),
    @khreshchatyk_street_kyiv_id INT = (SELECT id FROM streets WHERE name = 'Вулиця Хрещатик' AND city_id = @kyiv_id),
    @svobody_prospect_lviv_id INT = (SELECT id FROM streets WHERE name = 'Проспект Свободи' AND city_id = @lviv_id),
    @sumska_street_kharkiv_id INT = (SELECT id FROM streets WHERE name = 'Вулиця Сумська' AND city_id = @kharkiv_id),
    @derybasivska_street_odesa_id INT = (SELECT id FROM streets WHERE name = 'Вулиця Дерибасівська' AND city_id = @odesa_id),
    @marshalkowska_street_warsaw_id INT = (SELECT id FROM streets WHERE name = 'Вулиця Маршалковська' AND city_id = @warsaw_id),
	@kazakova_street_dnipro_id INT = (SELECT id FROM streets WHERE name = 'Вулиця Казакова' AND city_id = @dnipro_id),
	@lazaryana_street_dnipro_id INT = (SELECT id FROM streets WHERE name = 'Вулиця Лазаряна' AND city_id = @dnipro_id);


INSERT INTO addresses (street_id, house, postal_code) VALUES
	(@gagarina_prospect_dnipro_id, '72', '49005'),
	(@yavornytskoho_prospect_dnipro_id, '15А', '49000'),
	(@naberezhna_peremohy_street_dnipro_id, '50', '49094'),
	(@gagarina_prospect_dnipro_id, '10', '49005'),
	(@yavornytskoho_prospect_dnipro_id, '20', '49000'),
	(@naberezhna_peremohy_street_dnipro_id, '30', '49094'),
	(@khreshchatyk_street_kyiv_id, '21', '01001'),
	(@khreshchatyk_street_kyiv_id, '30', '01001'),
	(@svobody_prospect_lviv_id, '8', '79008'),
	(@sumska_street_kharkiv_id, '12', '61002'),
	(@derybasivska_street_odesa_id, '5', '65026'),
	(@marshalkowska_street_warsaw_id, '100', '00011'),
	(@kazakova_street_dnipro_id, '20', '49000'),
	(@lazaryana_street_dnipro_id, '20', '49000');


DECLARE
    @addr_Gagarina72_Dnipro_id INT = (SELECT id FROM addresses WHERE street_id = @gagarina_prospect_dnipro_id AND house = '72' AND postal_code = '49005'),
    @addr_Yavor15A_Dnipro_id INT = (SELECT id FROM addresses WHERE street_id = @yavornytskoho_prospect_dnipro_id AND house = '15А' AND postal_code = '49000'),
    @addr_NabPeremohy50_Dnipro_id INT = (SELECT id FROM addresses WHERE street_id = @naberezhna_peremohy_street_dnipro_id AND house = '50' AND postal_code = '49094'),
    @addr_Gagarina10_Dnipro_id INT = (SELECT id FROM addresses WHERE street_id = @gagarina_prospect_dnipro_id AND house = '10' AND postal_code = '49005'),
    @addr_Yavor20_Dnipro_id INT = (SELECT id FROM addresses WHERE street_id = @yavornytskoho_prospect_dnipro_id AND house = '20' AND postal_code = '49000'),
    @addr_NabPeremohy30_Dnipro_id INT = (SELECT id FROM addresses WHERE street_id = @naberezhna_peremohy_street_dnipro_id AND house = '30' AND postal_code = '49094'),
    @addr_Khreshchatyk21_Kyiv_id INT = (SELECT id FROM addresses WHERE street_id = @khreshchatyk_street_kyiv_id AND house = '21' AND postal_code = '01001'),
    @addr_Svobody8_Lviv_id INT = (SELECT id FROM addresses WHERE street_id = @svobody_prospect_lviv_id AND house = '8' AND postal_code = '79008'),
    @addr_Sumska12_Kharkiv_id INT = (SELECT id FROM addresses WHERE street_id = @sumska_street_kharkiv_id AND house = '12' AND postal_code = '61002'),
    @addr_Derybasivska5_Odesa_id INT = (SELECT id FROM addresses WHERE street_id = @derybasivska_street_odesa_id AND house = '5' AND postal_code = '65026'),
    @addr_Marshalkowska100_Warsaw_id INT = (SELECT id FROM addresses WHERE street_id = @marshalkowska_street_warsaw_id AND house = '100' AND postal_code = '00011'),
	@addr_Kazakova20_Dnipro_id INT = (SELECT id FROM addresses WHERE street_id = @kazakova_street_dnipro_id AND house = '20' AND postal_code = '49000'),
	@addr_Lazaryana20_Dnipro_id INT = (SELECT id FROM addresses WHERE street_id = @lazaryana_street_dnipro_id AND house = '20' AND postal_code = '49000');

INSERT INTO persons (address_id, birth_date, name, surname, patronymic, gender) VALUES
	(@addr_Gagarina72_Dnipro_id, '1975-05-20', 'Сергій', 'Петров', 'Іванович', 1),
	(@addr_Yavor15A_Dnipro_id, '1982-11-10', 'Олена', 'Ковальчук', 'Миколаївна', 0),
	(@addr_NabPeremohy50_Dnipro_id, '1978-01-15', 'Віктор', 'Сидоренко', 'Васильович', 1),
	(@addr_Gagarina72_Dnipro_id, '1988-07-01', 'Марія', 'Лисенко', 'Олегівна', 0),
	(@addr_Yavor15A_Dnipro_id, '1990-03-30', 'Андрій', 'Мельник', 'Петрович', 1),
	(@addr_Kazakova20_Dnipro_id, '2003-08-30', 'Максим', 'Іваненко', 'Олегович', 1),
	(@addr_Yavor20_Dnipro_id, '2004-01-15', 'Юлія', 'Шевченко', 'Андріївна', 0),
	(@addr_NabPeremohy30_Dnipro_id, '2003-04-25', 'Дмитро', 'Бондаренко', 'Сергійович', 1),
	(@addr_Gagarina10_Dnipro_id, '2004-05-10', 'Анна', 'Ткаченко', 'Вікторівна', 0),
	(@addr_Kazakova20_Dnipro_id, '2003-11-20', 'Олександр', 'Коваленко', 'Дмитрович', 1),
	(@addr_NabPeremohy30_Dnipro_id, '2004-02-28', 'Марина', 'Кравченко', 'Олексіївна', 0),
	(@addr_Gagarina10_Dnipro_id, '2003-09-12', 'Ігор', 'Олійник', 'Васильович', 1),
	(@addr_Yavor20_Dnipro_id, '2004-07-07', 'Світлана', 'Назаренко', 'Ігорівна', 0),
	(@addr_NabPeremohy30_Dnipro_id, '2003-12-01', 'Володимир', 'Павленко', 'Михайлович', 1),
	(@addr_Gagarina10_Dnipro_id, '2004-06-18', 'Тетяна', 'Марченко', 'Сергіївна', 0),
	(@addr_Yavor20_Dnipro_id, '2003-10-05', 'Артем', 'Геращенко', 'Володимирович', 1),
	(@addr_NabPeremohy30_Dnipro_id, '2004-03-22', 'Надія', 'Федоренко', 'Анатоліївна', 0),
	(@addr_Gagarina10_Dnipro_id, '2003-07-14', 'Роман', 'Литвиненко', 'Юрійович', 1),
	(@addr_Yavor20_Dnipro_id, '2004-08-09', 'Вікторія', 'Шульга', 'Олександрівна', 0),
	(@addr_NabPeremohy30_Dnipro_id, '2003-05-29', 'Микола', 'Захарченко', 'Андрійович', 1),
	(@addr_Gagarina10_Dnipro_id, '2004-09-21', 'Людмила', 'Кириченко', 'Євгенівна', 0),
	(@addr_Yavor20_Dnipro_id, '2003-06-03', 'Євген', 'Поліщук', 'Віталійович', 1),
	(@addr_NabPeremohy30_Dnipro_id, '2004-10-11', 'Ірина', 'Ткачук', 'Борисівна', 0),
	(@addr_Gagarina10_Dnipro_id, '2003-02-17', 'Тарас', 'Савченко', 'Григорович', 1),
	(@addr_Yavor20_Dnipro_id, '2004-12-25', 'Катерина', 'Василенко', 'Петрівна', 0),
	(@addr_Khreshchatyk21_Kyiv_id, '2003-01-05', 'Андрій', 'Гончаренко', 'Сергійович', 1),
	(@addr_Svobody8_Lviv_id, '2004-11-11', 'Оксана', 'Мельник', 'Вікторівна', 0),
	(@addr_Lazaryana20_Dnipro_id, '2003-03-03', 'Денис', 'Козак', 'Ігорович', 1),
	(@addr_Derybasivska5_Odesa_id, '2004-04-04', 'Дарина', 'Мороз', 'Олегівна', 0),
	(@addr_Marshalkowska100_Warsaw_id, '2002-10-10', 'Ян', 'Ковальський', NULL, 1);

DECLARE
    @person_Petrov_S_id INT = (SELECT id FROM persons WHERE surname = 'Петров' AND name = 'Сергій' AND birth_date = '1975-05-20'),
    @person_Kovalchuk_O_id INT = (SELECT id FROM persons WHERE surname = 'Ковальчук' AND name = 'Олена' AND birth_date = '1982-11-10'),
    @person_Sydorenko_V_id INT = (SELECT id FROM persons WHERE surname = 'Сидоренко' AND name = 'Віктор' AND birth_date = '1978-01-15'),
    @person_Lysenko_M_id INT = (SELECT id FROM persons WHERE surname = 'Лисенко' AND name = 'Марія' AND birth_date = '1988-07-01'),
    @person_Melnyk_A_Lec_id INT = (SELECT id FROM persons WHERE surname = 'Мельник' AND name = 'Андрій' AND birth_date = '1990-03-30'),
    @person_Ivanenko_M_id INT = (SELECT id FROM persons WHERE surname = 'Іваненко' AND name = 'Максим' AND birth_date = '2003-08-30'),
    @person_Shevchenko_Y_id INT = (SELECT id FROM persons WHERE surname = 'Шевченко' AND name = 'Юлія' AND birth_date = '2004-01-15'),
    @person_Bondarenko_D_id INT = (SELECT id FROM persons WHERE surname = 'Бондаренко' AND name = 'Дмитро' AND birth_date = '2003-04-25'),
    @person_Tkachenko_A_id INT = (SELECT id FROM persons WHERE surname = 'Ткаченко' AND name = 'Анна' AND birth_date = '2004-05-10'),
    @person_Kovalenko_O_id INT = (SELECT id FROM persons WHERE surname = 'Коваленко' AND name = 'Олександр' AND birth_date = '2003-11-20'),
    @person_Kravchenko_M_id INT = (SELECT id FROM persons WHERE surname = 'Кравченко' AND name = 'Марина' AND birth_date = '2004-02-28'),
    @person_Oliynyk_I_id INT = (SELECT id FROM persons WHERE surname = 'Олійник' AND name = 'Ігор' AND birth_date = '2003-09-12'),
    @person_Nazarenko_S_id INT = (SELECT id FROM persons WHERE surname = 'Назаренко' AND name = 'Світлана' AND birth_date = '2004-07-07'),
    @person_Pavlenko_V_id INT = (SELECT id FROM persons WHERE surname = 'Павленко' AND name = 'Володимир' AND birth_date = '2003-12-01'),
    @person_Marchenko_T_id INT = (SELECT id FROM persons WHERE surname = 'Марченко' AND name = 'Тетяна' AND birth_date = '2004-06-18'),
    @person_Herashchenko_A_id INT = (SELECT id FROM persons WHERE surname = 'Геращенко' AND name = 'Артем' AND birth_date = '2003-10-05'),
    @person_Fedorenko_N_id INT = (SELECT id FROM persons WHERE surname = 'Федоренко' AND name = 'Надія' AND birth_date = '2004-03-22'),
    @person_Lytvynenko_R_id INT = (SELECT id FROM persons WHERE surname = 'Литвиненко' AND name = 'Роман' AND birth_date = '2003-07-14'),
    @person_Shulha_V_id INT = (SELECT id FROM persons WHERE surname = 'Шульга' AND name = 'Вікторія' AND birth_date = '2004-08-09'),
    @person_Zakharchenko_M_id INT = (SELECT id FROM persons WHERE surname = 'Захарченко' AND name = 'Микола' AND birth_date = '2003-05-29'),
    @person_Kyrychenko_L_id INT = (SELECT id FROM persons WHERE surname = 'Кириченко' AND name = 'Людмила' AND birth_date = '2004-09-21'),
    @person_Polishchuk_Y_id INT = (SELECT id FROM persons WHERE surname = 'Поліщук' AND name = 'Євген' AND birth_date = '2003-06-03'),
    @person_Tkachuk_I_id INT = (SELECT id FROM persons WHERE surname = 'Ткачук' AND name = 'Ірина' AND birth_date = '2004-10-11'),
    @person_Savchenko_T_id INT = (SELECT id FROM persons WHERE surname = 'Савченко' AND name = 'Тарас' AND birth_date = '2003-02-17'),
    @person_Vasylenko_K_id INT = (SELECT id FROM persons WHERE surname = 'Василенко' AND name = 'Катерина' AND birth_date = '2004-12-25'),
    @person_Honcharenko_A_id INT = (SELECT id FROM persons WHERE surname = 'Гончаренко' AND name = 'Андрій' AND birth_date = '2003-01-05'),
    @person_Melnyk_O_Stu_id INT = (SELECT id FROM persons WHERE surname = 'Мельник' AND name = 'Оксана' AND birth_date = '2004-11-11'),
    @person_Kozak_D_id INT = (SELECT id FROM persons WHERE surname = 'Козак' AND name = 'Денис' AND birth_date = '2003-03-03'),
    @person_Moroz_D_id INT = (SELECT id FROM persons WHERE surname = 'Мороз' AND name = 'Дарина' AND birth_date = '2004-04-04'),
    @person_Kowalski_Y_id INT = (SELECT id FROM persons WHERE surname = 'Ковальський' AND name = 'Ян' AND birth_date = '2002-10-10');

INSERT INTO phones (phone_number) VALUES
	('380501112233'),
	('380674445566'),
	('380931234567'),
	('380509876543'),
	('380995554433'),
	('380997778899'),
	('380631234567'),
	('380681112233'),
	('380952223344'),
	('380673334455'),
	('48600100200');

DECLARE
    @phone_Petrov_S_id INT = (SELECT id FROM phones WHERE phone_number = '380501112233'),
    @phone_Kovalchuk_O_id INT = (SELECT id FROM phones WHERE phone_number = '380674445566'),
    @phone_Sydorenko_V_id INT = (SELECT id FROM phones WHERE phone_number = '380931234567'),
    @phone_Lysenko_M_id INT = (SELECT id FROM phones WHERE phone_number = '380509876543'),
    @phone_Melnyk_A_Lec_id INT = (SELECT id FROM phones WHERE phone_number = '380995554433'),
    @phone_Ivanenko_M_id INT = (SELECT id FROM phones WHERE phone_number = '380997778899'),
    @phone_Shevchenko_Y_id INT = (SELECT id FROM phones WHERE phone_number = '380631234567'),
    @phone_Bondarenko_D_id INT = (SELECT id FROM phones WHERE phone_number = '380681112233'),
    @phone_Tkachenko_A_id INT = (SELECT id FROM phones WHERE phone_number = '380952223344'),
    @phone_Kovalenko_O_id INT = (SELECT id FROM phones WHERE phone_number = '380673334455'),
    @phone_Kowalski_Y_id INT = (SELECT id FROM phones WHERE phone_number = '48600100200');

INSERT INTO person_phones (person_id, phone_id) VALUES
	(@person_Petrov_S_id, @phone_Petrov_S_id),
	(@person_Kovalchuk_O_id, @phone_Kovalchuk_O_id),
	(@person_Sydorenko_V_id, @phone_Sydorenko_V_id),
	(@person_Lysenko_M_id, @phone_Lysenko_M_id),
	(@person_Melnyk_A_Lec_id, @phone_Melnyk_A_Lec_id),
	(@person_Ivanenko_M_id, @phone_Ivanenko_M_id),
	(@person_Shevchenko_Y_id, @phone_Shevchenko_Y_id),
	(@person_Bondarenko_D_id, @phone_Bondarenko_D_id),
	(@person_Tkachenko_A_id, @phone_Tkachenko_A_id),
	(@person_Kovalenko_O_id, @phone_Kovalenko_O_id),
	(@person_Kowalski_Y_id, @phone_Kowalski_Y_id);

INSERT INTO passports (person_id, series, number, issue_date, issue_place) VALUES
	(@person_Petrov_S_id, 'KT', '123456', '1995-05-20', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Kovalchuk_O_id, 'KT', '234567', '2000-11-10', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Sydorenko_V_id, 'KT', '345678', '1996-01-15', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Lysenko_M_id, 'KT', '456789', '2006-07-01', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Melnyk_A_Lec_id, 'KT', '567890', '2008-03-30', 'Дніпровський РВ ГУМВС України в Дніпропетровській області');

INSERT INTO id_cards (person_id, number, issue_date, expiration_date, issue_place) VALUES
	(@person_Ivanenko_M_id, '123456789', '2021-08-30', '2026-08-30', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Shevchenko_Y_id, '234567890', '2022-01-15', '2027-01-15', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Bondarenko_D_id, '345678901', '2021-04-25', '2026-04-25', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Tkachenko_A_id, '456789012', '2022-05-10', '2027-05-10', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Kovalenko_O_id, '567890123', '2021-11-20', '2026-11-20', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Kravchenko_M_id, '678901234', '2022-02-28', '2027-02-28', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Oliynyk_I_id, '789012345', '2021-09-12', '2026-09-12', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Nazarenko_S_id, '890123456', '2022-07-07', '2027-07-07', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Pavlenko_V_id, '901234567', '2021-12-01', '2026-12-01', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Marchenko_T_id, '012345678', '2022-06-18', '2027-06-18', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Herashchenko_A_id, '123456780', '2021-10-05', '2026-10-05', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Fedorenko_N_id, '234567801', '2022-03-22', '2027-03-22', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Lytvynenko_R_id, '345678012', '2021-07-14', '2026-07-14', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Shulha_V_id, '456780123', '2022-08-09', '2027-08-09', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Zakharchenko_M_id, '567801234', '2021-05-29', '2026-05-29', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Kyrychenko_L_id, '678012345', '2022-09-21', '2027-09-21', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Polishchuk_Y_id, '780123456', '2021-06-03', '2026-06-03', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Tkachuk_I_id, '801234567', '2022-10-11', '2027-10-11', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Savchenko_T_id, '012345670', '2021-02-17', '2026-02-17', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Vasylenko_K_id, '123456701', '2022-12-25', '2027-12-25', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Honcharenko_A_id, '234567012', '2021-01-05', '2026-01-05', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Melnyk_O_Stu_id, '345670123', '2022-11-11', '2027-11-11', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Kozak_D_id, '456701234', '2021-03-03', '2026-03-03', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Moroz_D_id, '567012345', '2022-04-04', '2027-04-04', 'Дніпровський РВ ГУМВС України в Дніпропетровській області'),
	(@person_Kowalski_Y_id, '670123456', '2020-10-10', '2025-10-10', 'Варшавський РВ ГУМВС Польщі');