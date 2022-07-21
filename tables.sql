DROP TABLE candidate_asset;
DROP TABLE candidate_criminal_record;
DROP TABLE candidate_education;
DROP TABLE complaints;
DROP TABLE vote;
DROP TABLE candidates;
DROP TABLE party;
DROP TABLE voters;
DROP TABLE voting_center;

CREATE TABLE voting_center(
    center_id NUMBER(8) NOT NULL,
    location VARCHAR(50) NOT NULL,
    vote_date DATE NOT NULL,
    PRIMARY KEY(center_id)
);

CREATE TABLE voters(
    nid NUMBER(10) NOT NULL,
    name VARCHAR(30) NOT NULL,
    father_name VARCHAR(30) NOT NULL,
    mother_name VARCHAR(30) NOT NULL,
    date_of_birth DATE NOT NULL,
    street VARCHAR(50),
    gender VARCHAR(20) CHECK (gender IN ('MALE','FEMALE','male','female','Male','Female','Non-binary')) NOT NULL,
    vote_center_id NUMBER(8) NOT NULL,
    PRIMARY KEY (nid),
    FOREIGN KEY(vote_center_id) REFERENCES voting_center(center_id) ON DELETE CASCADE
);


CREATE TABLE complaints(
    complaint_type VARCHAR(30) NOT NULL,
    details VARCHAR(50) NOT NULL,
    complainer_id NUMBER(10) NOT NULL,
    FOREIGN KEY(complainer_id) REFERENCES voters(nid) ON DELETE CASCADE
);

CREATE TABLE party(
    party_id NUMBER(8) NOT NULL,
    party_name VARCHAR(30) NOT NULL UNIQUE,
    party_symbol VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY(party_id)
);

CREATE TABLE candidates(
    candidate_id NUMBER(8) NOT NULL,
    nid NUMBER(10) NOT NULL,
    party_id NUMBER(8) NOT NULL,
    PRIMARY KEY(candidate_id),
    FOREIGN KEY(nid) REFERENCES voters(nid) ON DELETE CASCADE,
    FOREIGN KEY(party_id) REFERENCES party(party_id) ON DELETE CASCADE
);

CREATE TABLE vote(
    vote_id NUMBER(10) NOT NULL,
    voter_id NUMBER(10) UNIQUE NOT NULL,
    candidate_id NUMBER(8) NOT NULL,
    PRIMARY KEY(vote_id),
    FOREIGN KEY(voter_id) REFERENCES voters(nid) on DELETE CASCADE,
    FOREIGN KEY(candidate_id) REFERENCES candidates(candidate_id) on DELETE CASCADE
);


CREATE TABLE candidate_education(
    education_level VARCHAR(30) NOT NULL,
    passing_year NUMBER(8),
    candidate_id NUMBER(8) NOT NULL,
    FOREIGN KEY(candidate_id) REFERENCES candidates(candidate_id) ON DELETE CASCADE
);

CREATE TABLE candidate_criminal_record(
    crime_type VARCHAR(30) NOT NULL,
    conviction VARCHAR(30) NOT NULL,
    jail_name VARCHAR(30),
    candidate_id NUMBER(8) NOT NULL,
    FOREIGN KEY(candidate_id) REFERENCES candidates(candidate_id) ON DELETE CASCADE
);

CREATE TABLE candidate_asset(
    asset_type VARCHAR(30) NOT NULL,
    asset_name VARCHAR(30),
    asset_valuation NUMBER(12),
    candidate_id NUMBER(8) NOT NULL,
    FOREIGN KEY(candidate_id) REFERENCES candidates(candidate_id) ON DELETE CASCADE
);

