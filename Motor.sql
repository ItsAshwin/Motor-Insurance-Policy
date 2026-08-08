CREATE DATABASE motor_db;

USE motor_db;

CREATE TABLE mi_region (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50)
);

CREATE TABLE mi_state (
    state_id INT AUTO_INCREMENT PRIMARY KEY,
    region_id INT NOT NULL,
    state_name VARCHAR(50) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_state_region
        FOREIGN KEY (region_id)
        REFERENCES mi_region(region_id),

    CONSTRAINT uq_state
        UNIQUE(state_name, region_id)
);

CREATE TABLE mi_city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    state_id INT NOT NULL,
    city_name VARCHAR(50) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_city_state
        FOREIGN KEY (state_id)
        REFERENCES mi_state(state_id),

    CONSTRAINT uq_city
        UNIQUE(city_name, state_id)
);

CREATE TABLE mi_make (
    make_id INT AUTO_INCREMENT PRIMARY KEY,
    make_desc VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50)
);

CREATE TABLE mi_model (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    make_id INT NOT NULL,
    model_desc VARCHAR(100) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_model_make
        FOREIGN KEY (make_id)
        REFERENCES mi_make(make_id),

    CONSTRAINT uq_model
        UNIQUE(make_id, model_desc)
);

CREATE TABLE mi_vehicle_color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50)
);

CREATE TABLE mi_vehicle_body (
    body_id INT AUTO_INCREMENT PRIMARY KEY,
    body_name VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50)
);

CREATE TABLE mi_vehicle_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50)
);

CREATE TABLE mi_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    cover_type VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50)
);

CREATE TABLE mi_lov (
    lov_id INT AUTO_INCREMENT PRIMARY KEY,
    lov_type VARCHAR(50) NOT NULL,
    lov_value VARCHAR(100) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT uq_lov UNIQUE(lov_type, lov_value)
);

CREATE TABLE mi_user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_type VARCHAR(30) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    gender INT NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    marital_status INT,
    education INT,
    phone VARCHAR(20) NOT NULL,
    mobile VARCHAR(20),
    addr1 VARCHAR(100),
    addr2 VARCHAR(100),
    addr3 VARCHAR(100),
    street VARCHAR(100),
    city_id INT NOT NULL,
    state_id INT NOT NULL,
    nationality INT,
    national_id VARCHAR(30) NOT NULL UNIQUE,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_user_city
        FOREIGN KEY(city_id)
        REFERENCES mi_city(city_id),

    CONSTRAINT fk_user_state
        FOREIGN KEY(state_id)
        REFERENCES mi_state(state_id),

    CONSTRAINT fk_user_gender
        FOREIGN KEY(gender)
        REFERENCES mi_lov(lov_id),

    CONSTRAINT fk_user_marital
        FOREIGN KEY(marital_status)
        REFERENCES mi_lov(lov_id),

    CONSTRAINT fk_user_education
        FOREIGN KEY(education)
        REFERENCES mi_lov(lov_id),

    CONSTRAINT fk_user_nationality
        FOREIGN KEY(nationality)
        REFERENCES mi_lov(lov_id)
);

CREATE TABLE mi_login (
    login_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    lead_id INT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    user_type VARCHAR(30) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_login_user
        FOREIGN KEY(user_id)
        REFERENCES mi_user(user_id),

    CONSTRAINT fk_login_lead
        FOREIGN KEY(lead_id)
        REFERENCES mi_user(user_id)
);

CREATE TABLE mi_broker (
    broker_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    broker_name VARCHAR(100) NOT NULL,
    broker_org_name VARCHAR(150) NOT NULL,
    license_no VARCHAR(50) UNIQUE,
    contact_no VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(200),
    credit_balance DECIMAL(12,2) DEFAULT 0.00,
    commission_percent DECIMAL(5,2),
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_broker_user
        FOREIGN KEY(user_id)
        REFERENCES mi_user(user_id)
);

CREATE TABLE mi_vehicle (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    make_id INT NOT NULL,
    model_id INT NOT NULL,
    color_id INT NOT NULL,
    body_id INT NOT NULL,
    category_id INT NOT NULL,
    registration_no VARCHAR(20) NOT NULL UNIQUE,
    engine_no VARCHAR(50) NOT NULL UNIQUE,
    chassis_no VARCHAR(50) NOT NULL UNIQUE,
    manufacture_year YEAR NOT NULL,
    insured_value DECIMAL(12,2) NOT NULL,
    status VARCHAR(10) DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_vehicle_user FOREIGN KEY (user_id)
        REFERENCES mi_user(user_id),

    CONSTRAINT fk_vehicle_make FOREIGN KEY (make_id)
        REFERENCES mi_make(make_id),

    CONSTRAINT fk_vehicle_model FOREIGN KEY (model_id)
        REFERENCES mi_model(model_id),

    CONSTRAINT fk_vehicle_color FOREIGN KEY (color_id)
        REFERENCES mi_vehicle_color(color_id),

    CONSTRAINT fk_vehicle_body FOREIGN KEY (body_id)
        REFERENCES mi_vehicle_body(body_id),

    CONSTRAINT fk_vehicle_category FOREIGN KEY (category_id)
        REFERENCES mi_vehicle_category(category_id)
);


