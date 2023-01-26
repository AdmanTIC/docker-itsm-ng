#!/bin/bash
set -exuo pipefail

export DBPASSWORD=$(php -r 'print(urlencode(trim(fgets(STDIN))));' <<<$DBPASSWORD)
envsubst '$DBHOST $DBUSER $DBPASSWORD $DBDATABASE' < /var/www/html/config/config_db.php.tpl > /var/www/html/config/config_db.php

if ! ls -1 /var/www/html/files | grep -v lost+found | grep -q . ; then
  rsync -ai /var/www/html/files.default/ /var/www/html/files/
fi
chown -R www-data: /var/www/html/files
chown -R www-data: /var/www/html/config

echo "Waiting for database to be up"
while ! mysql -u "$DBUSER" -h "$DBHOST" -p$DBPASSWORD "$DBDATABASE" -BNe "SHOW TABLES" ; do sleep 1 ; done

if ! mysql -u "$DBUSER" -h "$DBHOST" -p$DBPASSWORD "$DBDATABASE" -BNe "SHOW TABLES" | grep -q . ; then
  (
    set -e
    cd /var/www/html/install
    sed '/^return $tables;/d' -i /var/www/html/install/empty_data.php
    cat - >> /var/www/html/install/empty_data.php <<EOF
\$tables['glpi_users'] = [[
  'id'         => '2',
  'name'       => 'itsm',
  'password'   => '$(php -r "print(password_hash('$ITSM_ADMIN_PASSWORD',PASSWORD_BCRYPT));")',
    'language'   => null,
    'list_limit' => '20',
    'authtype'   => '1',
],];

return \$tables;
EOF
    php install_cli.php
  )
fi

exec docker-php-entrypoint apache2-foreground