
.PHONY: clean

bootloader.img: bootloader.asm
	nasm $^ -f bin -o $@

clean:
	rm bootloader.img
