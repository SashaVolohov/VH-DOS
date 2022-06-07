all:
	@bash makefile.sh

clean:
	@find . -type f -name '*.bin' -print0 | xargs -0 rm -vf

install:
	@pacman -Syu fasm && doas apt-get install fasm && sudo apt-get install fasm || echo "Failed to automatically install package \"fasm\"."

check:
	@test -f ./setup.img && echo "The installation image exists" || echo "The installation image does not exists!"

.PHONY:
	clean
