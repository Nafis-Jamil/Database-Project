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