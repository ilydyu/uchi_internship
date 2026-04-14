# Примечание

Для простоты опущены детали, некоторые из них: все коммиты в мастере, нет пагинации, соль задаётся через переменные окружения при старте docker compose, приложение запускается в development режиме.
Сериалайзеры лежат в папке `blueprints`, сервисные объекты (один) в `services`.
Использовались дополнительные гемы, для сериализации `blueprinter`, для тестов `rswag`, `rspec`, `faker`, `factory-bot`.

# Как запустить

```
SALT=qwe docker compose up --build
```
```
docker exec -it uchi_internship-web-1 bundle exec rails db:create && 
docker exec -it uchi_internship-web-1 bundle exec rails db:migrate && 
docker exec -it uchi_internship-web-1 bundle exec rails db:seed
```

# Как посмотреть API

По адресу [localhost:3000/api-docs](localhost:3000/api-docs). Там же можно подёргать эндпойнты.
