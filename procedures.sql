set serveroutput on

-- non voters

create or replace procedure non_voters is

cursor nv_cur is select nid, name, vote_center_id
from voters
where nid not in (select voter_id from vote);
nv nv_cur%ROWTYPE;

begin
DBMS_OUTPUT.put_line('Here is a list of people who did not vote');
open nv_cur;
loop
fetch nv_cur into nv;
EXIT WHEN nv_cur%NOTFOUND;
DBMS_OUTPUT.put_line('NID:' || nv.nid || ' Name:' || nv.name || ' Vote Center:' || nv.vote_center_id);
end loop;
close nv_cur;
end;
/
show error;


-- voter count

create or replace procedure voter_count is

cursor vc_cur is select vote_center_id as vote_center,count(nid) as total_voters
from voters
group by vote_center_id;
vc vc_cur%ROWTYPE;

begin
DBMS_OUTPUT.put_line('Total Voters Group By Voting Center');
open vc_cur;
loop
fetch vc_cur into vc;
EXIT WHEN vc_cur%NOTFOUND;
DBMS_OUTPUT.put_line('Voting Center:' || vc.vote_center || ' Total Voters:' || vc.total_voters);
end loop;
close vc_cur;
end;
/
show error;

-- result by location


create or replace procedure result_by_location (cid candidates.candidate_id%type)
is
cursor rl_cur is select vt.vote_center_id as voting_center, count(v.vote_id) as total_votes
from vote v join voters vt on v.voter_id = vt.nid
where v.candidate_id=cid
group by vt.vote_center_id;
rl rl_cur%ROWTYPE;
begin
open rl_cur;
loop
fetch rl_cur into rl;
exit WHEN rl_cur%NOTFOUND;
DBMS_OUTPUT.put_line('Voting Center:' || rl.voting_center || ' Total Votes:' || rl.total_votes);
end loop;
close rl_cur;
end;
/
show error;

-- vote

create or replace procedure give_vote
(cid vote.candidate_id%type, vid vote.voter_id%type) is
begin
insert into vote (voter_id, candidate_id) values (vid, cid);
end;
/

-- winner
create or replace function total_voter return number is
tot_votes number;
begin
select count(vote_id) into tot_votes
from vote;
return tot_votes;
end;
/
show error;



create or replace procedure edu_record (cid candidate_education.candidate_id%type) is
cursor ed_cur is select *from candidate_education where candidate_id=cid;
ed ed_cur%ROWTYPE;

begin
DBMS_OUTPUT.put_line('Here is the educational record of candidate no. '||cid);
open ed_cur;
loop
fetch ed_cur into ed;
EXIT WHEN ed_cur%NOTFOUND;
DBMS_OUTPUT.put_line('Level:' || ed.education_level || ' Year:' || ed.passing_year);
end loop;
close ed_cur;
end;
/
show error;