/* Task 1 - question 1 */
SELECT COUNT(DISTINCT utm_campaign) AS 'Number of Campaigns'
FROM page_visits;

/* Task 1 - question 2 */
SELECT COUNT(DISTINCT utm_source) AS 'Number of Sources'
FROM page_visits;

/* Task 1 - question 3 */
SELECT DISTINCT utm_campaign AS 'Campaign',         
    utm_source AS 'Source'
FROM page_visits;

/* Task 2 - question 4 */
SELECT DISTINCT page_name AS 'Page Name'
FROM page_visits;

/* Task 3 - question 5 */
WITH first_touch AS (
    SELECT user_id,
           MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_source AS 'Source',
       pv.utm_campaign AS 'Campaign',
       COUNT(pv.utm_campaign) AS 'First Touches'
FROM first_touch ft
JOIN page_visits pv
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 3 DESC;

/* Task 4 - question 6 */
WITH last_touch AS (
    SELECT user_id,
           MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_source AS 'Source',
       pv.utm_campaign AS 'Campaign',
       COUNT(pv.utm_campaign) AS 'Last Touches'
FROM last_touch lt
JOIN page_visits pv
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 3 DESC;

/* Task 5 - question 7 */
SELECT COUNT(DISTINCT user_id) AS 'Users Who Converted'
FROM page_visits
WHERE page_name = '4 - purchase';

/* Task 6 - question 8 */
WITH last_touch AS (
    SELECT user_id,
           MAX(timestamp) as last_touch_at
    FROM page_visits
  	WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT pv.utm_source AS 'Source',
       pv.utm_campaign AS 'Campaign',
       COUNT(pv.utm_campaign) AS 'Conversions'
FROM last_touch lt
JOIN page_visits pv
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 3 DESC;