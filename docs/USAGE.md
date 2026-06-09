# Guia de uso — vagrant-libvirt-lab

## 1. Pré-requisitos do host

- libvirt e qemu-kvm instalados e em execução
- Módulos KVM carregados (`kvm` + `kvm_intel` ou `kvm_amd` conforme a CPU) — ver troubleshooting se `/dev/kvm` não existir
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

**`[fog][WARNING] Unrecognized arguments: libvirt_ip_command` em todo comando vagrant**
Incompatibilidade de versão entre `vagrant-libvirt` 0.12.2 e `fog-core`. O aviso é benigno e pode ser ignorado — não afeta a criação nem o funcionamento da VM. Solução definitiva: `vagrant plugin update vagrant-libvirt`.

**Plugin não encontrado ao executar `vagrant up`**
Instale o plugin antes de subir a VM:
```bash
vagrant plugin install vagrant-libvirt
```

**`virsh domifaddr lab` não retorna o IP**
O qemu-guest-agent pode levar até 30 segundos para iniciar após o boot.
Aguarde e tente novamente, ou use `nmap` como alternativa.

**`/dev/kvm` não existe após reboot** ou **`could not get preferred machine for /usr/bin/qemu-system-x86_64 type=kvm`**
O módulo KVM não foi carregado. Configure o carregamento automático detectando o fabricante da CPU:
```bash
KVM_MODULE=$(awk '/^vendor_id/{print ($3=="GenuineIntel")?"kvm_intel":"kvm_amd"; exit}' /proc/cpuinfo)
printf 'kvm\n%s\n' "$KVM_MODULE" | sudo tee /etc/modules-load.d/kvm.conf
sudo modprobe "$KVM_MODULE"
```
O arquivo `/etc/modules-load.d/kvm.conf` garante o carregamento nas próximas inicializações.
A ordem importa: `kvm` deve vir antes do módulo específico do fabricante.
