ALTER TABLE Stages
    ADD COLUMN IF NOT EXISTS stage_position INTEGER,
    ADD COLUMN IF NOT EXISTS stage_active BOOLEAN;
    ADD CONSTRAINT unique_stage_name UNIQUE (stage_name);

INSERT INTO Stages (stage_name, stage_position, stage_active)
VALUES
    ('Prospects', 1, true),
    ('Lead', 2, true),
    ('Demonstration', 3, true),
    ('Quote', 4, true),
    ('Sale', 5, true),
    ('LossSale', 6, true),
    ('PostSales', 7, true),
    ('AboutToRenew', 8, true),
    ('Renewed', 9, true),
    ('NotRenewed', 10, true)
ON CONFLICT (stage_name) 
DO UPDATE SET 
    stage_position = EXCLUDED.stage_position,
    stage_active = EXCLUDED.stage_active;