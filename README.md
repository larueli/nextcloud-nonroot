# nextcloud-nonroot

## Beautiful URL

1. Edit your config file in your container `nano /var/www/html/config/config.php` then add `'htaccess.RewriteBase' => '/',`

2. Create init script : you can can create a folder `mkdir scripts` and in it add the following file `nano scripts/htaccess-script.sh` :

```bash
#!/bin/bash
cd /var/www/html && php occ maintenance:update:htaccess
```

3. Mount it inside the container initscripts folder : in your docker compose, in the section volumes

```yml
- ./scripts:/docker-entrypoint-init.d
```

4. Don't forget to set correct permissions on the config folder `chown -R 1420 config`

5. Restart : `docker-compose up -d`
