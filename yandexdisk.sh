#!/bin/bash
set -e
davfs2_secret="/etc/davfs2/secrets"
davfs2_secret_add_string="/media/yandexdisk $yandexid $yandexpass"

#Установка необходимого пакета для работы облака как сетевого диска
sudo apt-get install davfs2 -y
#Добавит текущего юзера в группу доступа к сервису сетевого диска
sudo usermod -a -G davfs2 "$USER"
#Создаст папку куда будет монтироваться сетевой диск
if [ -d /media/yandexdisk ]; then
    echo "folder already created"
else
    sudo mkdir /media/yandexdisk
fi
#Установит права владения на неё текущим пользователем
sudo chown -R "$USER":"$USER" /media/yandexdisk/

#Вводим логин и пароль для Yandex disk для записи в fstab
echo
echo -e "Write login and password to save them in fstab for automount disk"
read -r -p $'\n'"yandex id login: " yandexid
read -r -p $'\n'"yandex app pass: " yandexpass

#Добавить логин и пароль в папку секретов для работы davfs2
if [ -f $davfs2_secret ]; then
  grep -q "$davfs2_secret_add_string" $davfs2_secret || echo "$davfs2_secret_add_string" >> $davfs2_secret
else
 echo "File $davfs2_secret not created"
fi

#Записываем данные в fstab для автомонтирования сетевого диска
sudo echo "https://webdav.yandex.ru /media/yandexdisk davfs gid=$USER,uid=$USER,auto 0 0" | sudo tee -a /etc/fstab
#Монтируем диск в текущий сеанс
sudo mount -a

echo -e "\n====================\nDONE\n====================\n"

exit
