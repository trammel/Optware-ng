# Description

This is an Optware fork. It targets to be firmware-independent and currently supports hard-float ARMv7, I686, PowerPC 603e and soft-float ARMv5, ARMv7 EABI and MIPSEL targets. Feeds building and hosting resources are kindly provided by [Nas-Admin.org project](http://www.nas-admin.org).

# Help wanted

Now that Optware-ng is official, we're looking for developers and wiki writers. If you're willing to give it a go, please see '**Contributing to project and building from source**' and '**Writing Optware-ng end-user instructions**' sections below.

# Attention!

Optware-ng feeds have moved to [http://ipkg.nslu2-linux.org/optware-ng](http://ipkg.nslu2-linux.org/optware-ng). Please run this command to update ipkg configuration if you installed Optware-ng prior to this announcement:

```
sed -i -e 's|optware-ng\.zyxmon\.org/|ipkg.nslu2-linux.org/optware-ng/|' /opt/etc/ipkg.conf
ipkg update
```

# Attention!

buildroot-mipsel-ng feed is now rebuilt with 2.6.22.19 kernel headers. Please reinstall all currently installed packages if you installed this feed earlier:

```
ipkg update
ipkg -force-reinstall install `ipkg list_installed|cut -d ' ' -f1`
```

# Getting started

The instructions below only download, unpack and configure the package manager `ipkg`. You must previously make sure that `/opt` is writable, by preparing USB storage or router's `jffs` partition (for routers that support them), or symlink/mount-bind `/opt` to a location on your data volume (e.g., for a NAS). If you have MIPSEL/ARM Asus router running [Asuswrt-Merlin firmware](http://asuswrt.lostrealm.ca/download), check out [How To Install New Generation Optware](https://www.hqt.ro/how-to-install-new-generation-optware) guide by @TeHashX.

To bootstrap the feed, connect over SSH/Telnet and type:

ARMv7 EABI hardfloat:
(Use this if you have a modern ARM device with FPU, e.g., a NAS)
```
wget -O - http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-armeabihf-bootstrap.sh | sh
```
ARMv7 EABI softfloat:
(Use this for a modern ARM device without FPU, e.g., an ARMv7 router)
```
wget -O - http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-armeabi-ng-bootstrap.sh | sh
```
ARMv5 EABI:
```
wget -O - http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-armv5eabi-ng-bootstrap.sh | sh
```
MIPSEL:
```
wget -O - http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-mipsel-ng-bootstrap.sh | sh
```
PowerPC 603e:
```
wget -O - http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-ppc-603e-bootstrap.sh | sh
```
I686:
```
wget -O - http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-i686-bootstrap.sh | sh
```
ipkg package manager will be bootstrapped and configured. See available packages:
```
export PATH=$PATH:/opt/bin:/opt/sbin
/opt/bin/ipkg update
/opt/bin/ipkg list
```
Install desired ones:
```
/opt/bin/ipkg install nano mc
```

# Available packages

* [ARMv7 EABI hardfloat](http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf/Packages.html)
* [ARMv7 EABI softfloat](http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabi-ng/Packages.html)
* [ARMv5 EABI](http://ipkg.nslu2-linux.org/optware-ng/buildroot-armv5eabi-ng/Packages.html)
* [MIPSEL](http://ipkg.nslu2-linux.org/optware-ng/buildroot-mipsel-ng/Packages.html)
* [PowerPC 603e](http://ipkg.nslu2-linux.org/optware-ng/buildroot-ppc-603e/Packages.html)
* [I686](http://ipkg.nslu2-linux.org/optware-ng/buildroot-i686/Packages.html)

# Contributing to project and building from source

Contribution is always welcomed. These wiki pages contain useful info to get you started:

* [Contributing to Optware-ng](https://github.com/Optware/Optware-ng/wiki/Contributing-to-Optware-ng)
* [Adding a package to Optware-ng](https://github.com/Optware/Optware-ng/wiki/Adding-a-package-to-Optware-ng)

# Writing Optware-ng end-user instructions

Currently, the project is missing writers who would contribute by creating how-to's for end-users. We can setup a mediawiki with the help of nas-admin.org guys, but we need people to fill it. In case you are willing to contribute by writing how-to's, please contact me on #**optware** IRC channel on irc.freenode.net, nickname **alllexx**. If I'm away, you can PM me, and I'll reach you later.

# News

## 2016-02-23

Optware-ng is now official. Feeds are built and hosted by [Nas-Admin.org project](http://www.nas-admin.org). See http://jenkins.nas-admin.org/view/Optware

## 2016-02-14

buildroot-mipsel-ng feed, rebuilt with 2.6.22.19 kernel headers using kernel from the [wl500g](https://github.com/wl500g/wl500g) project, is now online.

## 2015-11-30

New buildroot-ppc-603e is now online. This is a hardfloat PowerPC 603e gcc-5.2.0, glibc-2.21, linux-3.2.66 feed.

## 2015-10-26

New buildroot-armv5eabi-ng feed is now online. This is a softfloat ARMv5 gcc-5.2.0, uClibc-ng-1.0.6, linux-2.6.36.4 feed. It targets ARMv5 devices with EABI interface, like older ARM NASes or android devices.

## 2015-09-29

New buildroot-armeabihf feed is now online. This is a hardfloat ARMv7 gcc-5.2.0, glibc-2.21, linux-3.2.66 feed. It targets ARMv7 devices with FPUs, like most modern android devices or ARM NASes, and gives significant performance boost on such devices compared to softfloat.

## 2015-09-16

New buildroot-armeabi-ng and buildroot-mipsel-ng feeds should now be used for softfloat ARMv7 and MIPSEL devices. These are uClibc-ng-1.0.6 gcc-5.2.0 targets. Look above for instructions on migrating from now deprecated buildroot-armeabi and buildroot-mipsel feeds.

## 2015-09-05

Upgrade buildroot-armeabi, buildroot-i686 and buildroot-mipsel toolchains to gcc-5.2.0 to support all C++14 language features. libc versions and configs and kernel headers versions left the same to not brake compatibility with previously built binaries. Also use "--with-default-libstdcxx-abi=gcc4-compatible" libstdc++ configure switch for the same purpose. Buildroot-2015.08 is now used to build the toolchains.

## 2015-04-30:

New buildroot-i686 target added. This is a gcc-4.9.2, glibc-2.20, linux-3.2.66 feed. It mainly targets modern Intel headless devices, such as NASes.

## 2015-04-19:

Now buildroot-mipsel target added. It is similar to buildroot-armeabi, but targets mipsel softfloat (mips32r2) devices.
