-- ### структура базы данных

-- 1. *Автомобили (Cars)*
--    - ID (PK)
--    - Номерной знак
--    - Марка
--    - Модель
--    - Год выпуска
--    - Пробег
--    - СТО ID (FK)
--    - Водитель ID (FK)

-- 2. *Работники (Employees)*
--    - ID (PK)
--    - ФИО
--    - Должность
--    - Телефон
--    - Email
--    - Роль (например, водитель, диспетчер)

-- 3. *Диспетчеры (Dispatchers)*
--    - ID (PK)
--    - ФИО
--    - Телефон
--    - Email

-- 4. *Заказчики (Customers)*
--    - ID (PK)
--    - ФИО
--    - Телефон
--    - Email
--    - Адрес

-- 5. *Заказы (Orders)*
--    - ID (PK)
--    - Заказчик ID (FK)
--    - Автомобиль ID (FK)
--    - Диспетчер ID (FK)
--    - Дата и время заказа
--    - Статус заказа
--    - Сумма

-- 6. *СТО (Service Stations)*
--    - ID (PK)
--    - Название
--    - Адрес
--    - Телефон

-- 7. *Бонусы (Bonuses)*
--    - ID (PK)
--    - Заказчик ID (FK)
--    - Тип бонуса
--    - Сумма

### SQL-запросы для создания базы данных


-- Создание таблицы СТО
CREATE TABLE ServiceStations (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Phone VARCHAR(20)
);

-- Создание таблицы Работники
CREATE TABLE Employees (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100),
    Position VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Role VARCHAR(50) -- Водитель, Диспетчер и т.д.
);

-- Создание таблицы Диспетчеры
CREATE TABLE Dispatchers (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

-- Создание таблицы Автомобили
CREATE TABLE Cars (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    LicensePlate VARCHAR(20),
    Brand VARCHAR(50),
    Model VARCHAR(50),
    Year YEAR,
    Mileage INT,
    ServiceStationID INT,
    DriverID INT,
    FOREIGN KEY (ServiceStationID) REFERENCES ServiceStations(ID),
    FOREIGN KEY (DriverID) REFERENCES Employees(ID)
);

-- Создание таблицы Заказчики
CREATE TABLE Customers (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- Создание таблицы Заказы
CREATE TABLE Orders (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CarID INT,
    DispatcherID INT,
    OrderDateTime DATETIME,
    Status VARCHAR(50),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID),
    FOREIGN KEY (CarID) REFERENCES Cars(ID),
    FOREIGN KEY (DispatcherID) REFERENCES Dispatchers(ID)
);

-- Создание таблицы Бонусы
CREATE TABLE Bonuses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    BonusType VARCHAR(50),
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);


-- ### Связи между таблицами:

-- - *Автомобили* связаны с *СТО* (где обслуживаются) и с *Работниками* (водителями).
-- - *Заказы* связаны с *Заказчиками, **Автомобилями* и *Диспетчерами* (которые обрабатывают заказы).
-- - *Бонусы* связаны с *Заказчиками*.

### Примеры запросов




  SELECT Cars.LicensePlate, Cars.Brand, Cars.Model, Employees.FullName AS Driver
  FROM Cars
  JOIN Employees ON Cars.DriverID = Employees.ID;
  

-- *Получить все заказы и диспетчеров, которые их обработали:*


  SELECT Orders.ID AS OrderID, Orders.OrderDateTime, Orders.Status, Orders.Amount, 
         Cars.LicensePlate, Dispatchers.FullName AS Dispatcher
  FROM Orders
  JOIN Cars ON Orders.CarID = Cars.ID
  JOIN Dispatchers ON Orders.DispatcherID = Dispatchers.ID;
  

-- *Получить все бонусы для конкретного заказчика:*


  SELECT Bonuses.BonusType, Bonuses.Amount
  FROM Bonuses
  WHERE Bonuses.CustomerID = CustomerID;