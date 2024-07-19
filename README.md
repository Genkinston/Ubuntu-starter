# Ubuntu-starter

Маленький проект по настройки Ubuntu 24.04 после установки одним скриптом.

Прежде чем клонировать проект нужно установить git.

```bash
sudo apt install git
```

Начало работы

```bash
bash ./start
```

Альтернативно можно использовать ansible.
Но сперва нужно включить ssh на свежей системе.

```bash
sudo apt install ssh -y
sudo systemctl enable ssh.service
```

Далее заполнить переменные в `/group_vars/main`
И указать хосты в `inventory.ini`

Использовать

```bash
ansible-playbook starter.yml 
```
