#!/bin/sh
# shellcheck disable=SC2086

usage() {
	printf "
Usage:
%s <install|newday|run|sync>

newday:
	When using the newday command, you must specify the name of the <folder>, which will be created in the ~/AOC23/ directory
	Additionally, the script will use 'ed' for taking in the sample.TXT and input.TXT
	TLDR on how to use 'ed' to input sample text when prompted:
	a
	<paste from clipboard>
	.
	w
	q

sync:
	When using sync, you must specify the target to which you want to sync. This could be either 'host' or 'temple'.
	If you made some changes inside of TempleOS and would like them to be synced to the ./Home/ directory on your
	host machine, just run '%s sync host' and the directory './Home/' on your host machine will be synced to be 
	identical to the one inside the virtual machine.

Some example usages:
	%s run
	%s newday Day1
	%s sync host
\n" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}"
			exit 0
}

configuration() {
	QEMU_SYSTEM_X86_64=qemu-system-x86_64
	QEMU_IMG=qemu-img
	QEMU_FLAGS="-display gtk,zoom-to-fit=on -enable-kvm -m 2048"
	QEMU_IMG_SIZE="512M"
	QEMU_IMG_MOUNT_DIR="./mnt/"
	# Note on the offset: https://www.cloudsavvyit.com/7517/how-to-mount-a-qemu-virtual-disk-image/
	QEMU_IMG_MOUNT_OFFSET=32256
	TEMPLEOS_ISO="./TempleOS.ISO"
	TEMPLEOS_IMAGE="./temple.img"
}

mount_image() {
	sync
	sudo umount $QEMU_IMG_MOUNT_DIR || true
	mkdir -p $QEMU_IMG_MOUNT_DIR
	sudo mount -o loop,offset=$QEMU_IMG_MOUNT_OFFSET,rw,uid="$(id -u)",gid="$(id -g)" "$TEMPLEOS_IMAGE" "$QEMU_IMG_MOUNT_DIR"
}

configuration

case "$1" in
install)
	$QEMU_IMG create "$TEMPLEOS_IMAGE" $QEMU_IMG_SIZE
	$QEMU_SYSTEM_X86_64 $QEMU_FLAGS -cdrom $TEMPLEOS_ISO -hda "$TEMPLEOS_IMAGE" -boot d
	;;
newday)
	[ -z "$2" ] && echo "You need to specify the folder's name when creating a new day." && exit 1
	mount_image
	mkdir -p "$QEMU_IMG_MOUNT_DIR/Home/AOC23/$2"
	cp "$QEMU_IMG_MOUNT_DIR/Home/AOC23/Template.HC" "$QEMU_IMG_MOUNT_DIR/Home/AOC23/$2/Main.HC"
	ed "$QEMU_IMG_MOUNT_DIR/Home/AOC23/$2/sample.TXT"
	ed "$QEMU_IMG_MOUNT_DIR/Home/AOC23/$2/input.TXT"
	;;
run)
	mount_image
	GDK_BACKEND=x11 $QEMU_SYSTEM_X86_64 $QEMU_FLAGS "$TEMPLEOS_IMAGE"
	;;
sync)
	[ -z "$2" ] && echo "You need to specify the target to which you want to sync <host|temple>" && exit 1
	mount_image
	case "$2" in
			"host")
					rsync -avz --delete $QEMU_IMG_MOUNT_DIR/Home ./
					;;
			"temple")
					rsync -avz --delete ./Home $QEMU_IMG_MOUNT_DIR/
					;;
	esac
	;;
*) usage ;;
esac

