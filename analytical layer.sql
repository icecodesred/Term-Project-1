CREATE DATABASE shakespeare;
-- database creation

-- Next step is loading the csv files into the database. I did this with sql export then import wizard.

-- setting primary keys
ALTER TABLE works ADD PRIMARY KEY (id);
ALTER TABLE characters ADD primary key (id);
ALTER TABLE paragraphs ADD primary key (id);
ALTER TABLE chapters ADD PRIMARY KEY (id);

-- creating the analytical table
DROP TABLE IF EXISTS PlaySummary;
CREATE TABLE PlaySummary (
    SummaryID INT PRIMARY KEY AUTO_INCREMENT,
    WorkID INT,
    CharacterID INT,
    ParagraphCount INT,
    WordCount INT,
    FOREIGN KEY (WorkID) REFERENCES works(id),
    FOREIGN KEY (CharacterID) REFERENCES characters(id)
);

-- correcting the issue of missing character ids
INSERT INTO characters (id, CharName, Abbrev, Description)
SELECT DISTINCT p.character_id, 'Unknown', 'UNK', 'Placeholder for missing character'
FROM paragraphs p
LEFT JOIN characters c ON p.character_id = c.id
WHERE c.id IS NULL;

-- creating the column for word count
ALTER TABLE paragraphs ADD COLUMN WordCount INT;



