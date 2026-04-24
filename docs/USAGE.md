# Guia de uso — vagrant-libvirt-lab

## 1. Pré-requisitos do host

- libvirt e qemu-kvm instalados e em execução
- Usuário nos grupos `libvirt` e `kvm`
- Vagrant >= 2.4 instalado
- Plugin vagrant-libvirt instalado:

```bash
vagrant plugin install vagrant-libvirt
```

## 2. Subindo a VM

```bash
vagrant up
vagrant ssh
```

## 3. Descobrindo o IP da VM

O qemu-guest-agent precisa estar em execução dentro da VM (instalado automaticamente pelo `setup.sh`).

```bash
virsh domifaddr lab
```

Alternativa caso o guest-agent ainda não esteja pronto:

```bash
nmap -sn <range_da_bridge>
# exemplo: nmap -sn 192.168.121.0/24
```

## 4. Destruindo a VM

```bash
vagrant destroy -f
```

## 5. Troubleshooting

**Plugin não encontrado ao executar `vagrant up`**
Instale o plugin antes de subir a VM:
```bash
vagrant plugin install vagrant-libvirt
```

**`virsh domifaddr lab` não retorna o IP**
O qemu-guest-agent pode levar até 30 segundos para iniciar após o boot.
Aguarde e tente novamente, ou use `nmap` como alternativa.
