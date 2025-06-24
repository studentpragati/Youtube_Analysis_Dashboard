#1. Top 10 Most Viewed YouTubers
SELECT country, youtuber, video_views 
FROM db.youtube 
ORDER BY video_views DESC 
LIMIT 10;

#2. Most Profitable YouTuber per Country
WITH cte AS (
  SELECT youtuber, country, highest_yearly_earnings,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY highest_yearly_earnings DESC) AS rn
  FROM db.youtube
)
SELECT youtuber, country, highest_yearly_earnings 
FROM cte 
WHERE rn = 1;

#3. Categories with the Highest Average Subscribers
SELECT category, ROUND(AVG(subscribers), 2) AS highest_sub 
FROM db.youtube 
GROUP BY category 
ORDER BY highest_sub DESC;

#4. Countries with the Most YouTubers
SELECT country, COUNT(*) AS most_youtubers 
FROM db.youtube 
GROUP BY country 
ORDER BY most_youtubers DESC 
LIMIT 10;


#5. Subscriber Growth by Month (Seasonality)
SELECT created_month,
       ROUND(AVG(subscribers_for_last_30_days), 2) AS avg_monthly_sub_growth,
       ROUND(AVG(video_views_for_the_last_30_days), 2) AS avg_monthly_views
FROM db.youtube
GROUP BY created_month
ORDER BY avg_monthly_sub_growth DESC;

#Which Channel Type Earns the Most on Average?
SELECT channel_type, 
       ROUND(AVG(highest_monthly_earnings), 2) AS avg_earnings 
FROM db.youtube 
GROUP BY channel_type 
ORDER BY avg_earnings DESC;


#KPI's
#Total Channels Analyzed
SELECT COUNT(*) FROM db.youtube;

#Total Video Views
SELECT SUM(video_views) FROM db.youtube;

#Avg Subscriber Growth (Last 30 Days)
SELECT ROUND(AVG(subscribers_for_last_30_days),2) FROM db.youtube;


#Avg earning per view
SELECT 
  ROUND(AVG(highest_yearly_earnings / NULLIF(video_views, 0)), 6) AS avg_earnings_per_view
FROM db.youtube;