CREATE TABLE mi_quote (
    quote_id INT AUTO_INCREMENT PRIMARY KEY,
    quote_no VARCHAR(30) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    broker_id INT,
    vehicle_id INT NOT NULL,
    product_id INT NOT NULL,
    cover_type VARCHAR(50) NOT NULL,
    policy_period INT NOT NULL,
    quote_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_quote_user
        FOREIGN KEY (user_id)
        REFERENCES mi_user(user_id),

    CONSTRAINT fk_quote_broker
        FOREIGN KEY (broker_id)
        REFERENCES mi_broker(broker_id),

    CONSTRAINT fk_quote_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES mi_vehicle(vehicle_id),

    CONSTRAINT fk_quote_product
        FOREIGN KEY (product_id)
        REFERENCES mi_product(product_id)
);

CREATE TABLE mi_premium_rate (
    rate_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    min_value DECIMAL(12,2),
    max_value DECIMAL(12,2),
    premium_percent DECIMAL(5,2) NOT NULL,
    tax_percent DECIMAL(5,2) NOT NULL,
    effective_date DATE NOT NULL,
    expiry_date DATE,
    status VARCHAR(10) DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_rate_product
        FOREIGN KEY (product_id)
        REFERENCES mi_product(product_id),

    CONSTRAINT fk_rate_category
        FOREIGN KEY (category_id)
        REFERENCES mi_vehicle_category(category_id)
);

CREATE TABLE mi_broker_commission (
    commission_id INT AUTO_INCREMENT PRIMARY KEY,
    broker_id INT NOT NULL,
    product_id INT NOT NULL,
    commission_percent DECIMAL(5,2) NOT NULL,
    effective_date DATE NOT NULL,
    expiry_date DATE,
    status VARCHAR(10) DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_commission_broker
        FOREIGN KEY (broker_id)
        REFERENCES mi_broker(broker_id),

    CONSTRAINT fk_commission_product
        FOREIGN KEY (product_id)
        REFERENCES mi_product(product_id)
);

