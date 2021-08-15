# Operating system VH-DOS
Development process is frozen due to low people interest to help with it.

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FSashaVolohov%2FVH-DOS&count_bg=%2379C83D&title_bg=%23555555&icon=github.svg&icon_color=%23E7E7E7&title=hits&edge_flat=false)](#)
[![Discord server](https://img.shields.io/discord/825320998663356426?label=Discord%20server&logo=Discord&logoColor=%23FFFFFF)](https://discord.gg/AQ593d2xdD)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/SashaVolohov/VH-DOS)](https://github.com/SashaVolohov/VH-DOS/commits/master)
[![GitHub](https://img.shields.io/github/license/SashaVolohov/VH-DOS)](#)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/SashaVolohov/VH-DOS)](#)

## Description Table
| Type | Description |
| ---- | ----------- |
| Version | 0.1.4α |
| Stage | Early alpha |
| Global bugs count | ~4 |
| Dialect | Flat Assembler |
| Building OS | Microsoft&reg; Windows&reg; 2000 and newer |

## Current Usage
Currently, the repository is used only as a [kernel procedures collection](https://github.com/SashaVolohov/VH-DOS/tree/master/sources/kernel). They are really well tested.

## System Requirements
| System Component | At least this |
| :--------------- | ------------: |
| BIOS | IBM PC/AT-compatible. UEFI is not supported. |
| CPU | 186 |
| FPU | *Not required* |
| Video Adapter | MDA/CGA/EGA |
| Hard disk capacity | 4 Kilobytes |
| PC Speaker | *Not required* |

## Developers Team
### Bootloader
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Fixes, organization | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Originals | [Alexander Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### Core
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Fixes, organization | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Originals | [Alexander Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### Setup disk
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Fixes, organization | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Originals | [Alexander Volohov](https://github.com/SashaVolohov) | 0.1.0α |
### README.md
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Originals | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
| Older version | [Alexander Volohov](https://github.com/SashaVolohov) | - |
### Kernel procedures
| Changes | Author | Since version |
| ------- | ------ | ------------- |
| Fixes, organization, new procedures | [Larry Holst](https://github.com/Diicorp95) | 0.1.4α |
| Originals | Anton Fedorov | 0.7α |

## Version time log
Timestamps are specified in GMT+03:00 24-hour format.
Dates are specified in DD.MM.YYYY format
| Version | Date | Time |
| ------- | ---- | ---- |
| 0.1.0α | 14.02.2021 | 08:00 |
| 0.1.1α | 25.02.2021 | 19:00 |
| 0.1.2α | 18.03.2021 | 16:35 |
| 0.1.3α | 23.03.2021 | 16:35 |
| 0.1.4α | 26.03.2021 | 18:20 |

## To-Do
New ideas will be considered by moderators
- [ ] Fixing bugs, see issues: [#3](https://github.com/SashaVolohov/VH-DOS/issues/3) [#2](https://github.com/SashaVolohov/VH-DOS/issues/2)
- [ ] Bring OS to work!
- [X] ~~ACPI commands: `shutdown`, `restart`~~, add `shutdown` command
- [X] Do a global bootloader upgrade
- [ ] Code library for using FAT32
- [ ] Code program for creating/displaying PGM files
- [ ] Option of creating backup diskette on setup process
- [ ] "Teach" the OS to determine the disk that installer is loaded from; encounter all possible data mediums for installing the OS; boot from disk that it has determined as the root of installed system — in other words, just its disk.
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
