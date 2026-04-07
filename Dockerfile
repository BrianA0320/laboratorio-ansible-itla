# Usa la última versión de Ubuntu
FROM ubuntu:latest

# Instalar SSH y sudo
RUN apt-get update && apt-get install -y openssh-server sudo

# Configurar el usuario 'ansible'
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:ansible" | chpasswd && \
    adduser ansible sudo

# Configurar sudo sin contraseña para el usuario ansible
RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Configurar el directorio de ejecución de SSH
RUN mkdir /var/run/sshd

# Exponer el puerto 22
EXPOSE 22

# Iniciar el servicio de SSH
CMD ["/usr/sbin/sshd", "-D"]