#!/usr/bin/env bash
# setup.sh — provisionamento base da VM de lab
# Instala utilitários essenciais e o qemu-guest-agent para que o host
# consiga obter o IP da VM via "virsh domifaddr".

set -euo pipefail

apt-get update -y
apt-get upgrade -y

apt-get install -y qemu-guest-agent

systemctl enable qemu-guest-agent
systemctl start  qemu-guest-agent

apt-get install -y curl wget git net-tools
