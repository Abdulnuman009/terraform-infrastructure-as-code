
-- Initialize database and core tables
CREATE DATABASE IF NOT EXISTS mydatabase;
USE mydatabase;

-- Users table
CREATE TABLE IF NOT EXISTS users (
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(50) NOT NULL UNIQUE,
	email VARCHAR(255) NOT NULL UNIQUE,
	password_hash VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Roles table
CREATE TABLE IF NOT EXISTS roles (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE,
	description VARCHAR(255)
);

-- Linking table for many-to-many users <-> roles
CREATE TABLE IF NOT EXISTS user_roles (
	user_id INT NOT NULL,
	role_id INT NOT NULL,
	assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (user_id, role_id),
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
	FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
	id INT AUTO_INCREMENT PRIMARY KEY,
	sku VARCHAR(64) NOT NULL UNIQUE,
	name VARCHAR(255) NOT NULL,
	description TEXT,
	price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders and order items
CREATE TABLE IF NOT EXISTS orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	status VARCHAR(50) NOT NULL DEFAULT 'pending',
	total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS order_items (
	id INT AUTO_INCREMENT PRIMARY KEY,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL DEFAULT 1,
	unit_price DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);

-- Sample seed data (safe to run multiple times)
INSERT IGNORE INTO roles (name, description) VALUES
('admin', 'Administrator with full permissions'),
('user', 'Regular application user');

INSERT IGNORE INTO users (username, email, password_hash) VALUES
('alice', 'alice@example.com', 'HASHED_PASSWORD_PLACEHOLDER'),
('bob', 'bob@example.com', 'HASHED_PASSWORD_PLACEHOLDER');

-- Assign roles if not already assigned
INSERT IGNORE INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u JOIN roles r ON r.name = 'user' WHERE u.username = 'alice';

-- Example products
INSERT IGNORE INTO products (sku, name, description, price) VALUES
('SKU-1001', 'Widget A', 'Lightweight widget', 9.99),
('SKU-1002', 'Widget B', 'Heavy-duty widget', 19.99);