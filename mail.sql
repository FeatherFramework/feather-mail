CREATE TABLE IF NOT EXISTS `featherMailContacts` (
    `owner_mail_id` int(100) NOT NULL,
    `contact_name` varchar(100) NOT NULL,
    `contact_mail_id` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `featherMail` (
    `mail_id` int NOT NULL AUTO_INCREMENT,
    `mail_type` varchar(50) NOT NULL,
    `owner_char_id` int(100) NOT NULL,
    `allowed_to_view` LONGTEXT NOT NULL,
    PRIMARY KEY `mail_id` (`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `featherRecMail` (
    `mail_id` int NOT NULL AUTO_INCREMENT,
    `id_sent_to` int(100) NOT NULL,
    `mail_message` LONGTEXT NOT NULL,
    PRIMARY KEY `mail_id` (`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;