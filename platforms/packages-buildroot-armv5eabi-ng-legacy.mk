SPECIFIC_PACKAGES = \
	libiconv uclibc-opt \
	$(PERL_PACKAGES) \
	binutils libc-dev gcc \
	ipkg-static \

# iptraf: sys/types.h and linux/types.h conflicting
# wayland: requires signalfd, timerfd_* and epoll_create1
# gtk: depends on wayland
# gtksourceview, gedit: depend on gtk
# inferno: failing with asm-arm.S:30: Error: invalid constant (900001) after fixup
BROKEN_PACKAGES = \
	6relayd \
	buildroot \
	$(UCLIBC_BROKEN_PACKAGES) \
	bluez-hcidump \
	clamav \
	rssh \
	sandbox \
	lm-sensors \
	libopensync msynctool obexftp \
	modutils \
	wayland gtk gtksourceview gedit \
	inferno

PERL_MAJOR_VER := 5.20

HTOP_VERSION := 1.0.1
HTOP_IPK_VERSION := 1

TSHARK_VERSION := 1.2.12
TSHARK_IPK_VERSION := 1

FFMPEG_CONFIG_OPTS := --disable-armv6

OPENSSL_VERSION := 1.0.2

BOOST_VERSION := 1_59_0
BOOST_IPK_VERSION := 1
BOOST_EXTERNAL_JAM := no
BOOST_GCC_CONF := tools/build/src/tools/gcc
BOOST_JAM_ROOT := tools/build
BOOST_ADDITIONAL_LIBS:= atomic \
			chrono \
			container \
			graph-parallel \
			locale \
			log \
			timer \
			exception \
			serialization \
			wave

### boost packages
## These are packages that depend
## on boost. Since boost libraries SONAMEs
## change with every new release,
## ipk versions have to be bumped
## and packages re-built on every
## boost upgrade.
## Use
### make boost-packages-dirclean
## to clean all boost packages build dirs

LIBTORRENT-RASTERBAR_IPK_VERSION := 1

MKVTOOLNIX_VERSION := 8.8.0
MKVTOOLNIX_IPK_VERSION := 1
MKVTOOLNIX_ADDITIONAL_PATCHES=$(SOURCE_DIR)/mkvtoolnix/8.8.0/llround-lround.patch

PLAYER_IPK_VERSION := 1
