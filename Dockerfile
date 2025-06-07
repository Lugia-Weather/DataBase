# Usa a imagem base pública do Oracle XE 11g
FROM oracleinanutshell/oracle-xe-11g

# Cria um usuário não-root
RUN useradd -m dbuser

# Define o diretório de trabalho
WORKDIR /home/dbuser

# Usa o usuário não-root
USER dbuser

# Variável de ambiente obrigatória
ENV ORACLE_PASSWORD=oracle123

# Expõe a porta padrão do Oracle XE
EXPOSE 1521
