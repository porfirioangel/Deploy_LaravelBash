# Deploy Laravel Bash

Este proyecto contiene los scripts para realizar un deploy automático de Laravel
en un servidor de pruebas.

## Configurar acceso por ssh al servidor:

### Acciones en el equipo remoto:

**Instalar servidor ssh:**
```
sudo apt-get update
sudo apt-get install openssh-server
```

**Iniciar, detener, reiniciar servicio ssh:**
```
sudo service ssh start
sudo service ssh stop
sudo service ssh restart
```

**Crear directorio para almacenar llaves ssh:**
```
mkdir ~/.ssh
```

**Verificar configuración del servidor ssh:**
```
sudo vim /etc/ssh/sshd_config

# Estas entradas deben ser 'yes'
RSAAuthentication yes
PubkeyAuthentication yes

# Estas entradas deben ser 'no'
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
```

**Reiniciar servidor ssh:**
```
sudo service ssh restart
```

**Crear directorio para el proyecto:**
```
mkdir /var/www/html/ZacatecasUp
```

**Establecer el usuario y grupo propietarios de la carpeta del proyecto:**
```
chown -R www-data:www-data ZacatecasUp
```

**Agregar usuario al grupo www-data:**
```
usermod -a -G www-data ingsoftware
```

**Dar permisos al grupo a la carpeta del proyecto:**
```
chmod -R g+wrx /var/www/html/ZacatecasUp
```

**Permitir login con el usuario www-data:**
```
sudo vim /etc/passwd

# Comentar la línea que evita el login
# www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin

# Agregar la línea que permite el login
www-data:x:33:33:www-data:/var/www:/bin/bash
```

**Generar llaves ssh para el usuario www-data:**
```
ssh-keygen -t rsa
```

**Agregar llave pública al repositorio remoto de git:**
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCW/1Etr1Ho3xsPeHofc9rejjHkOC/BAbbUqfiRbqvRzu/5a/bPkgJ8pxt0GsuKza81MDOFLsvvi0WoWjYQ7y0wmOo8B8wa1IvN2/DCs+SpGUFaMrATxekChL6BhmraTSL/WVPMiuy59/AqCHUCakqrasdjoL4QwNEj1nZxZk0fPvN00XHg1tyVX+Koxd5RpXY/3UldicDXVAIq/71p+iTXW5r57B2GxCDWZwS5dea9bemnbtBWRIt4E/Zi9JcMZUfggtrNql0bJykaJtWIspjDsx9VBuZ7mIHV6fQf+O/6zB6LVx3i22959Uqj0brznHXjuNXFlViFLTa287Scg3N www-data@ingsoftwares1
```

**Agregar gitlab.com a los known hosts:**
```
ssh -T git@gitlab.com
```

**Instalar composer:**
```
sudo apt-get install curl php5-cli

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

# copiar la installer signature de https://composer.github.io/pubkeys.html

php -r "if (hash_file('SHA384', 'composer-setup.php') === 'llave_copiada') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

php -r "unlink('composer-setup.php');"
```

### Acciones en el equipo local:

**Generar llaves ssh:**
```
ssh-keygen -t rsa
```

**Copiar llave pública al servidor:**
```
scp ~/.ssh/id_rsa.pub ingsoftware@148.217.200.108:~/.ssh/uploaded_key.pub
```

**Agregar llave pública a las authorized_keys del servidor:**
```
ssh ingsoftware@148.217.200.108 "cat ~/.ssh/uploaded_key.pub >> ~/.ssh/authorized_keys"
```


**Copiar scripts al servidor remoto:**
```
scp laravel_hook.php ingsoftware@148.217.200.108:/var/www/html/ZacatecasUp/laravel_hook.php
scp laravel_deploy.sh ingsoftware@148.217.200.108:~/scripts/laravel_deploy.sh
```