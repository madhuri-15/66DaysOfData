# Count the number of user events performed by MacBookPro users

#### Question

Count the number of user events performed by MacBookPro users.
Output the result along with the event name.
Sort the result based on the event count in the descending order.

`Company : Apple`

`Table: playbook_events`

**Data Structure**

```
user_id:            int
occurred_at:        datetime
event_type:         varchar
event_name:         varchar
location:           varchar
device:             varchar
```

**Approach**

First, Let's start by looking at the data from table. 

```
SELECT *
FROM playbook_events;
```

| user_id | occurred_at         | event_type  | event_name | location      | device              |
| ------- | ------------------- | ----------- | ---------- | ------------- | ------------------- |
| 6991    | 2014-06-09 18:26:54 | engagement  | home_page  | United States | iphone 5            |
| 18851   | 2014-08-29 13:18:38 | signup_flow | enter_info | Russia        | asus chromebook     |
| 14998   | 2014-07-01 12:47:56 | engagement  | login      | France        | hp pavilion desktop |

We need to find the count of events performed by Macbook Pro users.

- Let's filtered data by using `WHERE` cluase to find the users whose device is macbook pro.

```
SELECT *
FROM playbook_events
WHERE device='macbook pro';
```

| user_id | occurred_at         | event_type | event_name   | location  | device      |
| ------- | ------------------- | ---------- | ------------ | --------- | ----------- |
| 8186    | 2014-05-23 10:44:16 | engagement | home_page    | Italy     | macbook pro |
| 8708    | 2014-05-26 10:42:12 | engagement | send_message | Australia | macbook pro |
| 12725   | 2014-06-17 08:03:49 | engagement | home_page    | Brazil    | macbook pro |

- Now, we just need to group our data by `event_name` and compute their counts using `COUNT` aggregate function and `GROUP BY` clause.
- Then sort the result based on event counts in descending order using `ORDER BY` clause.

Final Solution

```
SELECT 
    event_name, 
    count(event_name) as event_count
FROM playbook_events
WHERE 
    device='macbook pro'
GROUP BY 
    event_name
ORDER BY 
    event_count DESC;
```

| event_name          | event_count |
| ------------------- | ----------- |
| home_page           | 8           |
| like_message        | 3           |
| login               | 3           |
| view_index          | 3           |
| search_autocomplete | 3           |
