select * from hero_battles;
select * from heroes_information;
select * from super_hero_powers;


#1)	List the battle details where the number of enemies fought was 1, or 2, or 10, or 12.
select * from hero_battles where num_enemies in(1,2,10,12);


#	What is the total no. of enemies and average number of enemies for each super hero? Also analyse which super hero have highest no of average enemies.
select name_super_hero, sum(num_enemies), avg(num_enemies) from hero_battles group by name_super_hero;
select name_super_hero, avg(num_enemies) from hero_battles group by name_super_hero order by avg(num_enemies) desc limit 1;

#)Select all the hero races with an average weight of over 150 and an average height of over 100. 
select name_hero, avg(weight), avg(height) from heroes_information group by name_hero;


#List all female heroes_information and stack that name on top of all the heroes who have accelerated healing from the super_hero_powers table. 
#Return only the name columns.

SELECT 
    name_hero, gender, Accelerated_Healing
FROM
    heroes_information hi
        LEFT JOIN
    super_hero_powers spow ON hi.name_hero = spow.hero_names
WHERE
    gender = 'Female'
        AND Accelerated_Healing = 'false';
        
# For each hero who fought in hero_battles along with battle details, list their information (from heroes_information)
select * from heroes_information hi left join hero_battles bat on hi.name_hero = bat.name_super_hero;

#Provide a list of the heaviest super heroes, with the heaviest being ranked #1
select name_hero,Weight, dense_rank() over(order by weight desc) from heroes_information;

#Give a frequency table with each letter of the alphabet and how many superheroes’ names start with that letter. 
SELECT 
    UPPER(LEFT(name_hero, 1)) AS first_char,
    COUNT(*) AS count_superhero
FROM
    heroes_information
GROUP BY UPPER(LEFT(name_hero, 1))
ORDER BY first_char ASC;



#create a temporary table for the below result called bigs
#a)Display heroes_information whose Race has an average weight of over 400.
#b)Select all columns and rows from that temporary table.

create temporary table big (select * from heroes_information);
select * from big where weight > 400;

#Creates a view to selects data if the publisher is Marvel Comics and if their height is above the average height.
select avg(height) from heroes_information where Publisher = 'Marvel Comics';
create view Marvel_Comic as select * from heroes_information where Publisher = 'Marvel Comics' and height > 142.75;	

#Create List Female Gender , Marvel Comics Publisher Good Alignment details from heroes _information
SELECT 
    *
FROM
    heroes_information
WHERE
    gender = 'Female'
        AND Publisher = 'Marvel Comics'
        AND Alignment = 'Good';
