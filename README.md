# Wdrożenie

Tworzenie obrazu o nazwie backend-2: 
```
docker build . -t backend-2
```

Powiąznaie utworzonego obrazz z nazwą, jaką będzie miał ten obraz w rejestrze kontenerów od azure: 
```
docker tag backend-2 inzynierkakeycloak.azurecr.io/booksshop-dr:latest
```

Wrzucanie utworzonego obrazu do rejestru kontenerów na azure: 
```
docker push inzynierkakeycloak.azurecr.io/booksshop-dr:latest 
```
