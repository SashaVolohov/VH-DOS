# Operating system VH-DOS
## Description Table
| Type | Description |
| ---- | ----------- |
| Version | 0.1.4α |
| Stage | Early alpha |
| Global bugs count | ~4 |

## Current Usage
Currently, the repository is used only as a [kernel procedures collection](https://github.com/SashaVolohov/VH-DOS/tree/master/sources/kernel). They are really well tested.

## System Requirements
| System Component | At least this |
| :--------------- | ------------: |
| CPU | 186 |
| FPU | not required |
| Video Adapter | MDA/CGA/EGA |
| Hard disk capacity | 4 Kilobytes |
| PC Speaker | Preferably to have |

## Developers Team
### Bootloader
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Fixes, organization | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Originals | [Sasha Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### Core
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Fixes, organization | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Originals | [Sasha Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### Setup disk
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Fixed, organized | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Originals | [Sasha Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### README.md
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Originals | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Older version | [Sasha Volohov](https://github.com/SashaVolohov) | - |
### Kernel procedures
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Fixes, organization, new procedures | [Larry Holst](https://github.com/Diicorp95) | 0.1.4α |
| Originals | Anton Fedorov | 0.7α |

## To-Do
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

## Raw Statistics
Total amount of compiled bytes on this moment
| Part of OS | Size in bytes |
| :--------- | ------------: |
| Bootloader | 2165B |
| Kernel | 955B |
| Setup | 2507B |
