# How To Run My Project
* Running MyApp : docker-composer up -d
* After running all container, please run command for resolved 502 Bad Gateway:
  docker exec -it laravel_app bash
  chown -R www-data:www-data /var/www/html
  chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

