-- Create database (run this as superuser)
CREATE DATABASE smartvms;

-- Connect to the database
\c smartvms

-- Create tables
-- These will actually be created by Hibernate when the application starts,
-- but if you want to set up the database manually, you can use these commands

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    mobile_number VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    wallet_balance DECIMAL(10, 2) DEFAULT 0.0
);

-- Items table
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INTEGER NOT NULL
);

-- Transactions table
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    total_amount DECIMAL(10, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Transaction items table
CREATE TABLE transaction_items (
    id SERIAL PRIMARY KEY,
    transaction_id INTEGER REFERENCES transactions(id),
    item_id INTEGER REFERENCES items(id),
    quantity INTEGER NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL
);

-- Sample data (this is also in data.sql that gets loaded automatically)
-- Category: Juices
INSERT INTO items (name, category, price, quantity) VALUES ('Orange Juice', 'Juices', 2.50, 20);
INSERT INTO items (name, category, price, quantity) VALUES ('Apple Juice', 'Juices', 2.50, 15);
INSERT INTO items (name, category, price, quantity) VALUES ('Mango Juice', 'Juices', 3.00, 10);
INSERT INTO items (name, category, price, quantity) VALUES ('Mixed Fruit Juice', 'Juices', 3.50, 8);

-- Category: Cold Drinks
INSERT INTO items (name, category, price, quantity) VALUES ('Cola', 'Cold Drinks', 1.50, 25);
INSERT INTO items (name, category, price, quantity) VALUES ('Lemon Soda', 'Cold Drinks', 1.50, 20);
INSERT INTO items (name, category, price, quantity) VALUES ('Iced Tea', 'Cold Drinks', 2.00, 15);
INSERT INTO items (name, category, price, quantity) VALUES ('Energy Drink', 'Cold Drinks', 3.00, 10);

-- Category: Pizza
INSERT INTO items (name, category, price, quantity) VALUES ('Margherita Pizza', 'Pizza', 8.00, 5);
INSERT INTO items (name, category, price, quantity) VALUES ('Pepperoni Pizza', 'Pizza', 9.00, 5);
INSERT INTO items (name, category, price, quantity) VALUES ('Vegetable Pizza', 'Pizza', 8.50, 5);
INSERT INTO items (name, category, price, quantity) VALUES ('Cheese Pizza', 'Pizza', 7.50, 5);

-- Category: Burgers
INSERT INTO items (name, category, price, quantity) VALUES ('Chicken Burger', 'Burgers', 6.00, 7);
INSERT INTO items (name, category, price, quantity) VALUES ('Veggie Burger', 'Burgers', 5.50, 7);
INSERT INTO items (name, category, price, quantity) VALUES ('Cheese Burger', 'Burgers', 6.50, 7);
INSERT INTO items (name, category, price, quantity) VALUES ('Double Burger', 'Burgers', 8.00, 5);

-- Category: Snacks
INSERT INTO items (name, category, price, quantity) VALUES ('Potato Chips', 'Snacks', 1.00, 30);
INSERT INTO items (name, category, price, quantity) VALUES ('Chocolate Bar', 'Snacks', 1.50, 25);
INSERT INTO items (name, category, price, quantity) VALUES ('Candy', 'Snacks', 0.75, 40);
INSERT INTO items (name, category, price, quantity) VALUES ('Popcorn', 'Snacks', 2.00, 15); 