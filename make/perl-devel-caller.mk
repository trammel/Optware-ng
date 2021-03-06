###########################################################
#
# perl-devel-caller
#
###########################################################

PERL-DEVEL-CALLER_SITE=http://$(PERL_CPAN_SITE)/CPAN/authors/id/R/RC/RCLAMP
PERL-DEVEL-CALLER_VERSION=2.06
PERL-DEVEL-CALLER_SOURCE=Devel-Caller-$(PERL-DEVEL-CALLER_VERSION).tar.gz
PERL-DEVEL-CALLER_DIR=Devel-Caller-$(PERL-DEVEL-CALLER_VERSION)
PERL-DEVEL-CALLER_UNZIP=zcat
PERL-DEVEL-CALLER_MAINTAINER=NSLU2 Linux <nslu2-linux@yahoogroups.com>
PERL-DEVEL-CALLER_DESCRIPTION=meatier versions of caller.
PERL-DEVEL-CALLER_SECTION=util
PERL-DEVEL-CALLER_PRIORITY=optional
PERL-DEVEL-CALLER_DEPENDS=perl-padwalker
PERL-DEVEL-CALLER_SUGGESTS=
PERL-DEVEL-CALLER_CONFLICTS=

PERL-DEVEL-CALLER_IPK_VERSION=1

PERL-DEVEL-CALLER_CONFFILES=

PERL-DEVEL-CALLER_BUILD_DIR=$(BUILD_DIR)/perl-devel-caller
PERL-DEVEL-CALLER_SOURCE_DIR=$(SOURCE_DIR)/perl-devel-caller
PERL-DEVEL-CALLER_IPK_DIR=$(BUILD_DIR)/perl-devel-caller-$(PERL-DEVEL-CALLER_VERSION)-ipk
PERL-DEVEL-CALLER_IPK=$(BUILD_DIR)/perl-devel-caller_$(PERL-DEVEL-CALLER_VERSION)-$(PERL-DEVEL-CALLER_IPK_VERSION)_$(TARGET_ARCH).ipk

$(DL_DIR)/$(PERL-DEVEL-CALLER_SOURCE):
	$(WGET) -P $(@D) $(PERL-DEVEL-CALLER_SITE)/$(@F) || \
	$(WGET) -P $(@D) $(FREEBSD_DISTFILES)/$(@F) || \
	$(WGET) -P $(@D) $(SOURCES_NLO_SITE)/$(@F)

perl-devel-caller-source: $(DL_DIR)/$(PERL-DEVEL-CALLER_SOURCE) $(PERL-DEVEL-CALLER_PATCHES)

$(PERL-DEVEL-CALLER_BUILD_DIR)/.configured: $(DL_DIR)/$(PERL-DEVEL-CALLER_SOURCE) $(PERL-DEVEL-CALLER_PATCHES) make/perl-devel-caller.mk
	$(MAKE) perl-module-build-stage
	rm -rf $(BUILD_DIR)/$(PERL-DEVEL-CALLER_DIR) $(PERL-DEVEL-CALLER_BUILD_DIR)
	$(PERL-DEVEL-CALLER_UNZIP) $(DL_DIR)/$(PERL-DEVEL-CALLER_SOURCE) | tar -C $(BUILD_DIR) -xvf -
