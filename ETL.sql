-- a trigger to update wordcount is useful

DELIMITER //
DROP TRIGGER IF EXISTS CalculateWordCount;
CREATE TRIGGER CalculateWordCount
BEFORE INSERT ON paragraphs
FOR EACH ROW
BEGIN
    SET NEW.WordCount = LENGTH(NEW.PlainText) - LENGTH(REPLACE(NEW.PlainText, ' ', '')) + 1;
END //
DELIMITER ;

-- stored procedure to insert into analytical table (PlaySummary)

DELIMITER //
DROP PROCEDURE IF EXISTS LoadPlaySummary;
CREATE PROCEDURE LoadPlaySummary()
BEGIN
    INSERT INTO PlaySummary (WorkID, CharacterID, ParagraphCount, WordCount)
    SELECT 
        ch.work_id,
        p.character_id,
        COUNT(p.id),
        SUM(LENGTH(p.PlainText) - LENGTH(REPLACE(p.PlainText, ' ', '')) + 1)
    FROM chapters ch
    JOIN paragraphs p ON p.chapter_id = ch.id
    GROUP BY ch.work_id, p.character_id;
END //
DELIMITER ;
