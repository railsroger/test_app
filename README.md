# README
[![CircleCI](https://circleci.com/gh/m2hagency/hisense/tree/develop.svg?style=svg&circle-token=2d94292709f6cdb644704beb01793e85b886919e)](https://circleci.com/gh/m2hagency/hisense/tree/develop)

## Установка

- `git clone git@github.com:m2hagency/hisense.git`
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

### Конвертация видео

#### Установка на Mac
 
`brew install ffmpeg --with-fdk-aac --with-ffplay --with-freetype --with-frei0r --with-libass --with-libvo-aacenc --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-tools`

Если `ffmpeg` уже установлен, использовать `reinstall`.

#### Установка на Ubuntu

```
wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-64bit-static.tar.xz
tar xvf ffmpeg-git-*.tar.xz
cd ./ffmpeg-git-*
sudo cp ff* qt-faststart /usr/local/bin/
```
