# Operating system VH-DOS
The development process is frozen due to low people interest to help with it.

[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/SashaVolohov/VH-DOS)](https://github.com/SashaVolohov/VH-DOS/commits/master)
[![GitHub](https://img.shields.io/github/license/SashaVolohov/VH-DOS)](#)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/SashaVolohov/VH-DOS)](#)

## Description Table
| Type | Description |
| ---- | ----------- |
| Version | 0.1.4α |
| Stage | Alpha (α) |
| Bugs count | 3 |
| Dialect | Flat Assembler |
| Building OS | Microsoft&reg; Windows&reg; 2000 and newer |

## System Requirements
| System component | Minimum |
| :--------------- | ------: |
| BIOS | IBM PC/AT-compatible. UEFI is not supported. |
| CPU | 186 |
| FPU | *not required* |
| Video adapter | MDA |
| Hard disk capacity | 4 Kibibytes |
| PC Speaker | *not required* |

## Developer Team
### Bootloader
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Bugfixes, formatting | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Original | [Alexander Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### Core
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Bugfixes, formatting | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Original | [Alexander Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### Setup disk
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Bugfixes, formatting | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Original | [Alexander Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### README.md
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Current version | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Original | [Alexander Volohov](https://github.com/SashaVolohov) | - |
### Kernel procedures
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Bugfixes, formatting, new procedures | [Larry Holst](https://github.com/Diicorp95) | 0.1.4α |
| Original | Anton Fedorov | 0.7α |

## Version log
The time stamps correspond to GMT.
Dates are specified in `DD.MM.YYYY` format.
| Version | Date | Time |
| ------- | ---- | ---- |
| 0.1.4α | 26.03.2021 | 15:20 |
| 0.1.3α | 23.03.2021 | 13:35 |
| 0.1.2α | 18.03.2021 | 13:35 |
| 0.1.1α | 25.02.2021 | 16:00 |
| 0.1.0α | 14.02.2021 | 05:00 |

## To-Do
- [ ] Fixing bugs, see issues: [#3](https://github.com/SashaVolohov/VH-DOS/issues/3) [#2](https://github.com/SashaVolohov/VH-DOS/issues/2)
- [ ] Bring OS to work!
- [X] ~~ACPI commands: `restart`~~, add `shutdown` command
- [X] Do a global bootloader upgrade
- [ ] Code library for using FAT32
- [ ] Code program for creating/displaying PGM files
- [ ] Option of creating backup diskette on setup process
- [ ] "Teach" the OS to determine the disk that installer is loaded from; encounter all possible data mediums for installing the OS; boot from disk that it has determined as the root of installed system — in other words, just its disk.
- [ ] Option of system restoring (in case the system parts are damaged)
- [ ] ~~Code setup disk for OS~~, use compression algorithms
- [ ] User access control system, similar to Linux
- [ ] `raa` command - full administrator access

## Raw Statistics
Total amount of compiled bytes on this moment
| Part of the OS | Size (bytes) |
| :------------- | -----------: |
| Bootloader | 2165 |
| Kernel | 955 |
| Setup | 2507 |
