#!/bin/sh

if [ ! -f "/etc/redis/redis.conf.bak" ]; then

    # redis.conf dosyasının yedeğini al
    cp /etc//redis/redis.conf /etc/redis/redis.conf.bak

    # Bu satırları değiştir
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf
    sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

fi

# Redisi harici bağlantılara izin vererek çalıştırır
redis-server --protected-mode no
