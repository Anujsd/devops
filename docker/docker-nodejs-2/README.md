# Commands

If you have node modules locally use this

```
docker run -it -p 4000:8081 -v %cd%:/app/ node-asd
```

---

If you dont have then we will use node_modules created by dockerfile

Anonymous volumes are overriding node_modules from local folder that's why it's working.
named volumes will also work here.

```
docker run -it -p 4000:8081 -v %cd%:/app/ -v /app/node_modules  node-asd
```
