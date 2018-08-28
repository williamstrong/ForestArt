FROM archlinux/base:latest

RUN pacman -Syu --noconfirm
RUN pacman -S certbot-nginx --noconfirm

#RUN mkdir /etc/letsencrypt
RUN mkdir /data
RUN mkdir /data/letsencrypt
ADD ./certs/etc/letsencrypt /etc/letsencrypt
ADD ./certs/data/letsencrypt /data/letsencrypt

