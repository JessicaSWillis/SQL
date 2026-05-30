desc storefront
desc productlist

ALTER TABLE productlist
ADD price number
ADD description varchar2 (255)

UPDATE productlist p
SET p.price = (
    SELECT s.price
    FROM storefront s
    WHERE s.productcode = p.productcode
);

UPDATE productlist p
SET p.description = (
    SELECT s.description
    FROM storefront s
    WHERE s.productcode = p.productcode
);

DROP TABLE storefront;

SELECT * FROM productlist

-- 2

CREATE TABLE CHATLOG (
    CHATID NUMBER(3),
    RECEIVERID NUMBER(3),
    SENDERID NUMBER(3),
    DATESENT DATE,
    CONTENT VARCHAR2(250),

    CONSTRAINT PK_CHATLOG
        PRIMARY KEY (CHATID),

    CONSTRAINT FK_CHATLOG_RECEIVER
        FOREIGN KEY (RECEIVERID)
        REFERENCES USERBASE(USERID),

    CONSTRAINT FK_CHATLOG_SENDER
        FOREIGN KEY (SENDERID)
        REFERENCES USERBASE(USERID)
);

INSERT INTO CHATLOG VALUES (1, 101, 102, TO_DATE('2025-05-01','YYYY-MM-DD'), 'Hey, want to play tonight?')
INSERT INTO CHATLOG VALUES (2, 102, 101, TO_DATE('2025-05-01','YYYY-MM-DD'), 'Sure, what game?')
INSERT INTO CHATLOG VALUES (3, 103, 101, TO_DATE('2025-05-02','YYYY-MM-DD'), 'Welcome to VaporGames!')
INSERT INTO CHATLOG VALUES (4, 104, 103, TO_DATE('2025-05-02','YYYY-MM-DD'), 'Thanks for the invite.')
INSERT INTO CHATLOG VALUES (5, 105, 102, TO_DATE('2025-05-03','YYYY-MM-DD'), 'Ready for the tournament?')
INSERT INTO CHATLOG VALUES (6, 102, 105, TO_DATE('2025-05-03','YYYY-MM-DD'), 'Absolutely!')
INSERT INTO CHATLOG VALUES (7, 101, 104, TO_DATE('2025-05-04','YYYY-MM-DD'), 'Can you send the game code?')
INSERT INTO CHATLOG VALUES (8, 104, 101, TO_DATE('2025-05-04','YYYY-MM-DD'), 'I sent it a few minutes ago.')
INSERT INTO CHATLOG VALUES (9, 103, 105, TO_DATE('2025-05-05','YYYY-MM-DD'), 'Good luck in your match!')
INSERT INTO CHATLOG VALUES (10, 105, 103, TO_DATE('2025-05-05','YYYY-MM-DD'), 'Thank you!')
INSERT INTO CHATLOG VALUES (11, 102, 104, TO_DATE('2025-05-06','YYYY-MM-DD'), 'Want to join our team?')
INSERT INTO CHATLOG VALUES (12, 104, 102, TO_DATE('2025-05-06','YYYY-MM-DD'), 'Yes, count me in.')

SELECT * FROM chatlog

--3
CREATE TABLE FRIENDSLIST (
    USERID NUMBER(3),
    FRIENDID NUMBER(3),

    CONSTRAINT PK_FRIENDSLIST
        PRIMARY KEY (USERID, FRIENDID),

    CONSTRAINT FK_FRIENDSLIST_USER
        FOREIGN KEY (USERID)
        REFERENCES USERBASE(USERID),

    CONSTRAINT FK_FRIENDSLIST_FRIEND
        FOREIGN KEY (FRIENDID)
        REFERENCES USERBASE(USERID)
);

