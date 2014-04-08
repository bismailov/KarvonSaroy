upstream elif_server {
  server unix:/data/elif/shared/unicorn.sock fail_timeout=0; # Местоположение сокета должно совпадать с настройками файла config/unicorn.rb от корня вашего $
}

server {
  listen 80;
  server_name elif.uz www.elif.uz;

  client_max_body_size       70M;
  root /data/elif/current/public;
  access_log /data/elif/shared/log/access.log;
  error_log  /data/elif/shared/log/error.log;
  try_files $uri/index.html $uri.html $uri @elif; # Имя переменной не важно - главное, чтобы в блоке location ниже было аналогичное

  location  @elif  {
      proxy_pass http://elif_server; # Часть после http:// должна полностью соответствовать имени в блоке upstream выше.
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_redirect off;
      proxy_read_timeout          500;


      client_max_body_size       7M;
      root /data/elif/current/public;

      gzip on;
      gzip_min_length  1024;
      gzip_comp_level 8;
      gzip_http_version 1.0;
      gzip_buffers 16 8k;
      gzip_proxied any;
      gzip_disable        "MSIE [1-6]\.";
      gzip_types      text/plain text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript text/json;
      gzip_vary on;


  }

  location ~ ^/assets/ {
      add_header Last-Modified "";
      add_header ETag "";
      gzip_static on;
      expires max;
      add_header Cache-Control public;
  }

}