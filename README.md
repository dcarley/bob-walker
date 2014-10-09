# bob-walker

An alternative to [alphagov/vcloud-walker](https://github.com/alphagov/vcloud-walker) in various languages.

## Background

While this might look like some kind of internet bullying, it's all in good fun and mostly sanctioned by the real namesake.

Our team happens to have a Ruby project which walks through the API of a VMWare vCloud instance showing the various objects,
which is called `vcloud-walker`. By happy coincidence, one of our team is called `bob walker`. It was funny to knock up a
quick bob-walker implementation in shell one day, but this project has grown into a place where our team can create educational, 
clever or funny implementations of the original shell script in our own time.

## Usage

### Awk

```sh
awk -f bob-walker.awk [-v sport=true]
```

### Bash

```sh
./bob-walker.sh
```

### Bootloader

```
cd bootloader
make
```

You can then run the outputted image as a floppy disk in VirtualBox.

### Brainf--k (using [this python interpreter](https://github.com/garretraziel/mindfuck))

```
# Normal mode
echo "0" | ../mindfuck/mindfuck.py bob-walker.fk
# Sport mode!
echo "1" | ../mindfuck/mindfuck.py bob-walker.fk
```

### C

```sh
# To compile
gcc -o bob-walker bob-walker.c
# Normal mode
./bob-walker
# Sport mode!
BOB_MODE=SPORT ./bob-walker
```

### Go

```sh
go run bob-walker.go
```

### Linux character device driver

```sh
# Run this on a Linux box; example below is for Ubuntu
#
# Ensure linux-headers package is installed
sudo apt-get install linux-headers-$(uname -r)
# Build the kernel module
cd kernel-bob
make
# Load the module
sudo insmod bob-walker.ko
# Read kernel message buffer for your next instructions
dmesg
```

### NASM Assembly

```sh
nasm -f macho bob-walker.asm
ld -o bob-walker -e main bob-walker.o -macosx_version_min 10.4
./bob-walker
```

### Perl

```perl
./bob-walker.pl
```

### Python

```python
./bob-walker.py
```

### QBasic (QB64)

Open `bob-walker.bas` using [QB64](http://www.qb64.net/) and hit `F5`.

To exit the endless loop, hit `Ctrl + Break` or `Cmd + Q` on a Mac. To create a binary executable, hit `F11` in QB64.

### Scala

```scala
scala bob-walker.scala
```
