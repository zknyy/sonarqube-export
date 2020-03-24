select
	i.id,
	/*
	case
		i.issue_type
		when 1 then concat ('https://sonarqube.int.vwg-connect.cn/issues?open=' ,
		i.kee)
		when 2 then concat ('https://sonarqube.int.vwg-connect.cn/project/issues?id=com.timanetworks%3Astatic-data&issues=' ,
		i.kee,
		'&open=',
		i.kee)
		--		https://sonarqube.int.vwg-connect.cn/project/issues?id=com.timanetworks%3Astatic-data&issues=AW-DB5OZQ0wdSgu23GbO&open=AW-DB5OZQ0wdSgu23GbO
		when 3 then concat ('https://sonarqube.int.vwg-connect.cn/issues?open=' ,
		i.kee)
		else 'itbilu.com' end as URL,
		*/
		concat ('https://sonarqube.int.vwg-connect.cn/project/issues?id=',
		substring(p.kee ,1, POSITION( p.long_name in p.kee)-2)
		,'&issues=' ,	i.kee,		'&open=',		i.kee) as URL,
		case
			i.issue_type
			when 1 then 'Code Smell'
			when 2 then 'Bug'
			when 3 then 'Vulnerability'
			else 'Unknown' end as type,
			i.severity ,
			i.status ,
			i.message as description,
			--i.project_uuid as iuuid,
			--p.project_uuid as puuid,
			--i.component_uuid ,
			p."language" ,
			--p.kee ,
			--substring(p.kee ,1, POSITION( p.long_name in p.kee)-2),
 			p.name as "file name",
--	p.long_name ,
--	p.path,
--	p.module_uuid_path ,
	i.line ,
	--concat(i.effort , ' mins') as effort,
    i.effort  as "effort with mins",
	--	TO_TIMESTAMP(i.updated_at),
	--	TO_TIMESTAMP(	i.issue_creation_date),
	--	TO_TIMESTAMP(	i.issue_update_date),
	--	TO_TIMESTAMP(	i.issue_close_date),
 i.tags,
--	i.project_uuid,
	--i.component_uuid,
	--i.locations,
		--	i.action_plan_key,
		--	i.issue_attributes,
		--	i.checksum,
		--	i.gap,
		--TO_TIMESTAMP (i.created_at),
		--	to_date(i.created_at) ,
		--	i.resolution ,
 i.manual_severity ,
		i.reporter,
		i.assignee
		--	r.*
		from
			issues as i
		inner join projects as p on
			i.project_uuid = p.project_uuid
			and i.component_uuid = p.uuid 
			--inner join rules as r on
			--	i.rule_id = r.id
			/*
			where
			i.kee = 'AW-DB5N0Q0wdSgu23GaZ'
			or 
			i.kee = 'AW-DB5N0Q0wdSgu23Gac'
			or 
			i.kee = 'AW-DB5OZQ0wdSgu23GbO'
			*/
			order by i.id
			--https://sonarqube.int.vwg-connect.cn/project/issues?id=com.timanetworks%3Astatic-data&issues=AW-DB5OZQ0wdSgu23GbO&open=AW-DB5OZQ0wdSgu23GbO
 /*
	 * 	id,
	kee,
	rule_id,
	severity,
	manual_severity,
	message,
	line,
	gap,
	status,
	resolution,
	checksum,
	reporter,
	assignee,
	author_login,
	action_plan_key,
	issue_attributes,
	effort,
	created_at,
	updated_at,
	issue_creation_date,
	issue_update_date,
	issue_close_date,
	tags,
	component_uuid,
	project_uuid,
	locations,
	issue_type
	 */