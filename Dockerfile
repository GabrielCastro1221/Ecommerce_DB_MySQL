FROM mysql:8.0

LABEL maintainer="Gabriel Castro Ramírez <gbrlcstr@hotmail.com>"
LABEL version="1.0"
LABEL description="Imagen de MySQL 100% funcional para una plataforma eCommerce. Incluye el esquema completo de la base de datos, funciones, procedimientos almacenados, triggers y vistas necesarios para su operación."
LABEL org.opencontainers.image.source="https://github.com/GabrielCastro1221"

WORKDIR /app
COPY . .

ENV MYSQL_ROOT_PASSWORD=""
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true
ENV MYSQL_DATABASE=petshop

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

CMD ["mysqld"]