INSERT INTO FRIENDSLIST VALUES (101, 102);
INSERT INTO FRIENDSLIST VALUES (101, 103);
INSERT INTO FRIENDSLIST VALUES (101, 104);
INSERT INTO FRIENDSLIST VALUES (102, 101);
INSERT INTO FRIENDSLIST VALUES (102, 105);
INSERT INTO FRIENDSLIST VALUES (103, 101);
INSERT INTO FRIENDSLIST VALUES (103, 104);
INSERT INTO FRIENDSLIST VALUES (104, 101);
INSERT INTO FRIENDSLIST VALUES (104, 103);
INSERT INTO FRIENDSLIST VALUES (104, 105);
INSERT INTO FRIENDSLIST VALUES (105, 102);
INSERT INTO FRIENDSLIST VALUES (105, 104);

SELECT * FROM friendslist

--4
CREATE TABLE WISHLIST (
    USERID NUMBER(3),
    PRODUCTCODE VARCHAR2(5),
    POSITION NUMBER(3),

    CONSTRAINT PK_WISHLIST
        PRIMARY KEY (USERID, PRODUCTCODE),

    CONSTRAINT FK_WISHLIST_USER
        FOREIGN KEY (USERID)
        REFERENCES USERBASE(USERID),

    CONSTRAINT FK_WISHLIST_PRODUCT
        FOREIGN KEY (PRODUCTCODE)
        REFERENCES PRODUCTLIST(PRODUCTCODE)
);


INSERT INTO WISHLIST VALUES (101, 'GAME1', 1)
INSERT INTO WISHLIST VALUES (101, 'GAME2', 2)
INSERT INTO WISHLIST VALUES (101, 'GAME3', 3)

INSERT INTO WISHLIST VALUES (102, 'GAME1', 1)
INSERT INTO WISHLIST VALUES (102, 'GAME2', 2)

INSERT INTO WISHLIST VALUES (103, 'GAME1', 1)
INSERT INTO WISHLIST VALUES (103, 'GAME2', 2)

INSERT INTO WISHLIST VALUES (104, 'GAME1', 1)
INSERT INTO WISHLIST VALUES (104, 'GAME2', 2)
INSERT INTO WISHLIST VALUES (104, 'GAME3', 3)

INSERT INTO WISHLIST VALUES (105, 'GAME1', 1)
INSERT INTO WISHLIST VALUES (105, 'GAME2', 2)
INSERT INTO WISHLIST VALUES (105, 'GAME3', 3)

--5
CREATE TABLE USERPROFILE (
    USERID      NUMBER(3),
    IMAGEFILE   VARCHAR2(250),
    DESCRIPTION VARCHAR2(250),
    
    CONSTRAINT PK_USERPROFILE PRIMARY KEY (USERID),
    
    CONSTRAINT FK_USERPROFILE_USERBASE
        FOREIGN KEY (USERID)
        REFERENCES USERBASE (USERID)
);

INSERT ALL
    INTO USERPROFILE VALUES (101, 'img101.jpg', 'Profile image for user 101')
    INTO USERPROFILE VALUES (102, 'img102.jpg', 'Profile image for user 102')
    INTO USERPROFILE VALUES (103, 'img103.jpg', 'Profile image for user 103')
    INTO USERPROFILE VALUES (104, 'img104.jpg', 'Profile image for user 104')
    INTO USERPROFILE VALUES (105, 'img105.jpg', 'Profile image for user 105')

    INTO USERPROFILE VALUES (106, 'img106.jpg', 'Profile image for user 106')
    INTO USERPROFILE VALUES (107, 'img107.jpg', 'Profile image for user 107')
    INTO USERPROFILE VALUES (108, 'img108.jpg', 'Profile image for user 108')
    INTO USERPROFILE VALUES (109, 'img109.jpg', 'Profile image for user 109')
    INTO USERPROFILE VALUES (110, 'img110.jpg', 'Profile image for user 110')

    INTO USERPROFILE VALUES (111, 'img111.jpg', 'Profile image for user 111')
    INTO USERPROFILE VALUES (112, 'img112.jpg', 'Profile image for user 112')
    INTO USERPROFILE VALUES (113, 'img113.jpg', 'Profile image for user 113')
    INTO USERPROFILE VALUES (114, 'img114.jpg', 'Profile image for user 114')
    INTO USERPROFILE VALUES (115, 'img115.jpg', 'Profile image for user 115')
SELECT 1 FROM dual;

-- 6

