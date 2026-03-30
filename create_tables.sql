CREATE TABLE Clients (
    client_id INTEGER,
    full_name VARCHAR(150) NOT NULL,
    phone_number VARCHAR(15),
    email_address VARCHAR(100),
    CONSTRAINT pk_client PRIMARY KEY (client_id)
);

CREATE TABLE Restaurant_Tables (
    table_id INTEGER,
    table_num INTEGER NOT NULL,
    guests_capacity INTEGER NOT NULL,
    table_location VARCHAR(100),
    CONSTRAINT pk_table PRIMARY KEY (table_id)
);

CREATE TABLE Dishes (
    dish_id INTEGER,
    dish_title VARCHAR(150) NOT NULL,
    dish_desc TEXT,
    price NUMERIC(10, 2) NOT NULL,
    dish_category VARCHAR(50),
    CONSTRAINT pk_dish PRIMARY KEY (dish_id)
);

CREATE TABLE Client_Orders (
    order_id INTEGER,
    client_id INTEGER,
    table_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(50) NOT NULL,
    CONSTRAINT pk_order PRIMARY KEY (order_id),
    CONSTRAINT fk_order_client FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    CONSTRAINT fk_order_table FOREIGN KEY (table_id) REFERENCES Restaurant_Tables(table_id)
);

CREATE TABLE Order_Details (
    detail_id INTEGER,
    order_id INTEGER,
    dish_id INTEGER,
    portions_count INTEGER NOT NULL,
    CONSTRAINT pk_detail PRIMARY KEY (detail_id),
    CONSTRAINT fk_detail_order FOREIGN KEY (order_id) REFERENCES Client_Orders(order_id),
    CONSTRAINT fk_detail_dish FOREIGN KEY (dish_id) REFERENCES Dishes(dish_id)
);
