Assume youre given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.

Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.

Effective 15 April 2023, the solution has been updated with a more concise and easy-to-understand approach.

viewership Table
Column Name	Type
user_id	integer
device_type	string ('laptop', 'tablet', 'phone')
view_time	timestamp
viewership Example Input
user_id	device_type	view_time
123	tablet	01/02/2022 00:00:00
125	laptop	01/07/2022 00:00:00
128	laptop	02/09/2022 00:00:00
129	phone	02/09/2022 00:00:00
145	tablet	02/24/2022 00:00:00
Example Output
laptop_views	mobile_views
2	3

Solution :

With views AS
(SELECT device_type, count(user_id)
from viewership
group by device_type),

laptop_views AS
(SELECT sum(count) as laptop_views
from views
where device_type = 'laptop'),

mobile_views AS
(SELECT sum(count) as mobile_views
from views
where device_type in( 'phone','tablet'))

select laptop_views , mobile_views
from laptop_views cross join mobile_views
