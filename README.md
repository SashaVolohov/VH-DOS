# Operating system VH-DOS

# 1. Developers:

Sasha Volohov (bootloader, command line, kernel)
Anton Fedorov (core)

# 2. Ideas for VH-DOS:

Add your idea here!

- Write file system [Not completed]
- Make a program for creating / displaying PGM files [Not completed]
- Live diskette in the installer [Not completed]
- Restore System [Not completed]
- User system [Not completed]
- The raa command (similar to sudo on Linux) [Not completed]
- Commands shutdown, restart [Not completed]
- Global bootloader update [Not completed]

# 3. Statistics:

The system weighs 3072 bytes (3 KB, 6 sectors)
Of them:

Loader - 1024 bytes (1 KB, 2 sectors [MBR + 2 sectors])
Kernel - 2048 bytes (2 KB, 4 sectors)

# 4. How to assemble VH-DOS?

Very simple. Run the build.bat file, and the disk.img file (diskette) will appear in the root next to fasm.exe and the VM will start.
