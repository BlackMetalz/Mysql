- Filter result while in Mysql CLI:
```
pager grep asdasd
```

while asdasd is keyword you need to find. For an example you need to find by mysql thread id which is 123456
```
pager grep 123456
show full processlist;
```

It will display only result that matched to thread id 123456
Whatever command you enter it still filter until you disable it with command below:
```
no pager
```