CREATE TABLE SECURITYQUESTION (
    QUESTIONID NUMBER,
    USERID     NUMBER(3),
    QUESTION   VARCHAR2(250),
    ANSWER     VARCHAR2(250),

    CONSTRAINT PK_SECURITYQUESTION PRIMARY KEY (QUESTIONID),

    CONSTRAINT FK_SECURITYQUESTION_USERBASE
        FOREIGN KEY (USERID)
        REFERENCES USERBASE (USERID)
);

INSERT ALL
    INTO SECURITYQUESTION VALUES (1, 101, 'What is your pet’s name?', 'Buddy')
    INTO SECURITYQUESTION VALUES (2, 102, 'What is your mother’s maiden name?', 'Smith')
    INTO SECURITYQUESTION VALUES (3, 103, 'What city were you born in?', 'Norfolk')
    INTO SECURITYQUESTION VALUES (4, 104, 'What was your first school?', 'Lincoln Elementary')
    INTO SECURITYQUESTION VALUES (5, 105, 'What is your favorite color?', 'Blue')

    INTO SECURITYQUESTION VALUES (6, 106, 'What is your pet’s name?', 'Max')
    INTO SECURITYQUESTION VALUES (7, 107, 'What is your favorite food?', 'Pizza')
    INTO SECURITYQUESTION VALUES (8, 108, 'What is your father’s middle name?', 'Allen')
    INTO SECURITYQUESTION VALUES (9, 109, 'What city did you grow up in?', 'Virginia Beach')
    INTO SECURITYQUESTION VALUES (10, 110, 'What is your favorite sport?', 'Basketball')

    INTO SECURITYQUESTION VALUES (11, 111, 'What is your pet’s name?', 'Charlie')
    INTO SECURITYQUESTION VALUES (12, 112, 'What is your favorite movie?', 'Inception')
    INTO SECURITYQUESTION VALUES (13, 113, 'What was your first car?', 'Toyota')
    INTO SECURITYQUESTION VALUES (14, 114, 'What is your favorite teacher’s name?', 'Mrs. Johnson')
    INTO SECURITYQUESTION VALUES (15, 115, 'What is your favorite book?', 'Harry Potter')
SELECT 1 FROM dual;

-- 7

CREATE TABLE COMMUNITYRULES (
    RULENUM        NUMBER(3),
    TITLE          VARCHAR2(250),
    DESCRIPTION    VARCHAR2(250),
    SEVERITYPOINT  NUMBER(4),

    CONSTRAINT PK_COMMUNITYRULES PRIMARY KEY (RULENUM)
);

INSERT ALL
    INTO COMMUNITYRULES VALUES (1, 'No Spam', 'Do not post repetitive or irrelevant content', 50)
    INTO COMMUNITYRULES VALUES (2, 'Be Respectful', 'No harassment or abusive language', 80)
    INTO COMMUNITYRULES VALUES (3, 'No Hate Speech', 'Hate speech of any kind is prohibited', 100)
    INTO COMMUNITYRULES VALUES (4, 'No Fake News', 'Do not share false or misleading information', 70)
    INTO COMMUNITYRULES VALUES (5, 'No Advertising', 'Unauthorized advertising is not allowed', 60)

    INTO COMMUNITYRULES VALUES (6, 'Use Appropriate Language', 'Avoid offensive or vulgar language', 40)
    INTO COMMUNITYRULES VALUES (7, 'No Impersonation', 'Do not pretend to be another user or admin', 90)
    INTO COMMUNITYRULES VALUES (8, 'Respect Privacy', 'Do not share personal information of others', 85)
    INTO COMMUNITYRULES VALUES (9, 'No Malware Links', 'Posting harmful links is strictly prohibited', 100)
    INTO COMMUNITYRULES VALUES (10, 'Follow Topic', 'Keep discussions relevant to the topic', 30)

    INTO COMMUNITYRULES VALUES (11, 'No Trolling', 'Do not deliberately provoke other users', 75)
    INTO COMMUNITYRULES VALUES (12, 'No Duplicate Posts', 'Avoid posting the same content repeatedly', 45)
    INTO COMMUNITYRULES VALUES (13, 'Use Real Identity', 'Do not create misleading accounts', 65)
    INTO COMMUNITYRULES VALUES (14, 'No Plagiarism', 'Do not copy content without credit', 90)
    INTO COMMUNITYRULES VALUES (15, 'Report Violations', 'Users must report rule violations when seen', 20)
