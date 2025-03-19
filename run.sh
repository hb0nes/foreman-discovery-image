#!/bin/bash
set -x 

export VAGRANT_HOME=/home/herman/vagrant.d
export VAGRANT_CWD=/home/herman/foreman-discovery-image/aux/vagrant-build
export LC_ALL=C 
export repoowner=hb0nes 
export branch=custom 

[ -d .git ] || { echo "not in git root"; exit 1; }

tmp=aux/vagrant-build/tmp

# Clean tmp
rm -rf $tmp/fdi*
mkdir -p $tmp

# Build image
vagrant up fdi-builder

# Copy ISO out of VM
vagrant ssh-config fdi-builder | tee vagrant-ssh-config.tmp
scp -F vagrant-ssh-config.tmp fdi-builder:foreman-discovery-image/fdi*iso $tmp
rm vagrant-ssh-config.tmp

# Destroy VM
vagrant destroy -f fdi-builder

# Copy initrd and vmlinuz from generated ISO
mount $tmp/fdi*iso /mnt
rsync -av /mnt/isolinux/vmlinuz    ld4-fks-01:/var/lib/tftpboot/boot/fdi-image/vmlinuz0
rsync -av /mnt/isolinux/initrd.img ld4-fks-01:/var/lib/tftpboot/boot/fdi-image/initrd0.img
umount /mnt

# Copy ISO to FKS webserver so it can be pulled through https
rsync -av $tmp/fdi*iso ld4-fks-01:/var/www/html/pub/fdi.iso
