#!/usr/bin/env bash
set -eux

# config:disks
PRIMARY_DISK="/dev/vda"

# config:partitions
EFI_PART="${PRIMARY_DISK}1"
ROOT_PART="${PRIMARY_DISK}2"

# config:luks
LUKS_ROOT="luks_root"

# config:lvm:vgs
VG_ROOT="vg0_root"

# config:lvm:lvs
LV_ROOT_HOME="home"
LV_ROOT_ROOT="root"
LV_ROOT_SWAP="swap"

# config:mount
INSTALL_ROOT="/mnt"

# install:partitions
sudo parted -s "$PRIMARY_DISK" mklabel gpt
sudo parted -s "$PRIMARY_DISK" mkpart ESP fat32 1MiB 513MiB
sudo parted -s "$PRIMARY_DISK" set 1 esp on
sudo parted -s "$PRIMARY_DISK" mkpart primary 513MiB 100%

# install:luks
sudo cryptsetup luksFormat "$ROOT_PART" --batch-mode
sudo cryptsetup open       "$ROOT_PART" "$LUKS_ROOT"

# install:lvm
sudo pvcreate            "/dev/mapper/$LUKS_ROOT"
sudo vgcreate "$VG_ROOT" "/dev/mapper/$LUKS_ROOT"

sudo lvcreate "$VG_ROOT" -n "$LV_ROOT_HOME" -L 8GiB
sudo lvcreate "$VG_ROOT" -n "$LV_ROOT_SWAP" -L 1GiB
sudo lvcreate "$VG_ROOT" -n "$LV_ROOT_ROOT" -l 100%FREE

# install:filesystems
sudo mkfs.vfat -F 32 "$EFI_PART"

for lv in "$LV_ROOT_HOME" "$LV_ROOT_ROOT"; do
	sudo mkfs.ext4 "/dev/$VG_ROOT/$lv"
done

sudo mkswap "/dev/$VG_ROOT/$LV_ROOT_SWAP"

# install:mounts
sudo mount --mkdir "/dev/$VG_ROOT/$LV_ROOT_ROOT" "$INSTALL_ROOT"

sudo mount --mkdir "$EFI_PART" "$INSTALL_ROOT/boot"
sudo mount --mkdir "/dev/$VG_ROOT/$LV_ROOT_HOME" "$INSTALL_ROOT/home"
sudo swapon "/dev/$VG_ROOT/$LV_ROOT_SWAP"

# install:nixos
sudo nixos-generate-config --root "$INSTALL_ROOT"
sudo vim /mnt/etc/nixos/configuration.nix
sudo nixos-install