#	cat $(PERL-DEVEL-CALLER_PATCHES) | $(PATCH) -d $(BUILD_DIR)/$(PERL-DEVEL-CALLER_DIR) -p1
	mv $(BUILD_DIR)/$(PERL-DEVEL-CALLER_DIR) $(PERL-DEVEL-CALLER_BUILD_DIR)
	(cd $(PERL-DEVEL-CALLER_BUILD_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		CPPFLAGS="$(STAGING_CPPFLAGS)" \
		LDFLAGS="$(STAGING_LDFLAGS)" \
		PERL5LIB="$(STAGING_LIB_DIR)/perl5/site_perl" \
		$(PERL_HOSTPERL) Makefile.PL \
		PREFIX=$(TARGET_PREFIX) \
		--config cc=$(TARGET_CC) \
		--config ld=$(TARGET_CC) \
	)
	touch $@

perl-devel-caller-unpack: $(PERL-DEVEL-CALLER_BUILD_DIR)/.configured

$(PERL-DEVEL-CALLER_BUILD_DIR)/.built: $(PERL-DEVEL-CALLER_BUILD_DIR)/.configured
	rm -f $@
	$(MAKE) -C $(@D) \
		$(TARGET_CONFIGURE_OPTS) \
		LD=$(TARGET_CC) \
		CPPFLAGS="$(STAGING_CPPFLAGS) $(PERL-DEVEL-CALLER_CPPFLAGS)" \
		LDDLFLAGS="-shared $(STAGING_LDFLAGS) $(PERL-DEVEL-CALLER_LDFLAGS)" \
		LDFLAGS="$(STAGING_LDFLAGS) $(PERL-DEVEL-CALLER_LDFLAGS)" \
		PERL5LIB="$(STAGING_LIB_DIR)/perl5/site_perl" \
		;
	touch $@

perl-devel-caller: $(PERL-DEVEL-CALLER_BUILD_DIR)/.built

$(PERL-DEVEL-CALLER_BUILD_DIR)/.staged: $(PERL-DEVEL-CALLER_BUILD_DIR)/.built
	rm -f $@
	$(MAKE) -C $(PERL-DEVEL-CALLER_BUILD_DIR) DESTDIR=$(STAGING_DIR) install
	touch $@

perl-devel-caller-stage: $(PERL-DEVEL-CALLER_BUILD_DIR)/.staged

$(PERL-DEVEL-CALLER_IPK_DIR)/CONTROL/control:
	@$(INSTALL) -d $(@D)
	@rm -f $@
	@echo "Package: perl-devel-caller" >>$@
	@echo "Architecture: $(TARGET_ARCH)" >>$@
	@echo "Priority: $(PERL-DEVEL-CALLER_PRIORITY)" >>$@
	@echo "Section: $(PERL-DEVEL-CALLER_SECTION)" >>$@
	@echo "Version: $(PERL-DEVEL-CALLER_VERSION)-$(PERL-DEVEL-CALLER_IPK_VERSION)" >>$@
	@echo "Maintainer: $(PERL-DEVEL-CALLER_MAINTAINER)" >>$@
	@echo "Source: $(PERL-DEVEL-CALLER_SITE)/$(PERL-DEVEL-CALLER_SOURCE)" >>$@
	@echo "Description: $(PERL-DEVEL-CALLER_DESCRIPTION)" >>$@
	@echo "Depends: $(PERL-DEVEL-CALLER_DEPENDS)" >>$@
	@echo "Suggests: $(PERL-DEVEL-CALLER_SUGGESTS)" >>$@
	@echo "Conflicts: $(PERL-DEVEL-CALLER_CONFLICTS)" >>$@

$(PERL-DEVEL-CALLER_IPK): $(PERL-DEVEL-CALLER_BUILD_DIR)/.built
	rm -rf $(PERL-DEVEL-CALLER_IPK_DIR) $(BUILD_DIR)/perl-devel-caller_*_$(TARGET_ARCH).ipk
	$(MAKE) -C $(PERL-DEVEL-CALLER_BUILD_DIR) DESTDIR=$(PERL-DEVEL-CALLER_IPK_DIR) install
	find $(PERL-DEVEL-CALLER_IPK_DIR)$(TARGET_PREFIX) -name 'perllocal.pod' -exec rm -f {} \;
	(cd $(PERL-DEVEL-CALLER_IPK_DIR)$(TARGET_PREFIX)/lib/perl5 ; \
		find . -name '*.so' -exec chmod +w {} \; ; \
		find . -name '*.so' -exec $(STRIP_COMMAND) {} \; ; \
		find . -name '*.so' -exec chmod -w {} \; ; \
	)
	find $(PERL-DEVEL-CALLER_IPK_DIR)$(TARGET_PREFIX) -type d -exec chmod go+rx {} \;
	$(MAKE) $(PERL-DEVEL-CALLER_IPK_DIR)/CONTROL/control
	echo $(PERL-DEVEL-CALLER_CONFFILES) | sed -e 's/ /\n/g' > $(PERL-DEVEL-CALLER_IPK_DIR)/CONTROL/conffiles
	cd $(BUILD_DIR); $(IPKG_BUILD) $(PERL-DEVEL-CALLER_IPK_DIR)

perl-devel-caller-ipk: $(PERL-DEVEL-CALLER_IPK)

perl-devel-caller-clean:
	-$(MAKE) -C $(PERL-DEVEL-CALLER_BUILD_DIR) clean

perl-devel-caller-dirclean:
	rm -rf $(BUILD_DIR)/$(PERL-DEVEL-CALLER_DIR) $(PERL-DEVEL-CALLER_BUILD_DIR) $(PERL-DEVEL-CALLER_IPK_DIR) $(PERL-DEVEL-CALLER_IPK)

perl-devel-caller-check: $(PERL-DEVEL-CALLER_IPK)
	perl scripts/optware-check-package.pl --target=$(OPTWARE_TARGET) $(PERL-DEVEL-CALLER_IPK)
