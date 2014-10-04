include ./make_partials/variables.mk
-include ./make_partials/overrides.mk

VERSION=
NEXT_VERSION=
PREVIOUS=
CURRENT=
CURRENT_TARBALL=`readlink -f release/current.tar.gz`
SPEC_FILE=module.spec

GIT_HASH=`git log -1 --format="%H"`
DATESTAMP=`TZ=GMT date +%Y%m%d_%H%M%S`

PATH := ./node_modules/.bin:${PATH}
BIN = ./node_modules/.bin

DEPLOY_TARGET_IN_RPM = \$$RPM_BUILD_ROOT${DEPLOY_TARGET}/${TARGET}

define install_npm_modules
	ATTEMPT=0 ; \
	until [ $$ATTEMPT -ge $(RETRY_AMOUNT) ] ; \
	do \
		echo "Installing NPM Modules (Attempt #`expr $$ATTEMPT + 1`/$(RETRY_AMOUNT))" ; \
		npm config set registry="http://registry.npmjs.org/" ; \
		npm install ; \
		RESULT=$$? ; \
		[ $$RESULT -eq 0 ] && break ; \
		ATTEMPT=`expr $$ATTEMPT + 1` ; \
		sleep 1 ; \
	done ; \
	if [ $$RESULT -ne 0 ] ; \
	then \
	    exit 1 ; \
	fi
endef

define install_bower_modules
	ATTEMPT=0 ; \
	until [ $$ATTEMPT -ge $(RETRY_AMOUNT) ] ; \
	do \
		echo "Installing Bower Modules (Attempt #`expr $$ATTEMPT + 1`/$(RETRY_AMOUNT))" ; \
		bower install ; \
		RESULT=$$? ; \
		[ $$RESULT -eq 0 ] && break ; \
		ATTEMPT=`expr $$ATTEMPT + 1` ; \
		sleep 1 ; \
	done ; \
	if [ $$RESULT -ne 0 ] ; \
	then \
	    exit 1 ; \
	fi
endef

.PHONY : init clean-docs clean build test dist publish

install_npm:
	@$(call install_npm_modules)

install_bower:
	@$(call install_bower_modules)

init: install_npm install_bower

