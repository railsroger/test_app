# README

## Установка

- install rbenv
- `cd hisense`
- `rbenv install`
- `gem install bundler`
- `bundle`
- `bundle exec rake railties:install:migrations`
- `bundle exec rake db:create`
- `bundle exec rake db:migrate`
- `bundle exec rake db:seed`
- `bundle exec rake db:sync`

### Настройка Spree 
Rake задача `db:sync` настраивает пользователей, настройки, свойства и тд.
и создаёт демо контент.
Нужно запускать после каждого обновления файла `lib/tasks/db.rake`

