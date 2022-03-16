-- DROP TABLE IF EXISTS `end_line_fault_log`;
-- DROP TABLE IF EXISTS `end_line_session`;

-- CREATE TABLE IF NOT EXISTS end_line_session(
-- EndLineSessionID INT NOT NULL AUTO_INCREMENT,
-- LineID INT NOT NULL,
-- SectionID INT NOT NULL,
-- BundleID INT NOT NULL,
-- PieceID INT NOT NULL,
-- UserID INT NOT NULL,
-- Status TINYINT NOT NULL DEFAULT 0,
-- CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- CONSTRAINT PK_EndLineSessionNew PRIMARY KEY(EndLineSessionID),
-- CONSTRAINT FK_EndLineSessionNew_Line FOREIGN KEY(LineID) REFERENCES line(LineID),
-- CONSTRAINT FK_EndLineSessionNew_Section FOREIGN KEY(SectionID) REFERENCES section(SectionID),
-- CONSTRAINT FK_EndLineSessionNew_CutReport FOREIGN KEY(BundleID) REFERENCES cut_report(BundleID),
-- CONSTRAINT FK_EndLineSessionNew_PieceWiseCutReport FOREIGN KEY(PieceID) REFERENCES piece_wise_cut_report(PieceID),
-- CONSTRAINT FK_EndLineSessionNew_User FOREIGN KEY(UserID) REFERENCES user(UserID),
-- CONSTRAINT CK_EndLineSessionNew_Status CHECK(Status IN(0,1,2,3,4,5,6,7,8)));


-- -- -- INSERT INTO EndLineSessionNew(LineID,SectionID,BundleID,PieceID,UserID)
-- -- -- VALUES(1,1,1,1,1);


-- CREATE TABLE IF NOT EXISTS end_line_fault_log(
-- EndLineFaultLogID INT NOT NULL AUTO_INCREMENT,
-- EndLineSessionID INT NOT NULL,
-- FaultID INT NOT NULL,
-- FaultCount INT NOT NULL,
-- PieceWiseScanningID INT NOT NULL,
-- CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- CONSTRAINT PK_EndLineFaultLogNew PRIMARY KEY(EndLineFaultLogID),
-- CONSTRAINT FK_EndLineFaultLogNew_EndLineSessionNew FOREIGN KEY(EndLineSessionID) REFERENCES end_line_session(EndLineSessionID),
-- CONSTRAINT FK_EndLineFaultLogNew_Fault FOREIGN KEY(FaultID) REFERENCES fault(FaultID),
-- CONSTRAINT FK_EndLineFaultLogNew_PieceWiseScan FOREIGN KEY(PieceWiseScanningID) REFERENCES piece_wise_scan(PieceWiseScanningID)
-- );


-- -- -- INSERT INTO EndLineFaultLogNew(EndLinSessionNewID,FaultID,FaultCount,PieceWiseScanID)
-- -- -- VALUES (1,1,3,1);


SHOW CREATE TABLE end_line_fault_log;
