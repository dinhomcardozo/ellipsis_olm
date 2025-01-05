CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,                       -- ID do usuário (chave primária)
    client_id INT,                                    -- ID do cliente ao qual o usuário pertence (referência à tabela Clients)
    first_name VARCHAR(15),                           -- Primeiro nome do usuário
    last_name VARCHAR(15),                            -- Sobrenome do usuário
    user_status VARCHAR(10) CHECK (user_status IN ('Ativo', 'Inativo')),  -- Status do usuário ('Ativo' ou 'Inativo')
    user_admin BOOLEAN,                               -- Indica se o usuário é um administrador (True/False)
    password VARCHAR(15),                             -- Senha do usuário
    country CHAR(3),                                  -- Código do país (3 caracteres)
    state CHAR(2),                                    -- Código do estado (2 caracteres)
    city VARCHAR(40),                                 -- Nome da cidade
    first_signin TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora do cadastro do usuário
    first_signup TIMESTAMP,                           -- Data e hora do primeiro login
    last_signup TIMESTAMP,                            -- Data e hora do último login
    google_signin BOOLEAN,                            -- Indica se o login foi feito via Google (True/False)
    CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES Clients(client_id)  -- Relacionamento com a tabela Clients
);