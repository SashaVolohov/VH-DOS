# Operating system VH-DOS
### Current Usage
Currently, the repository is used only as a [kernel procedures collection](https://github.com/SashaVolohov/VH-DOS/tree/master/sources/kernel). They are really well tested.

### System Requirements
| System Component | At least this |
| :--------------- | ------------: |
| CPU | 186 |
| FPU | not required |
| Video Adapter | MDA/CGA/EGA |
| Hard disk capacity | 4 Kilobytes |
| PC Speaker | Preferably to have |

### Developers Team
* [Larry Holst](https://github.com/Diicorp95) — *README.md, LICENSE, main active programmer*
* [Sasha Volohov](https://github.com/SashaVolohov) — *bootloader, command line, kernel: 1.0α*
* Anton Fedorov — *core: 0.7α*

### To-Do
New ideas will be considered by moderators
- [ ] Fixing bugs, see issues: [#3](https://github.com/SashaVolohov/VH-DOS/issues/3) [#2](https://github.com/SashaVolohov/VH-DOS/issues/2)
- [ ] Bring OS to work!
- [X] ~~ACPI commands: `shutdown`, `restart`~~, add `shutdown` command
- [X] Do a global bootloader upgrade
- [ ] Code library for using FAT32
- [ ] Code program for creating/displaying PGM files
- [ ] Option of creating backup diskette on setup process
- [ ] Option of system restoring (if the system parts will be damaged)
- [ ] ~~Code setup disk for OS~~, use compression algorithms
- [ ] User access control system, similar to Linux
- [ ] `raa` command - full administrator access

### Raw Statistics
Total amount of compiled bytes on this moment
| Part of OS | Size in bytes |
| :--------- | ------------: |
| Bootloader | 2165B |
| Kernel | 955B |
| Setup | 2507B |
