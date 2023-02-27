CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);

CREATE TABLE accounts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE corporate_accounts (
    account_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    tax_id VARCHAR(255) NOT NULL UNIQUE,

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE transfers (
    from_account_id INT UNSIGNED NOT NULL,
    to_account_id INT UNSIGNED NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    date DATETIME NOT NULL,
    status ENUM("PAYED", "REFUNDED") NOT NULL,

    FOREIGN KEY (from_account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

   FOREIGN KEY (to_account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE bank_accounts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    number VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE bank_associations (
    bank_account_id INT UNSIGNED NOT NULL,
    account_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (bank_account_id, account_id),

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE bank_transfers (
    bank_account_id INT UNSIGNED NOT NULL,
    account_id INT UNSIGNED NOT NULL,
    direction ENUM("INCOMING", "OUTGOING") NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    status ENUM("PROCESSING", "COMPLETED", "CANCELED"),
    amount DECIMAL(12, 2),

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);