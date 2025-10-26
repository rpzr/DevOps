FROM nginx:1.19.7
WORKDIR /home
RUN groupadd -r newuser && useradd -r -g newuser newuser && chown newuser:newuser /home && \
    chown -R newuser:newuser /var/cache/nginx && \
    touch /var/run/nginx.pid && \
    chown -R newuser:newuser /var/run/nginx.pid && \
    chmod -R 777 /var/cache/nginx && \
    apt update && apt install -y libfcgi-dev spawn-fcgi gcc && \
    rm -rf /var/lib/apt/lists/*
COPY ./server/server.c .
COPY ./server/nginx/nginx.conf /etc/nginx/
USER newuser
RUN gcc ./server.c -o server -lfcgi
CMD ["sh", "-c", "spawn-fcgi -p 8080 ./server && nginx -g 'daemon off;' && nginx -s reload"]
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost/ || exit 1