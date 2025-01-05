-- Tabela de Grupos OK
CREATE TABLE Groups (
    group_id SERIAL PRIMARY KEY -- Chave primária autoincrementada
);

-- Tabela de Relacionamento entre Groups e Companies OK
CREATE TABLE Group_Companies (
    group_id INTEGER,
    company_id INTEGER,
    PRIMARY KEY (group_id, company_id),
    FOREIGN KEY (group_id) REFERENCES Groups(group_id),
    FOREIGN KEY (company_id) REFERENCES Companies(company_id)
);

-- Tabela de Relacionamento entre Groups e Clients OK
CREATE TABLE Group_Clients (
    group_id INTEGER,
    client_id INTEGER,
    PRIMARY KEY (group_id, client_id),
    FOREIGN KEY (group_id) REFERENCES Groups(group_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- Tabela de Planos OK
CREATE TABLE Plans (
    plan_id SERIAL PRIMARY KEY, -- Número ordenado do plano
    plan_name VARCHAR(40) NOT NULL, -- Nome do plano
    plan_description TEXT, -- Descrição do plano
    plan_status VARCHAR(10) CHECK (plan_status IN ('ativo', 'inativo')), -- Status do plano
    plan_validity TIMESTAMP, -- Data e hora de validade do plano
    plan_price NUMERIC(10, 2), -- Preço do plano
    created_by VARCHAR(100), -- Criador do plano
    updated_by TIMESTAMP, -- Última atualização
    -- Contagem de grupos e clientes (não é FK)
    num_plan_groups INTEGER DEFAULT 0,
    num_plan_clients INTEGER DEFAULT 0
);

-- Tabela de Empresas OK
CREATE TABLE Companies (
    company_id SERIAL PRIMARY KEY, -- Chave primária
    company_name VARCHAR(255) NOT NULL, -- Razão Social
    company_cnpj VARCHAR(18) NOT NULL UNIQUE, -- CNPJ único
    address VARCHAR(50), -- Endereço
    address_number INTEGER, -- Número do endereço
    country CHAR(3), -- País
    state CHAR(2), -- Estado (UF)
    city VARCHAR(40), -- Cidade
    segment_id INTEGER NOT NULL REFERENCES Segments(segment_id), -- Segmento
    subsegment_id INTEGER REFERENCES SubSegments(subsegment_id), -- Subsegmento
    tax_regime_id INTEGER NOT NULL REFERENCES TaxRegime(tax_regime_id), -- Regime tributário
    group_id INTEGER -- Relacionamento com grupo
);

-- Tabela de Clientes OK
CREATE TABLE Clients (
    client_id SERIAL PRIMARY KEY, -- Chave primária
    plan_id INTEGER NOT NULL REFERENCES Plans(plan_id), -- Plano
    num_client_users INTEGER DEFAULT 0, -- Contagem de usuários
    cnpj VARCHAR(18) NOT NULL UNIQUE, -- CNPJ
    tax_regime_id INTEGER NOT NULL REFERENCES TaxRegime(tax_regime_id), -- Regime tributário
    segment_id INTEGER NOT NULL REFERENCES Segments(segment_id), -- Segmento
    subsegment_id INTEGER REFERENCES SubSegments(subsegment_id), -- Subsegmento
    email VARCHAR(255) NOT NULL, -- E-mail
    telephone VARCHAR(15), -- Telefone
    state CHAR(2), -- Estado
    city VARCHAR(40), -- Cidade
    country CHAR(3), -- País
    address VARCHAR(50), -- Endereço
    address_number INTEGER, -- Número do endereço
    state_registration VARCHAR(50), -- Inscrição Estadual
    city_registration VARCHAR(50) -- Inscrição Municipal
);

-- Tabela de Produtos de Clientes OK
CREATE TABLE ClientsProducts (
    product_id SERIAL PRIMARY KEY, -- Chave primária
    product_type VARCHAR(20) NOT NULL CHECK (product_type IN 
        ('Physical Product', 'Digital Product', 'Service')), -- Tipo do produto
    product_description TEXT, -- Descrição
    product_brand VARCHAR(100), -- Marca
    product_price NUMERIC(10, 2) NOT NULL, -- Preço
    product_cat VARCHAR(100), -- Categoria
    product_status VARCHAR(10) NOT NULL CHECK (product_status IN ('Ativo', 'Inativo')), -- Status
    product_license INTERVAL, -- Licença
    client_id INTEGER NOT NULL REFERENCES Clients(client_id) ON DELETE CASCADE -- Cliente
);
