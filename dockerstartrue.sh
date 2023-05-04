# Habilitar o docker na reinicialização do sistema operacional
# inicializar todos os container docker na inicialização do sistema 

DOCKER_START_SYSTEMCTL(){
systemctl enable docker
reboot
}

DOCKER_START_SYSTEMCTL