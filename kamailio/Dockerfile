# Usa una imagen base ligera como Debian
FROM debian:bullseye

# Variables de entorno para configuraciones predeterminadas
ENV DEBIAN_FRONTEND=noninteractive
ENV KAMAILIO_VERSION=5.5

# Actualiza el sistema e instala dependencias esenciales
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    make \
    build-essential \
    flex \
    bison \
    libmariadb-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libpcre3-dev \
    libunistring-dev \
    libjson-c-dev \
    libpq-dev \
    libsystemd-dev \
    libcap-dev \
    liblua5.3-dev \
    libgeoip-dev \
    libjansson-dev \
    curl \
    wget \
    pkg-config \
    libev-dev \
    libperl-dev \
    libgdbm-dev \
    zlib1g-dev \
    libyaml-dev \
    libsqlite3-dev \
    python3 \
    python3-pip \
    libpython3-dev \
    && apt-get clean

# Clonar el repositorio de Kamailio
RUN git clone --depth 1 -b $KAMAILIO_VERSION https://github.com/kamailio/kamailio.git /usr/src/kamailio

# Compilar e instalar Kamailio
WORKDIR /usr/src/kamailio
RUN make cfg

COPY modules.lst /usr/src/kamailio/src/
RUN make all && \
    make install

# Instalr modulos de kamaillio
WORKDIR /usr/src/kamailio
RUN make modules && \
    make install-modules

# Crear usuario y directorios necesarios para Kamailio
RUN groupadd -r kamailio && useradd -r -g kamailio kamailio && \
    mkdir -p /var/run/kamailio && \
    chown kamailio:kamailio /var/run/kamailio

# Copiar el archivo de configuración predeterminado
COPY kamailio.cfg.demo /etc/kamailio/kamailio.cfg

# Exponer el puerto SIP (5060)
EXPOSE 5060/udp
EXPOSE 5060/tcp

# Establecer el comando de inicio predeterminado
CMD ["kamailio", "-DD", "-E", "-f", "/etc/kamailio/kamailio.cfg"]

