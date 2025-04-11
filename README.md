# Phantom Drive

**A portable, secure, and isolated OS-on-a-stick.**  
Boot from anywhere. Leave no trace. Launch into virtual machines. Stay in control.

---

## What Is Phantom Drive?

Phantom Drive is a full Ubuntu-based operating system installed on a USB drive with built-in virtualization, hardened security, and compartmentalized storage. It’s not a live USB. It’s not a throwaway toolkit. It’s your entire digital environment—portable, encrypted, and private.

Designed for:
- Penetration testers
- Security-conscious travelers
- Journalists, devs, and tinkerers
- Anyone who wants to **own** their workspace

---

## Core Features

- **Bootable USB with persistent Ubuntu base OS**
- **Air-gapped by default** (network services off on boot)
- **MAC address randomization**
- **GRUB-controlled UEFI boot partition**
- **VirtualBox pre-installed for multi-OS flexibility**
- **VMs stored on exFAT partition (Windows, Kali, etc.)**
- **Custom inotify-based VM launcher dialog**
- **Self-wipe on failed login attempts (optional)**
- **Minimal UI—just what you need, nothing you don't**

---

## Architecture

/dev/sdb1 – EFI boot partition (1 GB, FAT32, boot/esp) 
\n/dev/sdb2 – Ubuntu OS (33 GB, ext4) 
\n/dev/sdb3 – Shared storage + VMs (200 GB, exFAT)


---

## Getting Started

1. Clone this repo
2. Use the `install/` scripts to set up your USB
3. Reboot and boot from USB (UEFI recommended)
4. Launch into your VM of choice via the Phantom Launcher

> Detailed walkthroughs available in the `docs/` folder

---

## Contributing

Want to contribute? Hell yes.

Whether you're into bash scripting, kernel hardening, UX design, or just writing great documentation, there's room for you.

Start with our [CONTRIBUTING.md](CONTRIBUTING.md) to get familiar.

Some good first issues:
- Pmprove graphical VM launcher
- Integrate LUKS encryption
- Optimize boot time and systemd units
- Add hash checking for new .VBOX files
- Harden network stack and isolate VM interfaces

---

## Philosophy

> “Phantom Drive isn’t just about protecting data—it’s about reclaiming control over the machines we use, the traces we leave,and the boundaries we draw between ourselves and the systems that want to own us.”

---

## License

MIT for now. 
Attribution welcomed.
Usage encouraged. 
Lock in your own build and make it yours.

---

## Credits

Project Lead: Adam Kearsey  
collaborator: 
PhantomDrive@Proton.ME

