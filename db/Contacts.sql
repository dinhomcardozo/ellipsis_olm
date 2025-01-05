CREATE TABLE Contacts (
    contact_id SERIAL PRIMARY KEY,                 -- ID do contato
    first_name VARCHAR(15) NOT NULL,               -- Nome
    last_name VARCHAR(15) NOT NULL,                -- Sobrenome
    company_id INT NOT NULL,                       -- ID da empresa (referência à tabela Companies)
    company_name VARCHAR(100),                     -- Nome da empresa
    telephone VARCHAR(20),                         -- Telefone
    group_id INT NOT NULL,                         -- ID do grupo (referência à tabela Groups)
    group_name VARCHAR(100),                       -- Nome do grupo
    CONSTRAINT fk_company FOREIGN KEY (company_id) REFERENCES Companies(company_id),  -- Relacionamento com a tabela Companies
    CONSTRAINT fk_group FOREIGN KEY (group_id) REFERENCES Groups(group_id)           -- Relacionamento com a tabela Groups
);
