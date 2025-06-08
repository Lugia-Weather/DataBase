
FROM gvenzl/oracle-xe:21.3.0

ENV ORACLE_PASSWORD=Fiap123456

COPY CriarUsuario.sql /docker-entrypoint-initdb.d/