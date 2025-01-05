CREATE TABLE Segments (
    segment_id SERIAL PRIMARY KEY, -- Chave primária
    segment_name VARCHAR(50) NOT NULL UNIQUE -- Nome do segmento (único)
);

CREATE TABLE SubSegments (
    subsegment_id SERIAL PRIMARY KEY, -- Chave primária
    subsegment_name VARCHAR(100) NOT NULL UNIQUE -- Nome do subsegmento (único)
);