SELECT 1 FROM dual;

-- 8

CREATE TABLE INFRACTIONS (
    INFRACTIONID  NUMBER,
    USERID        NUMBER(3),
    RULENUM       NUMBER(3),
    DATEASSIGNED  DATE,
    PENALTY       VARCHAR2(250),

    CONSTRAINT PK_INFRACTIONS PRIMARY KEY (INFRACTIONID),

    CONSTRAINT FK_INFRACTIONS_USERBASE
        FOREIGN KEY (USERID)
        REFERENCES USERBASE (USERID),

    CONSTRAINT FK_INFRACTIONS_COMMUNITYRULES
        FOREIGN KEY (RULENUM)
        REFERENCES COMMUNITYRULES (RULENUM)
);

INSERT ALL
    INTO INFRACTIONS VALUES (1, 101, 1, TO_DATE('2026-01-05','YYYY-MM-DD'), 'Warning issued')
    INTO INFRACTIONS VALUES (2, 102, 2, TO_DATE('2026-01-06','YYYY-MM-DD'), 'Temporary suspension')
    INTO INFRACTIONS VALUES (3, 103, 3, TO_DATE('2026-01-07','YYYY-MM-DD'), 'Account restricted')
    INTO INFRACTIONS VALUES (4, 104, 4, TO_DATE('2026-01-08','YYYY-MM-DD'), 'Content removed')
    INTO INFRACTIONS VALUES (5, 105, 5, TO_DATE('2026-01-09','YYYY-MM-DD'), 'Warning issued')

    INTO INFRACTIONS VALUES (6, 106, 6, TO_DATE('2026-01-10','YYYY-MM-DD'), 'Comment deleted')
    INTO INFRACTIONS VALUES (7, 107, 7, TO_DATE('2026-01-11','YYYY-MM-DD'), 'Account warning')
    INTO INFRACTIONS VALUES (8, 108, 8, TO_DATE('2026-01-12','YYYY-MM-DD'), 'Privacy violation notice')
    INTO INFRACTIONS VALUES (9, 109, 9, TO_DATE('2026-01-13','YYYY-MM-DD'), 'Link removed and warning')
    INTO INFRACTIONS VALUES (10, 110, 10, TO_DATE('2026-01-14','YYYY-MM-DD'), 'Topic violation warning')

    INTO INFRACTIONS VALUES (11, 111, 11, TO_DATE('2026-01-15','YYYY-MM-DD'), 'Trolling warning issued')
    INTO INFRACTIONS VALUES (12, 112, 12, TO_DATE('2026-01-16','YYYY-MM-DD'), 'Duplicate post removed')
    INTO INFRACTIONS VALUES (13, 113, 13, TO_DATE('2026-01-17','YYYY-MM-DD'), 'Identity warning')
    INTO INFRACTIONS VALUES (14, 114, 14, TO_DATE('2026-01-18','YYYY-MM-DD'), 'Plagiarism strike issued')
    INTO INFRACTIONS VALUES (15, 115, 15, TO_DATE('2026-01-19','YYYY-MM-DD'), 'Report reminder sent')
SELECT 1 FROM dual;

-- 9

CREATE TABLE USERSUPPORT (
    TICKETID       NUMBER,
    EMAIL          VARCHAR2(250),
    ISSUE          VARCHAR2(250),
    DATESUBMITTED  DATE,
    DATEUPDATED    DATE,
    STATUS         VARCHAR2(250),

    CONSTRAINT PK_USERSUPPORT PRIMARY KEY (TICKETID)
);

