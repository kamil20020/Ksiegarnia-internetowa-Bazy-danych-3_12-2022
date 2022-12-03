# Wdrożenie

Tworzenie obrazu o nazwie backend-1: 
```
docker build . -t backend-1
```

Powiąznaie utworzonego obrazz z nazwą, jaką będzie miał ten obraz w rejestrze kontenerów od azure: 
```
docker tag backend-1 inzynierkakeycloak.azurecr.io/backend-1-api:latest
```

Wrzucanie utworzonego obrazu do rejestru kontenerów na azure: 
```
docker push inzynierkakeycloak.azurecr.io/backend-1-api:latest 
```