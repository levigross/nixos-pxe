# PXE Boot NixOS

## How to build
```bash
$ nix build
$ ls -lah result/
total 17M
dr-xr-xr-x    3 root root     8 Dec 31  1969 .
drwxrwxr-t 5973 root nixbld 35K Jul 17 21:46 ..
lrwxrwxrwx    1 root root    64 Dec 31  1969 bzImage -> /nix/store/n7d735bpf7z3ip08h63kxhdl2lvawqbm-linux-6.3.12/bzImage
lrwxrwxrwx    1 root root    57 Dec 31  1969 initrd -> /nix/store/32caxv2q6mnrh1p2bicyj1jwin3qj9bm-initrd/initrd
lrwxrwxrwx    1 root root     6 Dec 31  1969 initrd.zst -> initrd
dr-xr-xr-x    3 root root     3 Dec 31  1969 lib
lrwxrwxrwx    1 root root    69 Dec 31  1969 netboot.ipxe -> /nix/store/1jr8hkjih4fsx96a5c13gg6xza9jjwa9-netboot.ipxe/netboot.ipxe
lrwxrwxrwx    1 root root    67 Dec 31  1969 System.map -> /nix/store/n7d735bpf7z3ip08h63kxhdl2lvawqbm-linux-6.3.12/System.map
```

## How to test using a VM

```
$ nixos-rebuild build-vm --flake .#generic
$ result/bin/run-aleph-vm
```

## How to update
```bash
$ nix flake update  
```