INSERT ALL
    INTO USERSUPPORT VALUES (1, 'user101@email.com', 'Login not working', TO_DATE('2026-05-01','YYYY-MM-DD'), TO_DATE('2026-05-02','YYYY-MM-DD'), 'Resolved')
    INTO USERSUPPORT VALUES (2, 'user102@email.com', 'Password reset issue', TO_DATE('2026-05-02','YYYY-MM-DD'), TO_DATE('2026-05-03','YYYY-MM-DD'), 'In Progress')
    INTO USERSUPPORT VALUES (3, 'user103@email.com', 'Account locked', TO_DATE('2026-05-03','YYYY-MM-DD'), TO_DATE('2026-05-04','YYYY-MM-DD'), 'Resolved')
    INTO USERSUPPORT VALUES (4, 'user104@email.com', 'Profile not loading', TO_DATE('2026-05-04','YYYY-MM-DD'), TO_DATE('2026-05-05','YYYY-MM-DD'), 'Open')
    INTO USERSUPPORT VALUES (5, 'user105@email.com', 'Cannot upload image', TO_DATE('2026-05-05','YYYY-MM-DD'), TO_DATE('2026-05-06','YYYY-MM-DD'), 'Resolved')

    INTO USERSUPPORT VALUES (6, 'user106@email.com', 'Email not verified', TO_DATE('2026-05-06','YYYY-MM-DD'), TO_DATE('2026-05-07','YYYY-MM-DD'), 'In Progress')
    INTO USERSUPPORT VALUES (7, 'user107@email.com', 'App crash on login', TO_DATE('2026-05-07','YYYY-MM-DD'), TO_DATE('2026-05-08','YYYY-MM-DD'), 'Open')
    INTO USERSUPPORT VALUES (8, 'user108@email.com', 'Security question reset', TO_DATE('2026-05-08','YYYY-MM-DD'), TO_DATE('2026-05-09','YYYY-MM-DD'), 'Resolved')
    INTO USERSUPPORT VALUES (9, 'user109@email.com', 'Cannot change password', TO_DATE('2026-05-09','YYYY-MM-DD'), TO_DATE('2026-05-10','YYYY-MM-DD'), 'In Progress')
    INTO USERSUPPORT VALUES (10, 'user110@email.com', 'Missing profile data', TO_DATE('2026-05-10','YYYY-MM-DD'), TO_DATE('2026-05-11','YYYY-MM-DD'), 'Open')

    INTO USERSUPPORT VALUES (11, 'user111@email.com', 'Notification not working', TO_DATE('2026-05-11','YYYY-MM-DD'), TO_DATE('2026-05-12','YYYY-MM-DD'), 'Resolved')
    INTO USERSUPPORT VALUES (12, 'user112@email.com', 'Slow performance', TO_DATE('2026-05-12','YYYY-MM-DD'), TO_DATE('2026-05-13','YYYY-MM-DD'), 'Open')
    INTO USERSUPPORT VALUES (13, 'user113@email.com', 'Cannot delete account', TO_DATE('2026-05-13','YYYY-MM-DD'), TO_DATE('2026-05-14','YYYY-MM-DD'), 'In Progress')
    INTO USERSUPPORT VALUES (14, 'user114@email.com', 'Data sync issue', TO_DATE('2026-05-14','YYYY-MM-DD'), TO_DATE('2026-05-15','YYYY-MM-DD'), 'Resolved')
    INTO USERSUPPORT VALUES (15, 'user115@email.com', 'Error on dashboard', TO_DATE('2026-05-15','YYYY-MM-DD'), TO_DATE('2026-05-16','YYYY-MM-DD'), 'Open')
SELECT 1 FROM dual;

-- 10

CREATE OR REPLACE VIEW UNIQUE_SECURITY_QUESTIONS AS
SELECT DISTINCT QUESTION
FROM SECURITYQUESTION;

SELECT * FROM UNIQUE_SECURITY_QUESTIONS

CREATE OR REPLACE VIEW ACTIVE_SUPPORT_TICKETS AS
SELECT 
    TICKETID,
    EMAIL,
    ISSUE,
    DATEUPDATED
FROM USERSUPPORT
WHERE STATUS IN ('Open', 'In Progress')
ORDER BY DATEUPDATED ASC;

SELECT * FROM ACTIVE_SUPPORT_TICKETS