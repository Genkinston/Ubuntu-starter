#!/bin/bash
set -e
davfs2_secret="/etc/davfs2/secrets"
davfs2_secret_add_string="/media/yandexdisk $yandexid $yandexpass"

#Установка необходимого пакета для работы облака как сетевого диска
sudo apt-get install davfs2 -y
#Добавит текущего юзера в группу доступа к сервису сетевого диска
sudo usermod -a -G davfs2 "$USER"
#Создаст папку куда будет монтироваться сетевой диск
sudo mkdir /media/yandexdisk
#Установит права владения на неё текущим пользователем
sudo chown -R "$USER":"$USER" /media/yandexdisk/
#Вводим логин и пароль для Yandex disk для записи в fstab
echo -e "Write login and password to save them in fstab for automount disk"
read -r -p $'\n'"yandex id login: " yandexid
read -r -p $'\n'"yandex app pass: " yandexpass
#Добавить логин и пароль в папку секретов для работы davfs2
while IFS= read -r line; do
 if [[ "$line" == *"$davfs2_secret_add_string"* ]]; then
 echo "Строка найдена в файле."
 break
 else
 echo "Строка не найдена в файле."
 echo "$davfs2_secret_add_string" | sudo tee -a $davfs2_secret
 fi
done < "$davfs2_secret"

#Записываем данные в fstab для автомонтирования сетевого диска
echo "https://webdav.yandex.ru /media/yandexdisk davfs gid=$USER,uid=$USER,auto 0 0" | sudo tee -a /etc/fstab
#Монтируем диск в текущий сеанс
sudo mount -a

echo -e "\n====================\nDONE\n====================\n"

exit
