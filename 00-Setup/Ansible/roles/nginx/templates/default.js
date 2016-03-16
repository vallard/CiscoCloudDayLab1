upstream jenkins {
    server 10.100.0.38:8080;
}

upstream gitlab {
    server 10.100.0.38:10080;
}

upstream gospark {
    server 10.100.0.38:8089;
}


server {
    listen       80;
    server_name  jenkins.metapals.com;
    location / {
        proxy_pass http://jenkins;
    }
}

server {
    listen       80;
    server_name  gitlab.metapals.com;
    location / {
        proxy_pass http://gitlab;
    }
}

server {
    listen       80;
    server_name  gospark.metapals.com;
    location / {
        proxy_pass http://gospark;
    }
}
