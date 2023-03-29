# VH-DOS the operating system
The development process is frozen due to low people interest to help with it.

[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/SashaVolohov/VH-DOS)](https://github.com/SashaVolohov/VH-DOS/commits/master)
[![GitHub](https://img.shields.io/github/license/SashaVolohov/VH-DOS)](#)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/SashaVolohov/VH-DOS)](#)

## Description Table
| Type | Description |
| ---- | ----------- |
| Version | 0.1.4 |
| Dialect | Flat Assembler |
| Building OS | <ul><li>Microsoft&reg; Windows&reg; 2000 and newer</li><li>POSIX system after 2014</li></ul> |

## System Requirements
| System component | Minimum |
| :--------------- | ------: |
| BIOS | IBM PC/AT-compatible with BIOS. (U)EFI is not supported. |
| CPU | 80186 |
| FPU | *not required* |
| Video adapter | MDA |
| Hard disk capacity | 4 kibibytes |
| PC Speaker | *not required* |

## Building
### Microsoft Windows
```
makefile.bat
```

### Linux, MacOS
```sh
make
# or
make all
```

To install the required packages (just `fasm`), run the following command:
```sh
make install
```

To check that the OS is compiled or had compiled successfully, run the following command:
```sh
make check
```
