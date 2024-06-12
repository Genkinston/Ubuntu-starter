#!/bin/bash
set -e

#Установка необходимого пакета для работы облака как сетевого диска
apt-get install davfs2 -y
#Добавит текущего юзера в группу доступа к сервису сетевого диска
usermod -a -G davfs2 "$SUDO_USER"
#Создаст папку куда будет монтироваться сетевой диск
if [ -d /media/yandexdisk ]; then
    echo "folder already created"
else
    mkdir /media/yandexdisk
fi
#Установит права владения на неё текущим пользователем
chown -R "$SUDO_USER":"$SUDO_USER" /media/yandexdisk/

#Вводим логин и пароль для Yandex disk для записи в fstab

echo
echo -e "Write login and password to save them in fstab for automount disk"
read -r -p $'\n'"yandex id login: " yandexid
read -r -p $'\n'"yandex app pass: " yandexpass
davfs2_secret="/etc/davfs2/secrets"
davfs2_secret_add_string="/media/yandexdisk $yandexid $yandexpass"

#Добавить логин и пароль в папку секретов для работы davfs2
if [ -f $davfs2_secret ]; then
  grep -q "$davfs2_secret_add_string" $davfs2_secret || echo "$davfs2_secret_add_string" >> $davfs2_secret
else
 echo "File $davfs2_secret not created"
 exit 0
fi

#Записываем данные в fstab для автомонтирования сетевого диска
echo "https://webdav.yandex.ru /media/yandexdisk davfs gid=$SUDO_USER,uid=$SUDO_USER,auto 0 0" | tee -a /etc/fstab
#Монтируем диск в текущий сеанс
mount -a

echo -e "\n====================\nDONE\n====================\n"

exit 0
