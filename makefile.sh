read -p "Executable FASM file path: " fasm
srcs=./sources

# Compiling OS
echo "VH-DOS is compiling..."
date +"VH-DOS build at %D, %T%n" > ./build.log
# ~ echo "" >> build.log
pause() {
	read -n 1 -t 30 -s
}
fakefasm="...${fasm:${#fasm}-11:${#fasm}}"
eachfile () {
	echo "$fakefasm/$1" >> ./build.log
	$fasm $1 >> ./build.log
	if [ "$?" -gt "0" ];
	then
		pause
		exit 1
	fi
	echo "" >> build.log
	
}
asmfiles=()
find ./sources -type f \( -name "*.asm" -o -name "*.inc" \) -print0 >tmpfile
while IFS=  read -r -d $'\0'; do
	asmfiles+=("$REPLY")
done <tmpfile
rm -f tmpfile
for curfile in "${asmfiles[@]}"
do
	eachfile curfile
done
# Making installation image
echo "Building installation image..."
# $fasm $srcs/compile.asm
cp $srcs/compile.bin ./setup.img
find ./sources -type f -name "*.bin" -print0 | xargs -0 rm -f
pause
exit 0