CREATE TABLE mi_quote_premium (
    premium_id INT AUTO_INCREMENT PRIMARY KEY,
    quote_id INT NOT NULL,
    basic_premium DECIMAL(12,2) NOT NULL,
    addon_amount DECIMAL(12,2) DEFAULT 0,
    tax_amount DECIMAL(12,2) DEFAULT 0,
    total_premium DECIMAL(12,2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'MYR',
    calculated_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_quotepremium_quote
        FOREIGN KEY (quote_id)
        REFERENCES mi_quote(quote_id)
);

CREATE TABLE mi_policy (
    policy_id INT AUTO_INCREMENT PRIMARY KEY,
    policy_no VARCHAR(30) NOT NULL UNIQUE,
    quote_id INT NOT NULL,
    premium_id INT NOT NULL,
    issue_date DATE NOT NULL,
    start_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'PAID',
    policy_status VARCHAR(20) DEFAULT 'ACTIVE',
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_by VARCHAR(50),

    CONSTRAINT fk_policy_quote
        FOREIGN KEY (quote_id)
        REFERENCES mi_quote(quote_id),

    CONSTRAINT fk_policy_premium
        FOREIGN KEY (premium_id)
        REFERENCES mi_quote_premium(premium_id)
);

INSERT INTO mi_region (region_name, added_by) VALUES
('North','Admin'),
('South','Admin'),
('East','Admin'),
('West','Admin'),
('Central','Admin'),
('North East','Admin'),
('North West','Admin'),
('South East','Admin'),
('South West','Admin'),
('Federal','Admin');

INSERT INTO mi_state (region_id, state_name, added_by) VALUES
(1,'Perlis','Admin'),
(1,'Kedah','Admin'),
(2,'Johor','Admin'),
(2,'Melaka','Admin'),
(3,'Sabah','Admin'),
(3,'Sarawak','Admin'),
(4,'Selangor','Admin'),
(4,'Perak','Admin'),
(5,'Negeri Sembilan','Admin'),
(5,'Pahang','Admin'),
(6,'Kelantan','Admin'),
(6,'Terengganu','Admin'),
(7,'Penang','Admin'),
(8,'Labuan','Admin'),
(9,'Putrajaya','Admin'),
(10,'Kuala Lumpur','Admin');

INSERT INTO mi_city (state_id, city_name, added_by) VALUES
(1,'Kangar','Admin'),
(2,'Alor Setar','Admin'),
(3,'Johor Bahru','Admin'),
(4,'Melaka City','Admin'),
(5,'Kota Kinabalu','Admin'),
(6,'Kuching','Admin'),
(7,'Shah Alam','Admin'),
(8,'Ipoh','Admin'),
(9,'Seremban','Admin'),
(10,'Kuantan','Admin'),
(11,'Kota Bharu','Admin'),
(12,'Kuala Terengganu','Admin'),
(13,'George Town','Admin'),
(14,'Victoria','Admin'),
(15,'Putrajaya','Admin'),
(16,'Kuala Lumpur','Admin');

INSERT INTO mi_make (make_desc, added_by) VALUES
('Toyota','Admin'),
('Honda','Admin'),
('Proton','Admin'),
('Perodua','Admin'),
('Nissan','Admin'),
('Mazda','Admin'),
('BMW','Admin'),
('Mercedes-Benz','Admin'),
('Hyundai','Admin'),
('Kia','Admin'),
('Mitsubishi','Admin'),
('Isuzu','Admin'),
('Ford','Admin'),
('Volkswagen','Admin'),
('Audi','Admin');

INSERT INTO mi_model (make_id, model_desc, added_by) VALUES
(1,'Vios','Admin'),
(1,'Corolla','Admin'),
(2,'City','Admin'),
(2,'Civic','Admin'),
(3,'Saga','Admin'),
(3,'X50','Admin'),
(4,'Myvi','Admin'),
(4,'Bezza','Admin'),
(5,'Almera','Admin'),
(6,'CX-5','Admin'),
(7,'X5','Admin'),
(8,'C200','Admin'),
(9,'Elantra','Admin'),
(10,'Sportage','Admin'),
(11,'Triton','Admin');

INSERT INTO mi_vehicle_color (color_name, added_by) VALUES
('White','Admin'),
('Black','Admin'),
('Silver','Admin'),
('Grey','Admin'),
('Blue','Admin'),
('Red','Admin'),
('Green','Admin'),
('Yellow','Admin'),
('Brown','Admin'),
('Orange','Admin'),
('Purple','Admin'),
('Gold','Admin'),
('Maroon','Admin'),
('Pearl White','Admin'),
('Metallic Grey','Admin');

INSERT INTO mi_vehicle_body (body_name, added_by) VALUES
('Sedan','Admin'),
('SUV','Admin'),
('Hatchback','Admin'),
('Coupe','Admin'),
('Pickup','Admin'),
('Van','Admin'),
('Bus','Admin'),
('Truck','Admin'),
('Wagon','Admin'),
('Jeep','Admin'),
('Convertible','Admin'),
('MPV','Admin'),
('Mini Truck','Admin'),
('Limousine','Admin'),
('Crossover','Admin');

INSERT INTO mi_vehicle_category (category_name, added_by) VALUES
('Private','Admin'),
('Commercial','Admin'),
('Taxi','Admin'),
('Motorcycle','Admin'),
('Sports','Admin'),
('Government','Admin'),
('Rental','Admin'),
('School Bus','Admin'),
('Tour Bus','Admin'),
('Goods Carrier','Admin'),
('Emergency','Admin'),
('Agriculture','Admin'),
('Construction','Admin'),
('Luxury','Admin'),
('Electric','Admin');

INSERT INTO mi_product
(product_name, cover_type, description, added_by)
VALUES
('Comprehensive Cover','Comprehensive','Full vehicle protection','Admin'),
('Third Party Cover','TPL','Third party liability only','Admin'),
('Fire and Theft','Comprehensive','Fire and theft protection','Admin'),
('Commercial Vehicle','Commercial','Commercial vehicle insurance','Admin'),
('Motorcycle Cover','Motorcycle','Insurance for motorcycles','Admin'),
('Luxury Vehicle','Comprehensive','Luxury vehicle insurance','Admin'),
('Electric Vehicle','Comprehensive','EV insurance','Admin'),
('Taxi Cover','Commercial','Taxi insurance','Admin'),
('Bus Cover','Commercial','Bus insurance','Admin'),
('Truck Cover','Commercial','Truck insurance','Admin'),
('Family Package','Comprehensive','Family protection','Admin'),
('Premium Plus','Comprehensive','Premium insurance plan','Admin'),
('Basic Plan','TPL','Basic insurance','Admin'),
('Corporate Fleet','Commercial','Fleet insurance','Admin'),
('Special Cover','Comprehensive','Special coverage plan','Admin');

INSERT INTO mi_lov (lov_type, lov_value, added_by) VALUES
('Gender','Male','Admin'),
('Gender','Female','Admin'),
('Marital Status','Single','Admin'),
('Marital Status','Married','Admin'),
('Education','SPM','Admin'),
('Education','Diploma','Admin'),
('Education','Degree','Admin'),
('Education','Master','Admin'),
('Nationality','Malaysian','Admin'),
('Nationality','Foreigner','Admin'),
('User Type','Admin','Admin'),
('User Type','Broker','Admin'),
('User Type','Sales Agent','Admin'),
('User Type','Operational User','Admin'),
('User Type','Underwriter','Admin');

INSERT INTO mi_user
(user_type, first_name, last_name, gender, dob, email,
marital_status, education, phone, mobile,
addr1, addr2, addr3, street,
city_id, state_id, nationality, national_id,
status, added_by)
VALUES
('Customer','John','Doe',1,'1995-05-10','john1@gmail.com',3,7,'041111111','0111111111','House 1','Area A','Block A','Street 1',1,1,9,'900101010001','ACTIVE','Admin'),
('Customer','Ali','Ahmad',1,'1992-03-15','ali@gmail.com',4,6,'041111112','0111111112','House 2','Area B','Block B','Street 2',2,2,9,'900101010002','ACTIVE','Admin'),
('Customer','Siti','Aminah',2,'1998-07-22','siti@gmail.com',3,7,'041111113','0111111113','House 3','Area C','Block C','Street 3',3,3,9,'900101010003','ACTIVE','Admin'),
('Broker','David','Lee',1,'1988-04-20','david@gmail.com',4,8,'041111114','0111111114','House 4','Area D','Block D','Street 4',4,4,10,'900101010004','ACTIVE','Admin'),
('Customer','Sarah','Tan',2,'1996-08-15','sarah@gmail.com',3,7,'041111115','0111111115','House 5','Area E','Block E','Street 5',5,5,9,'900101010005','ACTIVE','Admin'),
('Customer','James','Lim',1,'1990-09-12','james@gmail.com',4,8,'041111116','0111111116','House 6','Area F','Block F','Street 6',6,6,9,'900101010006','ACTIVE','Admin'),
('Customer','Ravi','Kumar',1,'1991-11-18','ravi@gmail.com',3,6,'041111117','0111111117','House 7','Area G','Block G','Street 7',7,7,9,'900101010007','ACTIVE','Admin'),
('Customer','Priya','Nair',2,'1994-01-25','priya@gmail.com',4,7,'041111118','0111111118','House 8','Area H','Block H','Street 8',8,8,9,'900101010008','ACTIVE','Admin'),
('Broker','Michael','Wong',1,'1987-06-11','michael@gmail.com',4,8,'041111119','0111111119','House 9','Area I','Block I','Street 9',9,9,10,'900101010009','ACTIVE','Admin'),
('Customer','Aisyah','Rahman',2,'1999-10-05','aisyah@gmail.com',3,7,'041111120','0111111120','House 10','Area J','Block J','Street 10',10,10,9,'900101010010','ACTIVE','Admin'),
('Customer','Kevin','Ng',1,'1993-02-17','kevin@gmail.com',3,7,'041111121','0111111121','House 11','Area K','Block K','Street 11',11,11,9,'900101010011','ACTIVE','Admin'),
('Customer','Nurul','Hassan',2,'1997-12-08','nurul@gmail.com',3,6,'041111122','0111111122','House 12','Area L','Block L','Street 12',12,12,9,'900101010012','ACTIVE','Admin'),
('Customer','Daniel','Chong',1,'1989-03-19','daniel@gmail.com',4,8,'041111123','0111111123','House 13','Area M','Block M','Street 13',13,13,9,'900101010013','ACTIVE','Admin'),
('Customer','Farah','Ismail',2,'1995-04-24','farah@gmail.com',3,7,'041111124','0111111124','House 14','Area N','Block N','Street 14',14,14,9,'900101010014','ACTIVE','Admin'),
('Broker','Henry','Tan',1,'1986-07-30','henry@gmail.com',4,8,'041111125','0111111125','House 15','Area O','Block O','Street 15',15,15,10,'900101010015','ACTIVE','Admin');

INSERT INTO mi_login
(user_id, lead_id, username, password, user_type, status, added_by)
VALUES
(1,NULL,'john01',SHA2('john123',256),'Customer','ACTIVE','Admin'),
(2,NULL,'ali01',SHA2('ali123',256),'Customer','ACTIVE','Admin'),
(3,NULL,'siti01',SHA2('siti123',256),'Customer','ACTIVE','Admin'),
(4,NULL,'david01',SHA2('david123',256),'Broker','ACTIVE','Admin'),
(5,NULL,'sarah01',SHA2('sarah123',256),'Customer','ACTIVE','Admin'),
(6,NULL,'james01',SHA2('james123',256),'Customer','ACTIVE','Admin'),
(7,NULL,'ravi01',SHA2('ravi123',256),'Customer','ACTIVE','Admin'),
(8,NULL,'priya01',SHA2('priya123',256),'Customer','ACTIVE','Admin'),
(9,NULL,'michael01',SHA2('michael123',256),'Broker','ACTIVE','Admin'),
(10,NULL,'aisyah01',SHA2('aisyah123',256),'Customer','ACTIVE','Admin'),
(11,NULL,'kevin01',SHA2('kevin123',256),'Customer','ACTIVE','Admin'),
(12,NULL,'nurul01',SHA2('nurul123',256),'Customer','ACTIVE','Admin'),
(13,NULL,'daniel01',SHA2('daniel123',256),'Customer','ACTIVE','Admin'),
(14,NULL,'farah01',SHA2('farah123',256),'Customer','ACTIVE','Admin'),
(15,NULL,'henry01',SHA2('henry123',256),'Broker','ACTIVE','Admin');

INSERT INTO mi_broker
(user_id, broker_name, broker_org_name, license_no,
contact_no, email, address, credit_balance,
commission_percent, status, added_by)
VALUES
(6,'David Lee','ABC Insurance','LIC001','0123000001','broker1@gmail.com','Kuala Lumpur',10000.00,10.00,'ACTIVE','Admin'),
(7,'Michael Wong','Safe Motor','LIC002','0123000002','broker2@gmail.com','Selangor',12000.00,9.50,'ACTIVE','Admin'),
(8,'Henry Tan','Prime Insurance','LIC003','0123000003','broker3@gmail.com','Johor',8000.00,8.00,'ACTIVE','Admin'),
(9,'Kevin Lim','Trust Insurance','LIC004','0123000004','broker4@gmail.com','Perak',9000.00,10.00,'ACTIVE','Admin'),
(10,'James Ong','Best Coverage','LIC005','0123000005','broker5@gmail.com','Penang',15000.00,11.00,'ACTIVE','Admin'),
(11,'Ali Hassan','Metro Brokers','LIC006','0123000006','broker6@gmail.com','Melaka',11000.00,9.00,'ACTIVE','Admin'),
(12,'Sarah Lee','Elite Brokers','LIC007','0123000007','broker7@gmail.com','Sabah',14000.00,10.50,'ACTIVE','Admin'),
(13,'John Smith','First Choice','LIC008','0123000008','broker8@gmail.com','Sarawak',13000.00,9.50,'ACTIVE','Admin'),
(14,'Daniel Tan','Guardian Insurance','LIC009','0123000009','broker9@gmail.com','Pahang',10000.00,8.50,'ACTIVE','Admin'),
(15,'William Lim','Secure Cover','LIC010','0123000010','broker10@gmail.com','Kedah',16000.00,12.00,'ACTIVE','Admin');


INSERT INTO mi_vehicle
(user_id, make_id, model_id, color_id, body_id, category_id,
registration_no, engine_no, chassis_no,
manufacture_year, insured_value, added_by)
VALUES
(1,1,1,1,1,1,'JAA1001','ENG1001','CHS1001',2020,55000,'Admin'),
(2,2,3,2,2,1,'JAA1002','ENG1002','CHS1002',2021,72000,'Admin'),
(3,3,5,3,3,1,'JAA1003','ENG1003','CHS1003',2019,42000,'Admin'),
(4,4,7,4,2,2,'JAA1004','ENG1004','CHS1004',2022,68000,'Admin'),
(5,5,9,5,1,1,'JAA1005','ENG1005','CHS1005',2021,60000,'Admin'),
(6,6,10,6,2,2,'JAA1006','ENG1006','CHS1006',2023,98000,'Admin'),
(7,7,11,7,2,5,'JAA1007','ENG1007','CHS1007',2020,180000,'Admin'),
(8,8,12,8,4,5,'JAA1008','ENG1008','CHS1008',2022,220000,'Admin'),
(9,9,13,9,3,1,'JAA1009','ENG1009','CHS1009',2021,89000,'Admin'),
(10,10,14,10,2,1,'JAA1010','ENG1010','CHS1010',2019,76000,'Admin'),
(11,11,15,11,5,2,'JAA1011','ENG1011','CHS1011',2023,150000,'Admin'),
(12,12,15,12,8,2,'JAA1012','ENG1012','CHS1012',2020,130000,'Admin'),
(13,13,15,13,5,2,'JAA1013','ENG1013','CHS1013',2021,110000,'Admin'),
(14,14,15,14,11,5,'JAA1014','ENG1014','CHS1014',2022,250000,'Admin'),
(15,15,15,15,15,5,'JAA1015','ENG1015','CHS1015',2024,350000,'Admin');

INSERT INTO mi_quote
(quote_no, user_id, broker_id, vehicle_id, product_id,
cover_type, policy_period, quote_date, status, added_by)
VALUES
('QT1001',1,1,1,1,'Comprehensive',365,'2026-01-05','APPROVED','Admin'),
('QT1002',2,2,2,2,'TPL',365,'2026-01-06','APPROVED','Admin'),
('QT1003',3,3,3,3,'Comprehensive',365,'2026-01-07','PENDING','Admin'),
('QT1004',4,4,4,4,'Commercial',365,'2026-01-08','APPROVED','Admin'),
('QT1005',5,5,5,5,'Motorcycle',365,'2026-01-09','APPROVED','Admin'),
('QT1006',6,6,6,6,'Comprehensive',365,'2026-01-10','PENDING','Admin'),
('QT1007',7,7,7,7,'Comprehensive',365,'2026-01-11','APPROVED','Admin'),
('QT1008',8,8,8,8,'Commercial',365,'2026-01-12','APPROVED','Admin'),
('QT1009',9,9,9,9,'TPL',365,'2026-01-13','PENDING','Admin'),
('QT1010',10,10,10,10,'Commercial',365,'2026-01-14','APPROVED','Admin'),
('QT1011',11,1,11,11,'Comprehensive',365,'2026-01-15','APPROVED','Admin'),
('QT1012',12,2,12,12,'Comprehensive',365,'2026-01-16','PENDING','Admin'),
('QT1013',13,3,13,13,'TPL',365,'2026-01-17','APPROVED','Admin'),
('QT1014',14,4,14,14,'Commercial',365,'2026-01-18','APPROVED','Admin'),
('QT1015',15,5,15,15,'Comprehensive',365,'2026-01-19','APPROVED','Admin');

INSERT INTO mi_premium_rate
(product_id, category_id, min_value, max_value,
premium_percent, tax_percent,
effective_date, expiry_date,
status, added_by)
VALUES
(1,1,0,50000,2.50,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(2,2,50001,100000,3.00,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(3,3,100001,150000,3.50,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(4,4,150001,200000,4.00,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(5,5,200001,250000,4.50,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(6,6,250001,300000,5.00,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(7,7,300001,350000,5.50,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(8,8,350001,400000,6.00,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(9,9,400001,450000,6.50,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(10,10,450001,500000,7.00,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(11,11,500001,550000,7.50,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(12,12,550001,600000,8.00,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(13,13,600001,650000,8.50,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(14,14,650001,700000,9.00,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(15,15,700001,750000,9.50,6.00,'2026-01-01','2026-12-31','ACTIVE','Admin');

INSERT INTO mi_broker_commission
(broker_id, product_id, commission_percent,
effective_date, expiry_date,
status, added_by)
VALUES
(1,1,10.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(2,2,9.50,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(3,3,8.50,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(4,4,11.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(5,5,10.50,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(6,6,9.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(7,7,12.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(8,8,10.00,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(9,9,9.50,'2026-01-01','2026-12-31','ACTIVE','Admin'),
(10,10,11.50,'2026-01-01','2026-12-31','ACTIVE','Admin');

INSERT INTO mi_quote_premium
(quote_id, basic_premium, addon_amount, tax_amount,
total_premium, currency)
VALUES
(1,1375.00,150.00,91.50,1616.50,'MYR'),
(2,2160.00,200.00,141.60,2501.60,'MYR'),
(3,1470.00,100.00,94.20,1664.20,'MYR'),
(4,2720.00,250.00,178.20,3148.20,'MYR'),
(5,2700.00,150.00,171.00,3021.00,'MYR'),
(6,4900.00,300.00,312.00,5512.00,'MYR'),
(7,9900.00,500.00,624.00,11024.00,'MYR'),
(8,13200.00,600.00,828.00,14628.00,'MYR'),
(9,5785.00,250.00,362.10,6397.10,'MYR'),
(10,5320.00,300.00,337.20,5957.20,'MYR'),
(11,11250.00,550.00,708.00,12508.00,'MYR'),
(12,10400.00,450.00,651.00,11501.00,'MYR'),
(13,9350.00,400.00,585.00,10335.00,'MYR'),
(14,22500.00,750.00,1395.00,24645.00,'MYR'),
(15,33250.00,1000.00,2055.00,36305.00,'MYR');

INSERT INTO mi_policy
(policy_no, quote_id, premium_id,
issue_date, start_date, expiry_date,
payment_status, policy_status, added_by)
VALUES
('POL1001',1,1,'2026-01-06','2026-01-06','2027-01-05','PAID','ACTIVE','Admin'),
('POL1002',2,2,'2026-01-07','2026-01-07','2027-01-06','PAID','ACTIVE','Admin'),
('POL1003',3,3,'2026-01-08','2026-01-08','2027-01-07','PAID','ACTIVE','Admin'),
('POL1004',4,4,'2026-01-09','2026-01-09','2027-01-08','PAID','ACTIVE','Admin'),
('POL1005',5,5,'2026-01-10','2026-01-10','2027-01-09','PAID','ACTIVE','Admin'),
('POL1006',6,6,'2026-01-11','2026-01-11','2027-01-10','PAID','ACTIVE','Admin'),
('POL1007',7,7,'2026-01-12','2026-01-12','2027-01-11','PAID','ACTIVE','Admin'),
('POL1008',8,8,'2026-01-13','2026-01-13','2027-01-12','PAID','ACTIVE','Admin'),
('POL1009',9,9,'2026-01-14','2026-01-14','2027-01-13','PAID','ACTIVE','Admin'),
('POL1010',10,10,'2026-01-15','2026-01-15','2027-01-14','PAID','ACTIVE','Admin'),
('POL1011',11,11,'2026-01-16','2026-01-16','2027-01-15','PAID','ACTIVE','Admin'),
('POL1012',12,12,'2026-01-17','2026-01-17','2027-01-16','PAID','ACTIVE','Admin'),
('POL1013',13,13,'2026-01-18','2026-01-18','2027-01-17','PAID','ACTIVE','Admin'),
('POL1014',14,14,'2026-01-19','2026-01-19','2027-01-18','PAID','ACTIVE','Admin'),
('POL1015',15,15,'2026-01-20','2026-01-20','2027-01-19','PAID','ACTIVE','Admin');

/* Query 1 - Display Customer Details */

SELECT u.user_id, CONCAT(u.first_name,' ',u.last_name) AS customer_name, c.city_name, s.state_name, u.phone, u.email
FROM mi_user u
INNER JOIN mi_city c ON u.city_id = c.city_id
INNER JOIN mi_state s ON u.state_id = s.state_id;

/* Query 2 - Display Vehicle Details */

SELECT v.vehicle_id, m.make_desc, md.model_desc, vc.color_name, vb.body_name, cat.category_name, v.registration_no, v.insured_value
FROM mi_vehicle v
INNER JOIN mi_make m ON v.make_id = m.make_id
INNER JOIN mi_model md ON v.model_id = md.model_id
INNER JOIN mi_vehicle_color vc ON v.color_id = vc.color_id
INNER JOIN mi_vehicle_body vb ON v.body_id = vb.body_id
INNER JOIN mi_vehicle_category cat ON v.category_id = cat.category_id;

/* Query 3 - Display Broker Details */

SELECT b.broker_name, b.broker_org_name, b.credit_balance, b.commission_percent, u.email, u.mobile
FROM mi_broker b
INNER JOIN mi_user u ON b.user_id = u.user_id;

/* Query 4 - Display Quote Details */

SELECT q.quote_no, CONCAT(u.first_name,' ',u.last_name) AS customer_name, b.broker_name, p.product_name, q.cover_type, q.policy_period, q.status
FROM mi_quote q
INNER JOIN mi_user u ON q.user_id = u.user_id
LEFT JOIN mi_broker b ON q.broker_id = b.broker_id
INNER JOIN mi_product p ON q.product_id = p.product_id;

/* Query 5 - Display Policy Details */

SELECT po.policy_no, q.quote_no, qp.total_premium, po.issue_date, po.start_date, po.expiry_date, po.policy_status
FROM mi_policy po
INNER JOIN mi_quote q ON po.quote_id = q.quote_id
INNER JOIN mi_quote_premium qp ON po.premium_id = qp.premium_id;

/* Query 6 - Display Active Customers */

SELECT user_id, first_name, last_name, email
FROM mi_user
WHERE user_type='Customer' AND status='ACTIVE';

/* Query 7 - Display Vehicles with Insured Value Greater Than 100000 */

SELECT vehicle_id, registration_no, insured_value
FROM mi_vehicle
WHERE insured_value > 100000;

/* Query 8 - Display Products in Ascending Order */

SELECT product_id, product_name, cover_type
FROM mi_product
ORDER BY product_name ASC;

/* Query 9 - Display Premium Details in Descending Order */

SELECT premium_id, total_premium
FROM mi_quote_premium
ORDER BY total_premium DESC;

/* Query 10 - Display Customers Whose Name Starts With 'J' */

SELECT user_id, first_name, last_name
FROM mi_user
WHERE first_name LIKE 'J%';

/* Query 11 - Display Customers Using Gmail */

SELECT first_name, last_name, email
FROM mi_user
WHERE email LIKE '%gmail.com';

/* Query 12 - Display Premium Between 5000 and 15000 */

SELECT premium_id, total_premium
FROM mi_quote_premium
WHERE total_premium BETWEEN 5000 AND 15000;

/* Query 13 - Display Selected Vehicle Categories */

SELECT category_id, category_name
FROM mi_vehicle_category
WHERE category_name IN ('Private','Commercial','Luxury');

/* Query 14 - Display Vehicles Except White and Black */

SELECT color_id, color_name
FROM mi_vehicle_color
WHERE color_name NOT IN ('White','Black');

/* Query 15 - Display First 5 Customers */

SELECT user_id, first_name, last_name
FROM mi_user
LIMIT 5;

/* Query 16 - Total Number of Customers */

SELECT COUNT(*) AS Total_Customers
FROM mi_user
WHERE user_type='Customer';

/* Query 17 - Total Number of Policies */

SELECT COUNT(*) AS Total_Policies
FROM mi_policy;

/* Query 18 - Highest Premium Amount */

SELECT MAX(total_premium) AS Highest_Premium
FROM mi_quote_premium;


/* Query 19- RIGHT JOIN */

SELECT b.broker_name, CONCAT(u.first_name,' ',u.last_name) AS customer_name
FROM mi_user u
RIGHT JOIN mi_broker b ON u.user_id = b.user_id;

/* Query 20 - Multiple INNER JOIN */

SELECT po.policy_no, q.quote_no, CONCAT(u.first_name,' ',u.last_name) AS customer_name, qp.total_premium
FROM mi_policy po
INNER JOIN mi_quote q ON po.quote_id = q.quote_id
INNER JOIN mi_user u ON q.user_id = u.user_id
INNER JOIN mi_quote_premium qp ON po.premium_id = qp.premium_id;

/* Query 21 - Vehicle and Owner Details */

SELECT CONCAT(u.first_name,' ',u.last_name) AS owner_name, m.make_desc, md.model_desc, v.registration_no
FROM mi_vehicle v
INNER JOIN mi_user u ON v.user_id = u.user_id
INNER JOIN mi_make m ON v.make_id = m.make_id
INNER JOIN mi_model md ON v.model_id = md.model_id;

/* Query 22 - Product with Premium Rate */

SELECT p.product_name, pr.premium_percent, pr.tax_percent
FROM mi_product p
INNER JOIN mi_premium_rate pr ON p.product_id = pr.product_id;

/* Query 32 - Broker Commission Details */

SELECT b.broker_name, p.product_name, bc.commission_percent
FROM mi_broker_commission bc
INNER JOIN mi_broker b ON bc.broker_id = b.broker_id
INNER JOIN mi_product p ON bc.product_id = p.product_id;

/* Query 23 - Customer Policy Details */

SELECT CONCAT(u.first_name,' ',u.last_name) AS customer_name, po.policy_no, po.policy_status
FROM mi_policy po
INNER JOIN mi_quote q ON po.quote_id = q.quote_id
INNER JOIN mi_user u ON q.user_id = u.user_id;

/* Query 24 - Quote and Premium Details */

SELECT q.quote_no, qp.basic_premium, qp.tax_amount, qp.total_premium
FROM mi_quote q
INNER JOIN mi_quote_premium qp ON q.quote_id = qp.quote_id;

/* Query 25 - Customer, Vehicle and Policy */

SELECT CONCAT(u.first_name,' ',u.last_name) AS customer_name, v.registration_no, po.policy_no
FROM mi_user u
INNER JOIN mi_vehicle v ON u.user_id = v.user_id
INNER JOIN mi_quote q ON u.user_id = q.user_id
INNER JOIN mi_policy po ON q.quote_id = po.quote_id;

/* Query 26 - Customer with Highest Premium */
SELECT first_name,last_name FROM mi_user WHERE user_id=(SELECT q.user_id FROM mi_quote q INNER JOIN mi_quote_premium qp ON q.quote_id=qp.quote_id ORDER BY qp.total_premium DESC LIMIT 1);


/* View 1 - Customer Details */

CREATE VIEW vw_customer_details AS
SELECT u.user_id,CONCAT(u.first_name,' ',u.last_name) AS customer_name,c.city_name,s.state_name,u.phone,u.email
FROM mi_user u
INNER JOIN mi_city c ON u.city_id=c.city_id
INNER JOIN mi_state s ON u.state_id=s.state_id;

SELECT * FROM vw_customer_details;


/* View 2 - Vehicle Details */

CREATE VIEW vw_vehicle_details AS
SELECT v.vehicle_id,m.make_desc,md.model_desc,vc.color_name,vb.body_name,cat.category_name,v.registration_no,v.insured_value
FROM mi_vehicle v
INNER JOIN mi_make m ON v.make_id=m.make_id
INNER JOIN mi_model md ON v.model_id=md.model_id
INNER JOIN mi_vehicle_color vc ON v.color_id=vc.color_id
INNER JOIN mi_vehicle_body vb ON v.body_id=vb.body_id
INNER JOIN mi_vehicle_category cat ON v.category_id=cat.category_id;

SELECT * FROM vw_vehicle_details;


/* View 3 - Quote Details */

CREATE VIEW vw_quote_details AS
SELECT q.quote_no,CONCAT(u.first_name,' ',u.last_name) AS customer_name,p.product_name,q.cover_type,q.policy_period,q.status
FROM mi_quote q
INNER JOIN mi_user u ON q.user_id=u.user_id
INNER JOIN mi_product p ON q.product_id=p.product_id;

SELECT * FROM vw_quote_details;


/* View 4 - Policy Details */

CREATE VIEW vw_policy_details AS
SELECT po.policy_no,q.quote_no,qp.total_premium,po.issue_date,po.expiry_date,po.policy_status
FROM mi_policy po
INNER JOIN mi_quote q ON po.quote_id=q.quote_id
INNER JOIN mi_quote_premium qp ON po.premium_id=qp.premium_id;

SELECT * FROM vw_policy_details;


/* View 5 - Broker Commission Details */

CREATE VIEW vw_broker_commission AS
SELECT b.broker_name,p.product_name,bc.commission_percent
FROM mi_broker_commission bc
INNER JOIN mi_broker b ON bc.broker_id=b.broker_id
INNER JOIN mi_product p ON bc.product_id=p.product_id;

SELECT * FROM vw_broker_commission;

/* Procedure 1 - Display All Customers */

DELIMITER $$

CREATE PROCEDURE sp_customer_details()
BEGIN
SELECT * FROM mi_user;
END $$

DELIMITER ;

CALL sp_customer_details();


/* Procedure 2 - Display Quote Details */

DELIMITER $$

CREATE PROCEDURE sp_quote_details(IN p_quote_no VARCHAR(30))
BEGIN
SELECT * FROM mi_quote WHERE quote_no=p_quote_no;
END $$

DELIMITER ;

CALL sp_quote_details('QT1001');


/* Procedure 4 - Display Policy Details */

DELIMITER $$

CREATE PROCEDURE sp_policy_details(IN p_policy_no VARCHAR(30))
BEGIN
SELECT * FROM mi_policy WHERE policy_no=p_policy_no;
END $$

DELIMITER ;

CALL sp_policy_details('POL1001');


/* Procedure 4- Display Premium Details */

DELIMITER $$

CREATE PROCEDURE sp_premium_details(IN p_quote_id INT)
BEGIN
SELECT * FROM mi_quote_premium WHERE quote_id=p_quote_id;
END $$

DELIMITER ;

CALL sp_premium_details(1);

/* Function 1 - Calculate Annual Premium */

DELIMITER $$

CREATE FUNCTION fn_annual_premium(p_basic DECIMAL(12,2),p_tax DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
RETURN p_basic+p_tax;
END $$

DELIMITER ;

SELECT fn_annual_premium(5000,300);


/* Function 2 - Calculate Total Premium */

DELIMITER $$

CREATE FUNCTION fn_total_premium(p_basic DECIMAL(12,2),p_addon DECIMAL(12,2),p_tax DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
RETURN p_basic+p_addon+p_tax;
END $$

DELIMITER ;

SELECT fn_total_premium(5000,200,312);


/* Function 3 - Vehicle Age */

DELIMITER $$

CREATE FUNCTION fn_vehicle_age(p_year YEAR)
RETURNS INT
DETERMINISTIC
BEGIN
RETURN YEAR(CURDATE())-p_year;
END $$

DELIMITER ;

SELECT registration_no,fn_vehicle_age(manufacture_year) AS vehicle_age
FROM mi_vehicle;





/* Function 4- GST Amount */

DELIMITER $$

CREATE FUNCTION fn_gst_amount(p_amount DECIMAL(12,2),p_tax DECIMAL(5,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
RETURN (p_amount*p_tax)/100;
END $$

DELIMITER ;

SELECT fn_gst_amount(10000,6);

/* Trigger 1 - Set Added Date Automatically */

DELIMITER $$

CREATE TRIGGER trg_user_added_on
BEFORE INSERT ON mi_user
FOR EACH ROW
BEGIN
SET NEW.added_on=NOW();
END $$

DELIMITER ;

/* Trigger 2 - Prevent Negative Insured Value */

DELIMITER $$

CREATE TRIGGER trg_vehicle_insured_value
BEFORE INSERT ON mi_vehicle
FOR EACH ROW
BEGIN
IF NEW.insured_value<=0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Insured Value Must Be Greater Than Zero';
END IF;
END $$

DELIMITER ;

/* Trigger 3 - Prevent Negative Premium */

DELIMITER $$

CREATE TRIGGER trg_quote_premium
BEFORE INSERT ON mi_quote_premium
FOR EACH ROW
BEGIN
IF NEW.total_premium<0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Invalid Premium Amount';
END IF;
END $$

DELIMITER ;

/* Trigger 4 - Set Policy Status */

DELIMITER $$

CREATE TRIGGER trg_policy_status
BEFORE INSERT ON mi_policy
FOR EACH ROW
BEGIN
SET NEW.policy_status='ACTIVE';
END $$

DELIMITER ;

/* Transaction 1 - COMMIT */

START TRANSACTION;

UPDATE mi_quote_premium
SET total_premium=1650.00
WHERE premium_id=1;

COMMIT;

SELECT * FROM mi_quote_premium WHERE premium_id=1;


/* Transaction 2 - ROLLBACK */

START TRANSACTION;

UPDATE mi_vehicle
SET insured_value=999999
WHERE vehicle_id=1;

ROLLBACK;

SELECT * FROM mi_vehicle WHERE vehicle_id=1;


/* Transaction 3 - SAVEPOINT */

START TRANSACTION;

UPDATE mi_policy
SET policy_status='EXPIRED'
WHERE policy_id=1;

SAVEPOINT sp_policy;

UPDATE mi_policy
SET payment_status='UNPAID'
WHERE policy_id=1;

ROLLBACK TO sp_policy;

COMMIT;

SELECT * FROM mi_policy WHERE policy_id=1;


/* Transaction 4 - DELETE and ROLLBACK */

START TRANSACTION;

UPDATE mi_product
SET description='Rollback Test'
WHERE product_id=1;

ROLLBACK;

SELECT * FROM mi_product WHERE product_id=1;
/* Transaction 5 - INSERT and COMMIT */

START TRANSACTION;

INSERT INTO mi_product(product_name,cover_type,description,added_by)
VALUES('Special Premium','Comprehensive','Special Premium Package','Admin');

COMMIT;

SELECT * FROM mi_product WHERE product_name='Special Premium';
