create database ipl_data;
show databases;
use ipl_data;

 #won_by biggest margin_by each team 
select max(margin), `year`, `won_by`
 FROM `ipl_data`.`match_summary1` where `won_by`='run' and winner='RCB' group by `year`;


select * from match_summary1;

# most runs in last 3 ipl
SELECT batsmanName,sum(runs) as total_runs FROM batting_summary group by batsmanName order by total_runs desc limit 10;

#highest run scorer in each year
SELECT batsmanName,sum(runs) as total_runs FROM batting_summary inner join match_summary1
on batting_summary.match_id=`ipl_data`.match_summary1.match_id
where `year`= 2022 group by batsmanName order by total_runs desc limit 10;
 
#most wickets by bowlingstyle
select bowlingStyle,sum(wickets) as Total_wickets  from bowling_summary inner join players
on bowling_summary.bowlerName= `players`.`name`
where bowlingStyle in('Right arm Fast','Right arm Fast Medium','Right arm Medium fast')
group by bowlingStyle order by Total_wickets ; 


#most runs By Playing Role
SELECT playingRole,sum(runs) as total_runs FROM batting_summary 
inner join players
on batting_summary.batsmanName =  `players`.`name`
group by playingRole order by total_runs desc ;

#total dismissed by each batsman
SELECT batsmanName, 
       COUNT(CASE WHEN `out/not_out`  = 'out' THEN 1 END) AS total_dismissed
FROM batting_summary
GROUP BY batsmanName;

#run getter by batting style
SELECT battingStyle,sum(`wickets`) as total_wickets FROM bowling_summary
inner join players
on bowling_summary.bowlerName=players.name
group by battingStyle 
order by total_wickets desc limit 10;


# stike rate top 10
select batsmanName,(sum(runs)/sum(balls))*100 as Strike_rate,playingRole  from batting_summary
inner join players 
on batting_summary.batsmanName=players.`name` 
where playingRole in('Top Order batter','Middle order Batter','All rounder','Wicketkeeper','Bowler')
group by batsmanName,playingRole
having sum(balls)>=60
order by Strike_rate desc limit 10;

#strike rate by PlayingRole
SELECT playingRole,(sum(runs)/sum(balls))*100 as Strike_rate FROM batting_summary 
inner join players
on batting_summary.batsmanName =  `players`.`name`
group by playingRole order by Strike_rate desc ;



#top 10 batsman  w.r.t batting average
SELECT batsmanName,(sum(runs)/ COUNT(CASE WHEN `out/not_out`  = 'out' THEN 1 END)) as batting_average,playingRole
FROM batting_summary
inner join players 
on batting_summary.batsmanName=players.`name` 
GROUP BY batsmanName,playingRole
having sum(balls)>60
order by batting_average desc limit 10;

#boundary percentage
SELECT distinct(batsmanName),((sum(`4s`)*4+sum(`6s`)*6)/sum(runs))*100 as total_boundary_percentage,playingRole 
from batting_summary
inner join players
on batting_summary.batsmanName=players.`name` 
where playingRole in ('Top Order batter','Middle order Batter','All rounder','Wicketkeeper','Bowler')
group by batsmanName,playingRole 
having sum(balls)>60
order by total_boundary_percentage desc limit 5;

#most boundaries by player
select batsmanName,sum(`4s`) as total_fours,sum(`6s`) as total_sixes from  batting_summary group by batsmanName order by total_sixes desc;






# top 10 wicket taker
SELECT bowlerName,sum(`wickets`) as total_wickets FROM bowling_summary group by bowlerName order by total_wickets desc limit 10;

# most wickets in each year
SELECT bowlerName,sum(wickets) as total_wickets FROM bowling_summary inner join `ipl_data`.`match_summary1` 
on bowling_summary.match_id=`ipl_data`.`match_summary1`.match_id
where `year`= 2022 group by bowlerName order by total_wickets desc limit 10;

# top 10 bowlers with most dot ball percentage
SELECT bowlerName,
      round( (SUM(`0s`) / (SUM(overs) * 6)) * 100,2) AS Dot_Percentage,playingRole
FROM bowling_summary
inner join players
on bowling_summary.bowlerName=players.`name` 
where playingRole in ('Bowler','All rounder')
GROUP BY bowlerName ,playingRole
order by Dot_percentage desc limit 10;

#most maidens
select bowlerName,sum(maiden) as total_maidens from bowling_summary group by bowlerName order by total_maidens desc limit 5;

#economy rate
select bowlerName,round((sum(runs)/(sum(overs))),2) as economy_rate from bowling_summary 
inner join players
on bowling_summary.bowlerName=players.`name` 
where playingRole in ('Bowler','All rounder')
group by bowlerName 
having sum(overs)*6>=60
order by economy_rate;

#bowling Average
select bowlerName,(sum(runs)/sum(wickets)) as Bowling_avg,sum(wickets) AS TOTAL_WICKETS from bowling_summary 
inner join players
on bowling_summary.bowlerName=players.`name` 
where playingRole in ('Bowler','All rounder')
group by bowlerName 
having sum(overs)*6>=60
order by sum(wickets) desc
;

#bowling average by each year for particular bowler
select bowlerName,round((sum(runs)/sum(wickets)),2) as Bowling_avg,sum(wickets) AS TOTAL_WICKETS from bowling_summary 
inner join `ipl_data`.`match_summary1` 
on bowling_summary.match_id=`ipl_data`.`match_summary1`.match_id
where  `year` =2022
group by  bowlerName 
having sum(overs)*6>=60
order by  Bowling_avg asc limit 10;


#total wins in last 3 years
SELECT winner,count(`winner`) as total_wins FROM `ipl_data`.`match_summary1` group by winner order by total_wins desc;

# Chasing Time winner
SELECT `team2`,count('team2') as Won_by_chase
FROM `ipl_data`.`match_summary1`
where team2=winner
group by team2
order by Won_by_chase desc;

#target defend
SELECT `team1`,count('team1') as target_defend
FROM `ipl_data`.`match_summary1`
where team1=winner
group by team1
order by target_defend desc;

#won bY
SELECT `won_by`,count(won_by) AS won_by_count FROM `ipl_data`.`match_summary1` where  year =2021 group by won_by;

# Batting avg by Playing Role
SELECT (sum(runs)/ COUNT(CASE WHEN `out/not_out`  = 'out' THEN 1 END)) as batting_average,playingRole
FROM batting_summary
inner join players 
on batting_summary.batsmanName=players.`name` 
GROUP BY playingRole
having sum(balls)>60
order by batting_average desc limit 10;

