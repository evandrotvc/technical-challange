# DocSales tech test

## Instalando projeto

É necessário ter Docker e docker-compose. A aplicação roda o banco e o server tudo em docker.

Para instalar o projeto, siga estas etapas:

Setando o .env
```
copie o arquivo .env.test com o nome .env
```
depois rode
```
docker compose build
```

depois rode
```
docker compose up
```

Se tudo foi instalado com sucesso, estará rodando os containers postgres(port: 5432) e o server(port: 3000), redis.
Agora é possível realizar os testes se todos os containers executaram corretamente

## Tests

No terminal, caso queira rodar os testes, basta entrar no container e rodar o comando a seguir.
```
docker exec -it app bash
```
e depois:
```
rspec
```



## Examples
- POST create
![alt text](https://github.com/evandrotvc/technical-challange/blob/main/app/assets/images/create.png)

- GET list
![alt text](https://github.com/evandrotvc/technical-challange/blob/main/app/assets/images/list.png)

- PUT update
![alt text](https://github.com/evandrotvc/technical-challange/blob/main/app/assets/images/update.png)

- pdf generated
![alt text](https://github.com/evandrotvc/technical-challange/blob/main/app/assets/images/pdf.png)
