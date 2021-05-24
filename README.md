# Operating system VH-DOS
## Description Table
| Type | Description |
| ---- | ----------- |
| Version | 0.1.4α |
| Stage | Early alpha |
| Global bugs count | ~4 |
| Dialect | Flat Assembler |
| Building OS | Microsoft&reg; Windows&reg; XP and newer |

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
| Fixes, organization | [Larry Holst](https://github.com/Diicorp95) | 0.1.1α |
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

## Feedback
<a href="mailto:vhdos.devteam@gmail.com?subject=GitHubRepo%3AVH-DOS&body=Hello%20everybody!%0AI%20want%20to%20tell%20you%20about..."><img alt="" src="https://github.com/SashaVolohov/VH-DOS/blob/master/GMAIL_old_logo.png" width="340" height="auto"></a><br>
<a href="https://discord.gg/AQ593d2xdD"><img alt="" src="https://discord.com/assets/cb48d2a8d4991281d7a6a95d2f58195e.svg" width="340" height="auto"></a>

<img alt="" src="http://nfewordbag.atwebpages.com/empty?">
