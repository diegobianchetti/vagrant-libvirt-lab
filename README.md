# vagrant-libvirt-lab

Lab descartável para testar ambientes containerizados em KVM/libvirt via Vagrant.

---

## Objetivo

Provisionar rapidamente uma VM Ubuntu 24.04 no libvirt para experimentação local —
instalação de Docker, testes de Ansible, validação de containers — sem risco ao ambiente principal.

## Pré-requisitos

- libvirt, qemu-kvm e Vagrant >= 2.4 instalados no host
- Usuário nos grupos `libvirt` e `kvm`
- Plugin vagrant-libvirt instalado

Instruções detalhadas em [docs/USAGE.md](docs/USAGE.md).

## Quickstart

```bash
vagrant plugin install vagrant-libvirt
vagrant up
vagrant ssh
```

## Descobrindo o IP da VM

```bash
virsh domifaddr lab
```

O qemu-guest-agent é instalado automaticamente pelo provisionamento.
Aguarde ~30 segundos após o boot se o IP não aparecer imediatamente.

## Destruindo a VM

```bash
vagrant destroy -f
```

---

## Decisões Técnicas

**Por que Vagrant + libvirt em vez de `virt-install` direto?**
O Vagrantfile é versionável e reproduzível; `virt-install` exige comandos manuais longos
e difíceis de compartilhar. O Vagrant abstrai a criação sem esconder o provider —
o backend continua sendo KVM nativo.

**Por que shell inline em vez de Ansible nessa primeira versão?**
Mantém dependências mínimas: basta ter o Vagrant e o plugin instalados.
A integração com `ansible-docker-setup` está no roadmap.

**Por que DHCP em vez de IP fixo?**
Evita conflito com outras VMs no lab. O IP é facilmente descoberto via
`virsh domifaddr` (requer qemu-guest-agent) ou `nmap`.

---

## Roadmap

- VM dev persistente com disco separado para desenvolvimento contínuo
- Integração com [ansible-docker-setup](https://github.com/diegobianchetti/ansible-docker-setup)
  via provisioner Ansible
- Suporte a cloud-init + `virt-install` como alternativa ao Vagrant

---

## Licença

[GPL v3](https://www.gnu.org/licenses/gpl-3.0.html)
