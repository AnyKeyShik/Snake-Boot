target := build/boot-snake
assembly_source_files := $(wildcard src/*.as)

.PHONY: all clean run


all: $(target)

clean: 
	@echo "Cleaning all..."
	@rm -r build

run: $(target)
	@echo "Running BootSnake"
	@qemu-system-i386 $(target)

$(target): $(assembly_source_files)
	@mkdir build
	@nasm $< -o $@
	@echo "Compile $< part"
