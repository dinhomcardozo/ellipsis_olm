CREATE TABLE System_admins (
    admin_id SERIAL PRIMARY KEY,                      -- Chave primária autoincrementada
    first_name VARCHAR(100) NOT NULL,                 -- Primeiro nome
    last_name VARCHAR(100) NOT NULL,                  -- Sobrenome
    CPF VARCHAR(14) UNIQUE,                           -- CPF único (XXX.XXX.XXX-XX)
    CNPJ VARCHAR(18) UNIQUE,                          -- CNPJ único (XX.XXX.XXX/XXXX-XX)
    password VARCHAR(255) NOT NULL,                   -- Senha (armazenada com hash)
    email VARCHAR(255) UNIQUE NOT NULL,               -- E-mail único
    user_status VARCHAR(15) CHECK (user_status IN     -- Status do usuário
        ('active', 'inactive', 'pending')),           
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- Data de criação
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP    -- Última atualização
);