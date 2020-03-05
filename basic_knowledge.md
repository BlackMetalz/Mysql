- Dump with Trigger, routines:
`
mysqldump --events --routines --triggers db_name > db_name.sql
`

- Check slow query / stored function ....
`
Check in mysql slow log
`
How to check slow query log: https://www.a2hosting.com/kb/developer-corner/mysql/enabling-the-slow-query-log-in-mysql


- Count table size in mysql:
```
SELECT TABLE_NAME, table_rows, data_length, index_length, 
round(((data_length + index_length) / 1024 / 1024),2) "Size in MB"
FROM information_schema.TABLES WHERE table_schema = "your_database"
ORDER BY (data_length + index_length) DESC;
```
