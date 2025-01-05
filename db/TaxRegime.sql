CREATE TABLE TaxRegime (
    tax_regime_id SERIAL PRIMARY KEY, -- Chave primária
    tax_regime VARCHAR(100) NOT NULL UNIQUE, -- Nome do regime tributário (único)
    num_companies INTEGER DEFAULT 0, -- Número de empresas (opcional, para cálculos automáticos)
    num_clients INTEGER DEFAULT 0 -- Número de clientes (opcional, para cálculos automáticos)
);