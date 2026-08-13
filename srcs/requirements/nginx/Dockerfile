FROM alpine:3.23

RUN apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/nginx/ssl/nginx.key \
-out /etc/nginx/ssl/nginx.crt \
-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=Inception/CN=portedesaintcloud.duckdns.org"

COPY conf/default.conf /etc/nginx/http.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

#req = commande pour generer une demande de signature du certif
#-x509 indique qu'on veut auto-signe
#-nodes = cle privee non chiffree par un mot de passe
#-days 365 = duree de validite
#-newkey rsa = creer un cle RSA de 2048 bits en meme temps que le certificat
# -KEYOUT = chemin pour stocker la cle pv
# -out = chemin pour stocker le certificat
# -subj = remplis les champs du certif
# (C = pays/ ST = etat/ L = ville/ O = organisation/ OU = unite organisationnelle/ CN = nom)
