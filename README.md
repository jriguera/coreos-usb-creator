coreos-usb-creator
==================

Coreos image builder (hybrid ISO and FAT32 IMG) for Linux

Usage:

    mkimg.sh  [<arguments>] 

Coreos image builder (hybrid ISO and FAT32 image) for Linux using syslinux: 
IMG: editable FAT32 ready to dump to a USB drive;
ISO: hybrid ISO (image and USB) ready to dump or burn.

Arguments:

    -a, --autologin                       Enable coreos.autologin boot parameter
    -h, --help                            Show this usage message
    -i, --initcloudconfig <cloud-config>  Cloud-config for live booting
    -k, --sshkey <file>                   ssh-key file to include automatically
    -l, --syslinuxversion <version>       Syslinux version (6.02)
    -o, --output <file>                   Output image file (coreos-master.iso)
    -p, --provcloudconfig <cloud-config>  Cloud-config to perform automatic install
    -s, --size <#>                        Size in MB (1000)
    -v, --coreosversion <version>         Coreos version (master)
    -u, --usb                             Create an IMG file (ISO)
    --autoinstall                         Run automatically automatic install (WARNING!)
    --oemcloudconfig <cloud-config>       Static basic cloud-config for OEM


Note that a cloud-config file can be a bash script file. See cloud-init documentation.

