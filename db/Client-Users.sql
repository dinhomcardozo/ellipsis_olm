-- Criação da Tabela de Relacionamento entre Clients e Users
CREATE TABLE Clients_Users (
    client_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    PRIMARY KEY (client_id, user_id),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Índices para melhorar o desempenho de buscas
CREATE INDEX idx_client_id ON Clients_Users(client_id);
CREATE INDEX idx_user_id ON Clients_Users(user_id);
