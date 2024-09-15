#atualizar distro
#sudo apt update && sudo apt dist-upgrade -Y

#sudo dpkg-reconfigure tzdata
#sudo reboot


#instalação php mysql e apache
sudo apt install apache2 mariadb-server mariadb-client libapache2-mod-php php php-dom php-json php-simplexml php-xmlreader php-xmlwriter php-curl php-gd php-intl php-mysqli php-bz2 php-zip php-exif php-ldap php-opcache php-mbstring


#talvez aqui dê merda / criação de BD do glpi
sudo mysql -e "CREATE DATABASE glpi" 
sudo mysql -e "GRANT ALL PRIVILEGES ON glpi.* TO 'glpi'@'localhost' IDENTIFIED BY 'S3cRj@01'" 
sudo mysql -e "GRANT SELECT ON mysql.time_zone_name TO 'glpi'@'localhost'" 
sudo mysql -e "FLUSH PRIVILEGES"


#carregar timezone no BD
mysql_tzinfo_to_sql /usr/share/zoneinfo | sudo mysql -u root mysql


#desabilitar site padrao do apache2
sudo a2dissite 000-default.conf


#habilitar cookies na sessão se atentar na versão do php, verifica os diretorios meu mano
sudo sed -i 's/^session.cookie_httponly =/session.cookie_httponly = on/' /etc/php/8.3/apache2/php.ini && \
	   sudo sed -i 's/^;date.timezone =/date.timezone= America\/Sao_Paulo/' /etc/php/8.3/apache2/php.ini


#criação do virtualhost para o glpi
cat << EOF | sudo tee /etc/apache2/sites-available/glpi.conf
<VirtualHost *:80>
ServerName glpi.secectest.com.br
#ServerName localhost
DocumentRoot /var/www/glpi/public
<Directory /var/www/glpi/public>
Require all granted
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ index.php [QSA,L]
</Directory>
</VirtualHost>
EOF


#habilitar o virtualhost
sudo a2ensite glpi.conf


#habilitar modulos do apache
sudo a2enmod rewrite
sudo systemctl restart apache2


#download do glpi. sempre verificar atualizações tambem
#wget -q https://github.com/glpi-project/glpi/releases/download/10.0.7/glpi-10.0.7.tgz
wget -q https://github.com/glpi-project/glpi/releases/download/10.0.16/glpi-10.0.16.tgz
tar -zxf glpi-*
sudo mv glpi /var/www/glpi

#configurar permissões da pasta
sudo chown -R www-data:www-data /var/www/glpi

#finalizar setup do GLPI
sudo php /var/www/glpi/bin/console db:install --default-language=pt_BR --db-host=localhost --db-port=3306 --db-name=glpi --db-user=glpi --db-password=S3cRj@01 -n -vvv


#remover arquivo de instalação
sudo rm /var/www/glpi/install/install.php


#movendo as pastas do GLPI para local apropriado
sudo mv /var/www/glpi/files /var/lib/glpi
sudo mv /var/www/glpi/config /etc/glpi
sudo mkdir /var/log/glpi && sudo chown -R www-data:www-data /var/log/glpi


#conf-dir
cat << EOF | sudo tee /var/www/glpi/inc/downstream.php
<?php
define('GLPI_CONFIG_DIR', '/etc/glpi/');
if(file_exists(GLPI_CONFIG_DIR . '/local_define.php')) {
require_once GLPI_CONFIG_DIR . '/local_define.php';
}
EOF

#data-dir
cat << EOF | sudo tee /etc/glpi/local_define.php
<?php
define('GLPI_VAR_DIR', '/var/lib/glpi');
define('GLPI_LOG_DIR', '/var/log/glpi');
EOF


#sudo dpkg-reconfigure tzdata
sudo reboot