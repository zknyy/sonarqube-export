select
		substring(p.kee , 1, position( p.long_name in p.kee)-2) as project,
		sum (case i.status 	when 'CLOSED' then 0 else i.effort end) as "remain effort (mins)",
		count (i.id) as "issues:Subtotal",
		--count (i.status),				
		--OPEN	CLOSED 	REOPENED
		count (case i.status	when 'OPEN' then 1 end) as  "status:OPEN",
		count (case i.status	when 'CLOSED' then 2 end) as  "status:CLOSED",
		count (case i.status	when 'REOPENED' then 3 end) as  "status:REOPENED",
		--count (i.severity),		
		--BLOCKER		CRITICAL		MAJOR		MINOR		INFO
		count (case i.severity	when 'BLOCKER' then 1 end) as  "severity:BLOCKER",
		count (case i.severity	when 'CRITICAL' then 2 end) as  "severity:CRITICAL",
		count (case i.severity	when 'MAJOR' then 3 end) as  "severity:MAJOR",
		count (case i.severity	when 'MINOR' then 1 end) as  "severity:MINOR",
		count (case i.severity	when 'INFO' then 2 end) as  "severity:INFO",
		--count(i.issue_type) as type,
		--Vulnerability		Bug		Code Smell
		count (case i.issue_type	when 3 then 3 end) as  "type:Vulnerability",
		count (case i.issue_type	when 2 then 2 end) as  "type:Bug",
		count (case i.issue_type	when 1 then 1 end) as  "type:Code Smell"
	from
		issues as i
	inner join projects as p on
		i.project_uuid = p.project_uuid
		and i.component_uuid = p.uuid 
	group by 		
    substring(p.kee , 1, position( p.long_name in p.kee)-2)
    order by substring(p.kee , 1, position( p.long_name in p.kee)-2)
	