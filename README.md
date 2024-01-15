## docker-cntlm
Docker image with cntlm service support

### Build image
```
$ ./build.sh
```
You will asked for username, domain, password, proxy and additional no_proxy values. Password is not stored, only needed for PassNTLMv2 generation. Once executed you will have the image **cntlm:v1.x** in your docker images
#### Or buid without script
```
docker compose build \
    --build-arg USERNAME="username" \
    --build-arg DOMAIN="domain" \
    --build-arg PASSWORD="password" \
    --build-arg PROXY="proxy";
    --build-arg NOPROXY="additional_noproxy"
```
### Run
```
$ docker compose up -d
```

### View logs
```
$ docker compose logs
```