docs:
	docco app/*.coffee

clean-docs:
	rm -rf docs/

clean: clean-docs
	rm -rf _public/*
	rm -rf node_modules
	rm -rf bower_components
	rm -rf release.tar.gz release/*

distclean: clean
	rm -rf bin/*
	npm cache clean
	bower cache clean

build: init
	node_modules/.bin/gulp --require coffee-script --server=false

package: build
	ls -1 _public | xargs tar -zcf release.tar.gz -C _public
	cp release.tar.gz release/${MODULE}-${DATESTAMP}-${GIT_HASH}.tar.gz
#	ls -1 _public | xargs tar -zcf release/${MODULE}-${DATESTAMP}-${GIT_HASH}.tar.gz -C _public

test:
#	@TODO This needs to be fixed.
#	@$(BIN)/karma start test/karma.conf.js

dist: clean init docs build test

spec:
	@echo "%define         deploy_user ${DEPLOY_USER}"  > ${SPEC_FILE}
	@echo "%define         deploy_group ${DEPLOY_GROUP}" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%define         name ${MODULE}" >> ${SPEC_FILE}
	@echo "%define         install_directory ${DEPLOY_TARGET}" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%define         summary \"${SUMMARY}\"" >> ${SPEC_FILE}
	@echo "%define         url http://g4plus.allegiantair.com" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "Name:		%{name}" >> ${SPEC_FILE}
	@echo "Version:	%{version}" >> ${SPEC_FILE}
	@echo "Release:	%{release}" >> ${SPEC_FILE}
	@echo "Summary:	%{summary}" >> ${SPEC_FILE}
	@echo "Group:		Applications/Internet" >> ${SPEC_FILE}
	@echo "License:	Proprietary" >> ${SPEC_FILE}
	@echo "URL:		%{url}" >> ${SPEC_FILE}

	@echo "Source0:	%{name}-%{version}.%{release}.tar.gz" >> ${SPEC_FILE}
	@echo "BuildArch:	noarch" >> ${SPEC_FILE}
	@echo "BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%description" >> ${SPEC_FILE}
	@echo "${DESCRIPTION}" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "Release is 2digit year_day of year_HH.MM" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%prep" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%build" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%install" >> ${SPEC_FILE}
	@echo "# This is prep stuff, but for some reason red hat wants to be lame and remove the" >> ${SPEC_FILE}
	@echo "# build root at the beginning of install" >> ${SPEC_FILE}
	@echo "mkdir -p \$$RPM_BUILD_ROOT/%{name}" >> ${SPEC_FILE}
	@echo "tar jxf \$$RPM_SOURCE_DIR/%{name}-%{version}.%{release}.tar.gz -C \$$RPM_BUILD_ROOT/%{name}" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "mkdir -p ${DEPLOY_TARGET_IN_RPM}" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "cp -R \$$RPM_BUILD_ROOT/%{name}/${TARGET}/* ${DEPLOY_TARGET_IN_RPM}" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "rm -rf \$$RPM_BUILD_ROOT/%{name}/" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%clean" >> ${SPEC_FILE}
	@echo "rm -rf \$$RPM_BUILD_ROOT" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%files" >> ${SPEC_FILE}
	@echo "%defattr(-, %{deploy_user}, %{deploy_group}, 0755)" >> ${SPEC_FILE}
	@echo "${DEPLOY_TARGET}/${TARGET}" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%post" >> ${SPEC_FILE}
	@echo "/etc/init.d/httpd stop && sleep 2" >> ${SPEC_FILE}
	@echo "/etc/init.d/httpd start && sleep 2" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%preun" >> ${SPEC_FILE}
	@echo "/etc/init.d/httpd stop && sleep 2" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}
	@echo "%postun" >> ${SPEC_FILE}
	@echo "/etc/init.d/httpd start && sleep 2" >> ${SPEC_FILE}
	@echo "" >> ${SPEC_FILE}

define rpm
	if [ ! -f $(SPEC_FILE) ]; then echo 'Unable to find RPM spec file [perhaps make spec?]... Bailing out!'; exit 2; fi ;

	$(eval VERSION := $(shell node -pe "require('./package.json').version")) 
	$(eval RPM_VERSION := `echo $(VERSION) | cut -d . -f 1`.`echo $(VERSION) | cut -d . -f 2`)
	$(eval RPM_RELEASE := `echo $(VERSION) | cut -d . -f 3`)
	$(eval TOP_DIR := `pwd -P`/rpm)
	$(eval RPM_LATEST := $(MODULE)-$(RPM_VERSION)-$(RPM_RELEASE).noarch.rpm)

	echo ">>> Baking RPM for version [$(VERSION)]" ; \

	rm -rf rpm ; \
	mkdir -p rpm/BUILD ; \
	mkdir -p rpm/BUILDROOT ; \
	mkdir -p rpm/RPMS ; \
	mkdir -p rpm/SOURCES ; \
	mkdir -p rpm/SPECS ; \
	mkdir -p rpm/SRPMS ; \

	cp $(SPEC_FILE) rpm/SPECS ;
	cp $(CURRENT_TARBALL) rpm/SOURCES ;

	eval "rpmbuild -bb rpm/SPECS/$(SPEC_FILE) --define \"version $(RPM_VERSION)\" --define \"release $(RPM_RELEASE)\" --define \"_topdir $(TOP_DIR)\"" ;
	cp ./rpm/RPMS/noarch/$(MODULE)-$(RPM_VERSION)-$(RPM_RELEASE).noarch.rpm ./archive

	cd release ; \
	rm -f latest.rpm && ln -s ../archive/$(RPM_LATEST) latest.rpm ; \

	echo ">>> DING! It's Done!" ;
endef

define release
	$(eval VERSION := $(shell node -pe "require('./package.json').version")) 
	$(eval NEXT_VERSION := $(shell node -pe "require('semver').inc(\"$(VERSION)\", '$(1)')"))
	$(eval PREVIOUS := $(MODULE)-$(VERSION).tar.gz)
	$(eval CURRENT := $(MODULE)-$(NEXT_VERSION).tar.gz)
	$(eval TAG_NAME := v$(NEXT_VERSION))

	echo Building Release Version [$(VERSION)] \-\> [$(NEXT_VERSION)] ; \

	node -e "\
		var j = require('./package.json');\
		j.version = \"$(NEXT_VERSION)\";\
		var s = JSON.stringify(j, null, 2);\
		require('fs').writeFileSync('./package.json', s);" ; \

	rm -rf build ; \
	mkdir -p build/$(TARGET) ; \
	cp -R _public/* build/$(TARGET)/ ; \
	mkdir -p release ; \
	mkdir -p archive ; \
	tar -C build -zcf archive/$(CURRENT) $(TARGET) ; \
	cd release ; \
	rm -f $(RELEASE_CURRENT) ; \
	ln -s ../archive/$(CURRENT) $(RELEASE_CURRENT) ; \

	if [ -e archive/$(PREVIOUS) ] ; \
	then \
		cd release ; \
		rm -f $(RELEASE_PREVIOUS) ; \
		ln -s ../archive/$(PREVIOUS) $(RELEASE_PREVIOUS) ; \
	fi ;

	echo Tagging repository with release '$(TAG_NAME)'
	git add ./package.json
	git commit -m "Package.json changes for $(TAG_NAME)"
	git push origin master
	git push origin :refs/tags/latest_release
	git tag -a $(TAG_NAME) -m "Tagging release $(TAG_NAME)"
	git tag -af latest_release -m "Floating latest release tag to most recently created release"
	git push origin master --tags
endef

define build_release
	$(eval VERSION := $(shell node -pe "require('./package.json').version")) 
	$(eval CURRENT := $(MODULE)-$(VERSION).tar.gz)

	echo Building CURRENT Release Version [$(VERSION)] ; \

	rm -rf build ; \
	mkdir -p build/$(TARGET) ; \
	cp -R _public/* build/$(TARGET)/ ; \
	mkdir -p release ; \
	mkdir -p archive ; \
	tar -C build -zcf archive/$(CURRENT) $(TARGET) ; \
	cd release ; \
	rm -f $(RELEASE_CURRENT) ; \
	ln -s ../archive/$(CURRENT) $(RELEASE_CURRENT) ; 
endef

define working_directory_clean
	git status | grep 'nothing to commit' > /dev/null ; \
	RESULT=$$? ; \
	if [ "$$RESULT" -ne  "0" ]; \
	then \
		echo 'Local branch has modifications.' ; \
		exit 3 ; \
	fi
endef

define check_master
	git status | grep 'master' > /dev/null ; \
	RESULT=$$? ; \
	if [ "$$RESULT" -ne  "0" ]; \
	then \
		echo 'Not on MASTER branch. No release being created for you.' ; \
		exit 2 ; \
	fi
endef

check_master:
	@$(call check_master)

working_directory_clean:
	@$(call working_directory_clean)

clean_release: distclean build test

release_prep: working_directory_clean check_master clean_release

release: current-release

current-release: clean_release
	@$(call build_release)

release-patch: release_prep
	@$(call release,patch)

release-minor: release_prep
	@$(call release,minor)

release-major: release_prep
	@$(call release,major)

rpm: test spec
	@$(call rpm)
