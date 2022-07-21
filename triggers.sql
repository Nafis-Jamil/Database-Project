DROP SEQUENCE center_seq;
CREATE SEQUENCE center_seq START WITH 1;

CREATE OR REPLACE TRIGGER center_trig 
BEFORE INSERT ON voting_center 
FOR EACH ROW
BEGIN
SELECT center_seq.NEXTVAL
INTO   :new.center_id
FROM   dual;
END;
/
show errors

DROP SEQUENCE voter_seq;
CREATE SEQUENCE voter_seq START WITH 1;

CREATE OR REPLACE TRIGGER voter_trig 
BEFORE INSERT ON voters 
FOR EACH ROW
DECLARE
age number(8);
min_age number(8) := 18;
BEGIN
SELECT floor( months_between( sysdate, :new.date_of_birth) / 12 )
INTO age
FROM dual;
IF age < min_age THEN
RAISE_APPLICATION_ERROR(-20000,'New salary is too small or large');
ELSE
SELECT voter_seq.NEXTVAL
INTO   :new.nid
FROM   dual;
END IF;
END;
/
SHOW errors

DROP SEQUENCE party_seq;
CREATE SEQUENCE party_seq START WITH 1;

CREATE OR REPLACE TRIGGER party_trig 
BEFORE INSERT ON party 
FOR EACH ROW
BEGIN
SELECT party_seq.NEXTVAL
INTO   :new.party_id
FROM   dual;
END;
/
show errors

DROP SEQUENCE candidate_seq;
CREATE SEQUENCE candidate_seq START WITH 1;

CREATE OR REPLACE TRIGGER candidate_trig 
BEFORE INSERT ON candidates 
FOR EACH ROW
BEGIN
SELECT candidate_seq.NEXTVAL
INTO   :new.candidate_id
FROM   dual;
END;
/
show errors


DROP SEQUENCE vote_seq;
CREATE SEQUENCE vote_seq START WITH 1;

CREATE OR REPLACE TRIGGER vote_trig 
BEFORE INSERT ON vote 
FOR EACH ROW
BEGIN
SELECT vote_seq.NEXTVAL
INTO   :new.vote_id
FROM   dual;
END;
/
show errors