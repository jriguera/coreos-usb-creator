#!/bin/bash

cat <<CLOUD_CONFIG > /tmp/cloud-config.yaml
#cloud-config

hostname: coreos
coreos:
    etcd:
        name: coreos
    update:
        reboot-strategy: etcd-lock
    units:
      - name: etcd.service
        command: start
      - name: fleet.service
        command: start
  units:
      - name: docker-tcp.socket
        command: start
        enable: yes
        content: |
          [Unit]
          Description=Docker Socket for the API
          [Socket]
          ListenStream=2375
          BindIPv6Only=both
          Service=docker.service
          [Install]
          WantedBy=sockets.target
      - name: enable-docker-tcp.service
        command: start
        content: |
          [Unit]
          Description=Enable the Docker Socket for the API
          [Service]
          Type=oneshot
          ExecStart=/usr/bin/systemctl enable docker-tcp.socket

users:
  - name: jriguera
    ssh-authorized-keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0g+ZTxC7weoIJLUafOgrm+h
    groups:
      - sudo
      - docker
      - core
      - wheel

write_files:
    - path: /etc/systemd/network/static.network
      content: |
        [Match]
        MACAddress=00:1c:c4:87:c5:2e
        [Network]
        Gateway=192.168.1.1
        Address=192.168.1.5/24
        DNS=8.8.8.8
    - path: /home/core/.dockercfg
      owner: core:core
      permissions: 0644
      content: |
        {
          "https://index.docker.io/v1/": {
            "auth": "xXxXxXxXxXx=",
            "email": "username@example.com"
          }
        }

CLOUD_CONFIG


## UNCOMMENT the following line to install
#sudo coreos-install -d /dev/vda -c /tmp/cloud-config.yaml
sync
sudo reboot

