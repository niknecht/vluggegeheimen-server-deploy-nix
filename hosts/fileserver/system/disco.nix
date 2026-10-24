{
  disco.devices.disk = {
    ssd = {
      type = "disk";
      device = "/dev/disk/by-id/wwn-0x5dc663aa0433aa2";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = "1G";
            type = "00EF";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/efi";
              mountoptions = [ "umask=0077" ];
            };
          };
          luksroot = {
            priority = 2;
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              initrdUnlock = true;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountoptions = [ "noatime" ];
              }
            };
          };
        };
      };
    };
  };

  disko.devices.disk.hhd2tb = {
    type = "disk";
    device = "/dev/disk/by-id/wwn-0x5000039e35600f3c";
    content = {
      type = "gpt";
      partitions.data = {
        share = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypt-share-2tb";
            content = {
              type = "lvm_pv";
              vg = "vg_share2tb";
            };
          };
        };
      };
    };
  };


  disko.devices.lvm_vg.vg_share2tb = {
    type = "lvm_vg";
    lvs.share = {
      size = "85%FREE";
      content = {
        type = "filesystem";
        format = "xfs";
        mountpoint = "/srv/disks/share-2tb";
        mountoptions = [ "noatime" ];
      };
    };
  };
  
  /*disko.devices.disk.hdd4tb = {
    type = "disk";
    device = "/dev/disk/by-id/REPLACE_WITH_4TB_HDD_ID"; // TODO: Change here
    content = {
      type = "gpt";
      partitions.data = {
        size = "100%";
        content = {
          type = "lvm_pv";
          vg = "vg_share4";
        };
      };
    };
  };

  disko.devices.lvm_vg.vg_share4 = {
    type = "lvm_vg";
    lvs.share = {
      size = "85%FREE";
      content = {
        type = "filesystem";
        format = "xfs";
        mountpoint = "/srv/disks/share-4tb";
        mountOptions = [ "noatime" ];
      };
    };
  };*/
}
