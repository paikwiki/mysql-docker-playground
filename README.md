## MySQL 학습을 위한 환경 세팅

### 빌드 & 실행

```sh
$ docker build -t mysql-alpine .
$ docker run -d -p 3306:3306 --name mysql-container mysql-alpine
```

### 컨테이너 쉘 접속

```sh
docker exec -it mysql-container sh
```

### 환경 세팅 메모

MySQL 실행시 `--defaults-file` 옵션을 통해 설정 파일 경로를 명시적으로 지정

> 💡 명시적으로 지정하지 않을 경우 my.cnf 적용 순서
>
> 1. /etc/my.cnf
> 2. /etc/mysql/my.cnf
> 3. ~/.my.cnf
>
> [참고] 확인 버전: mysql  Ver 15.1 Distrib 10.11.8-MariaDB, for Linux (aarch64)

`3306` 포트가 아닌 `0` 포트로 지정되는 등, 환경설정이 제대로 반영되지 않는 경우
`--defaults-file` 옵션으로 설정 파일 경로를 명확히 지정해서 해결할 수 있다.


`/etc/my.cnf`의 기본 설정 내용

```sh
# 💾 /etc/my.cnf

# This group is read both both by the client and the server
# use it for options that affect everything
[client-server]

# This group is read by the server
[mysqld]

# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

# include all files from the config directory
!includedir /etc/my.cnf.d
```
