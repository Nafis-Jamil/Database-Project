set serveroutput on;
declare
cid vote.candidate_id%type;
vid vote.voter_id%type;
begin
vid:=&voter_id;
cid:=&candidate_id;
insert into vote(voter_id,candidate_id)values (vid,cid);
end;
/
