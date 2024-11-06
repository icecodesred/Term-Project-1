-- returns word count by character
DROP VIEW IF EXISTS CharacterWordCount;
CREATE VIEW CharacterWordCount AS
SELECT 
    w.Title AS Play, 
    c.CharName AS `Character`,  
    SUM(LENGTH(p.PlainText) - LENGTH(REPLACE(p.PlainText, ' ', '')) + 1) AS WordCount
FROM works w
JOIN chapters ch ON w.id = ch.work_id
JOIN paragraphs p ON p.chapter_id = ch.id
JOIN characters c ON p.character_id = c.id
GROUP BY w.Title, c.CharName;

-- returns how many paragraphs each scene has
DROP VIEW IF EXISTS ParagraphCountByScene;
CREATE VIEW ParagraphCountByScene AS
SELECT w.Title AS Play, ch.Act, ch.Scene, COUNT(p.id) AS ParagraphCount
FROM works w
JOIN chapters ch ON w.id = ch.work_id
JOIN paragraphs p ON p.chapter_id = ch.id
GROUP BY w.Title, ch.Act, ch.Scene;

-- returns total word count and total paragraph count by each play
DROP VIEW IF EXISTS PlaySummaryView
CREATE VIEW PlaySummaryView AS
SELECT w.Title AS Play, SUM(p.WordCount) AS TotalWords, COUNT(p.id) AS TotalParagraphs
FROM works w
JOIN paragraphs p ON p.chapter_id IN (SELECT id FROM chapters WHERE work_id = w.id)
GROUP BY w.Title;


