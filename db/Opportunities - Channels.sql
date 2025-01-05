CREATE TABLE Opportunities (
    opp_id SERIAL PRIMARY KEY,                     -- ID da oportunidade
    stage_id INT,                                  -- ID do estágio da oportunidade (referência à tabela Stages)
    stage_name VARCHAR(50) CHECK (stage_name IN ('Propect', 'Lead', 'Demostration', 'Quote', 'Sale', 'Loss Sale', 'About to Renew', 'Not renewed', 'Post-sales', 'Renewed', 'All Customers')),  -- Nome do estágio
    opp_status VARCHAR(10) CHECK (opp_status IN ('Ativo', 'Inativo')),  -- Status da oportunidade
    created_by VARCHAR(100),                        -- Usuário que criou a oportunidade
    updated_by TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da última atualização
    quote_value DECIMAL(10, 2) DEFAULT 0.0,         -- Valor total da oportunidade
    CONSTRAINT fk_stage FOREIGN KEY (stage_id) REFERENCES Stages(stage_id) -- Relacionamento com a tabela Stages
);

CREATE TABLE Channels (
    channel_id SERIAL PRIMARY KEY,                 -- ID do canal
    description TEXT,                               -- Descrição do canal
    type VARCHAR(20) CHECK (type IN ('Telefone', 'WhatsApp', 'Telegram', 'Messenger Facebook', 'Instagram', 'Formulário', 'Chat', 'E-mail', 'Visita tecnica')),  -- Tipo de canal
    stage_id INT,                                  -- ID do estágio (referência à tabela Stages)
    channel_status VARCHAR(10) CHECK (channel_status IN ('Ativo', 'Inativo')),  -- Status do canal
    num_entries INT DEFAULT 0,                      -- Contagem de entradas (oportunidades)
    num_active_opps INT DEFAULT 0,                  -- Contagem de oportunidades ativas
    active_opps_values DECIMAL(10, 2) DEFAULT 0.0,  -- Soma de todas as quote_value (oportunidades)
    total_sales_values DECIMAL(10, 2) DEFAULT 0.0,  -- Soma de todas as vendas geradas no estágio "Sale"
    num_sales INT DEFAULT 0,                        -- Contagem de vendas realizadas
    loss_sales_values DECIMAL(10, 2) DEFAULT 0.0,   -- Soma de todas as vendas perdidas (no estágio 'Loss sale')
    num_loss_sales INT DEFAULT 0,                   -- Contagem de todas as vendas perdidas
    CONSTRAINT fk_stage_id FOREIGN KEY (stage_id) REFERENCES Stages(stage_id)  -- Relacionamento com a tabela Stages
);