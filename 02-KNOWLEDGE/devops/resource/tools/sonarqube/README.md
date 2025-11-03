# 트러블 슈팅

- 에러 메시지
```
java.nio.file.AccessDeniedException: /opt/sonarqube/data/es7
...
Unable to access 'path.data' (/opt/sonarqube/data/es7)
...
Process exited with exit value [ElasticSearch]: 1
```

- 호스트 볼륨 권한 확인 및 변경
```
sudo chown -R 1000:1000 ./sonarqube_data ./sonarqube_extensions
sudo chmod -R 755 ./sonarqube_data ./sonarqube_extensions

```