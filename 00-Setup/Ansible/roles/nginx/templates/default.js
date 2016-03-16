upstream jenkins {
    server {{ ansible_eth0["ipv4"]["address"] }}:8080;
}

upstream gitlab {
    server {{ ansible_eth0["ipv4"]["address"] }}:10080;
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
