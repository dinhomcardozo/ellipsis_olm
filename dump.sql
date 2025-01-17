-- PRAGMA foreign_keys=OFF;
-- BEGIN TRANSACTION;
-- COMMIT;

-- Dump SQL baseado no schema.rb fornecido

-- Tabela: clients
CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    email VARCHAR,
    system_admin_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX index_clients_on_system_admin_id ON clients (system_admin_id);

-- Tabela: clients_products
CREATE TABLE clients_products (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    product_license_start TIMESTAMP,
    product_license_end TIMESTAMP,
    client_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX index_clients_products_on_client_id ON clients_products (client_id);

-- Tabela: companies
CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    cnpj VARCHAR,
    group_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX index_companies_on_group_id ON companies (group_id);

-- Tabela: contacts
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    telephone VARCHAR,
    company_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX index_contacts_on_company_id ON contacts (company_id);

-- Tabela: contracts
CREATE TABLE contracts (
    id SERIAL PRIMARY KEY,
    opportunity_id INTEGER NOT NULL,
    contract_date DATE,
    contract_end_date DATE,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX index_contracts_on_opportunity_id ON contracts (opportunity_id);

-- Tabela: groups
CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    client_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX index_groups_on_client_id ON groups (client_id);

-- Tabela: opportunities
CREATE TABLE opportunities (
    id SERIAL PRIMARY KEY,
    stage_id INTEGER NOT NULL,
    contact_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    opp_status VARCHAR,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX index_opportunities_on_stage_id ON opportunities (stage_id);
CREATE INDEX index_opportunities_on_contact_id ON opportunities (contact_id);
CREATE INDEX index_opportunities_on_user_id ON opportunities (user_id);

-- Tabela: stages
CREATE TABLE stages (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- Tabela: system_admins
CREATE TABLE system_admins (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    email VARCHAR,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    password VARCHAR
);

-- Tabela: users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    email VARCHAR,
    client_id INTEGER NOT NULL,
    user_admin BOOLEAN,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    encrypted_password VARCHAR DEFAULT '' NOT NULL,
    reset_password_token VARCHAR,
    reset_password_sent_at TIMESTAMP,
    remember_created_at TIMESTAMP
);

CREATE INDEX index_users_on_client_id ON users (client_id);
CREATE UNIQUE INDEX index_users_on_email ON users (email);
CREATE UNIQUE INDEX index_users_on_reset_password_token ON users (reset_password_token);

-- Relações (chaves estrangeiras)
ALTER TABLE clients ADD CONSTRAINT fk_clients_system_admins FOREIGN KEY (system_admin_id) REFERENCES system_admins (id);
ALTER TABLE clients_products ADD CONSTRAINT fk_clients_products_clients FOREIGN KEY (client_id) REFERENCES clients (id);
ALTER TABLE companies ADD CONSTRAINT fk_companies_groups FOREIGN KEY (group_id) REFERENCES groups (id);
ALTER TABLE contacts ADD CONSTRAINT fk_contacts_companies FOREIGN KEY (company_id) REFERENCES companies (id);
ALTER TABLE contracts ADD CONSTRAINT fk_contracts_opportunities FOREIGN KEY (opportunity_id) REFERENCES opportunities (id);
ALTER TABLE groups ADD CONSTRAINT fk_groups_clients FOREIGN KEY (client_id) REFERENCES clients (id);
ALTER TABLE opportunities ADD CONSTRAINT fk_opportunities_contacts FOREIGN KEY (contact_id) REFERENCES contacts (id);
ALTER TABLE opportunities ADD CONSTRAINT fk_opportunities_stages FOREIGN KEY (stage_id) REFERENCES stages (id);
ALTER TABLE opportunities ADD CONSTRAINT fk_opportunities_users FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE users ADD CONSTRAINT fk_users_clients FOREIGN KEY (client_id) REFERENCES clients (id);
