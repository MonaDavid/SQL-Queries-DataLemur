Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each users first post of the year and last post of the year in the year 2021. Output the user and number of the days between each users first and last post.


posts Table:
Column Name	Type
user_id	integer
post_id	integer
post_content	text
post_date	timestamp
posts Example Input:
user_id	post_id	post_content	post_date
151652	599415	Need a hug	07/10/2021 12:00:00
661093	624356	Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. Another day that's gonna fly by. I miss my girlfriend	07/29/2021 13:00:00
004239	784254	Happy 4th of July!	07/04/2021 11:00:00
661093	442560	Just going to cry myself to sleep after watching Marley and Me.	07/08/2021 14:00:00
151652	111766	I'm so done with covid - need travelling ASAP!	07/12/2021 19:00:00
Example Output:
user_id	days_between
151652	2
661093	21

Solution:  
with recent_posts as 
(
Select DISTINCT User_id , max(post_date) as Recent_date
from posts
where post_date >= '1/1/2021' and post_date <= '12/31/2021'
group by user_id
)
, old_posts as 
(
SELECT distinct user_id , min(post_date) as oldest_date
from posts
where post_date >= '1/1/2021' and post_date <= '12/31/2021'
group by user_id
)

select rp.User_id, rp.Recent_date::date - op.oldest_date::date as days_between 
From recent_posts rp 
inner join old_posts op 
on rp.user_id = op.user_id
where rp.Recent_date::date - op.oldest_date::date > 0
