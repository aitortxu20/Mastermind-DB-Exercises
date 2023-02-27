CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE profiles (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    username VARCHAR(255) UNIQUE NOT NULL,
    profile_picture VARCHAR(255) NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE follows (
    profile_id INT UNSIGNED  NOT NULL,
    following_profile_id INT UNSIGNED  NOT NULL,

    PRIMARY KEY (profile_id, follow_profile_id),

    FOREIGN KEY (profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (follow_profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE posts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id INT UNSIGNED NOT NULL,
    description VARCHAR(512) NULL,

    FOREIGN KEY (profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE post_images (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    post_id INT UNSIGNED NOT NULL,
    url VARCHAR(255) NOT NULL UNIQUE,

    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE comments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    post_id INT UNSIGNED NOT NULL,
    profile_id INT UNSIGNED NOT NULL,
    comment VARCHAR(512),

    FOREIGN KEY (post_id) REFERENCES posts(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (profile_id) REFERENCES profiles(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);