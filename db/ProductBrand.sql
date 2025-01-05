CREATE TABLE ProductBrand (
    brand_id SERIAL PRIMARY KEY,                 -- ID da marca (chave primária)
    brand_name VARCHAR(15),                      -- Nome da marca
    brand_status VARCHAR(10) CHECK (brand_status IN ('Ativo', 'Inativo'))  -- Status da marca ('Ativo' ou 'Inativo')
);