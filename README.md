# nixos-cfg
My NixOS configuration.

## Fresh Install
Boot from a NixOS ISO (minimal or graphical). The install command works either way, but if using the graphical ISO you can clone the repo directly to `/home/nixos/nixos-cfg` and run from there — which is how I do it.

```bash
git clone https://github.com/LazyBev/nixos-cfg /home/nixos/nixos-cfg
cd /home/nixos/nixos-cfg
```

If using the minimal ISO, clone wherever is convenient and adjust the flake path accordingly.

Then wipe and install:

```bash
wipefs -a /dev/nvme0n1 && \
sgdisk --zap-all /dev/nvme0n1 && \
partprobe /dev/nvme0n1 && sleep 2 && \
wipefs -a /dev/nvme0n1p* 2>/dev/null; \
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
  --mode disko \
  --flake .#gentuwu && \
nixos-install --root /mnt --flake .#gentuwu
```

> **Warning:** This will wipe `/dev/nvme0n1` completely.

### Laptop

Same steps, but use the `gentuwu-laptop` host and make sure 16G of swap is available (the disko config expects this):

```bash
git clone https://github.com/LazyBev/nixos-cfg /home/nixos/nixos-cfg
cd /home/nixos/nixos-cfg
```

Then wipe and install:

```bash
wipefs -a /dev/nvme0n1 && \
sgdisk --zap-all /dev/nvme0n1 && \
partprobe /dev/nvme0n1 && sleep 2 && \
wipefs -a /dev/nvme0n1p* 2>/dev/null; \
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
  --mode disko \
  --flake .#gentuwu-laptop && \
nixos-install --root /mnt --flake .#gentuwu-laptop
```

The wipe step is necessary even on a "fresh" install if the disk was previously partitioned — leftover filesystem signatures will cause disko to skip formatting. `wipefs -a /dev/nvme0n1p*` clears those after the partition table is gone.

---

## Generic Template

If you're adapting this for your own system, the general form of the command is:

```bash
wipefs -a /dev/YOUR_DISK && \
sgdisk --zap-all /dev/YOUR_DISK && \
partprobe /dev/YOUR_DISK && sleep 2 && \
wipefs -a /dev/YOUR_DISK* 2>/dev/null; \
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
  --mode disko \
  --flake /path/to/config#YOUR_HOST && \
nixos-install --root /mnt --flake /path/to/config#YOUR_HOST
```

Things to change:
- `/dev/YOUR_DISK` — your target disk, e.g. `/dev/sda`, `/dev/nvme0n1`
- `/path/to/config` — path to your nixos config, or `.` if you're already in the directory
- `YOUR_HOST` — the nixosConfiguration name in your flake, e.g. `gentuwu`
