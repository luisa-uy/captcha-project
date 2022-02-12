CREATE TABLE bloque
(
    id          SERIAL
        PRIMARY KEY,
    status      INTEGER,
    path_imagen VARCHAR(255),
    texto       TEXT,
    imagen      TEXT
);

CREATE TABLE intento
(
    id         SERIAL
        PRIMARY KEY,
    fecha_hora DATE,
    texto      VARCHAR(255),
    bloque_id  INTEGER
);

CREATE TABLE captcha
(
    id         SERIAL
        PRIMARY KEY,
    fecha_hora TIMESTAMP,
    status     INTEGER,
    token      UUID
);

CREATE TABLE bloque_captcha
(
    id       SERIAL
        PRIMARY KEY,
    bloques  INTEGER
        REFERENCES bloque,
    captchas INTEGER
        REFERENCES captcha
);