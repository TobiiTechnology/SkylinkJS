ifeq (,$(wildcard support-firecloud/Makefile))
INSTALL_SUPPORT_FIRECLOUD := $(shell git submodule update --init --recursive support-firecloud)
ifneq (,$(filter undefine,$(.FEATURES)))
undefine INSTALL_SUPPORT_FIRECLOUD
endif
endif

include support-firecloud/repo/mk/core.common.mk
include support-firecloud/repo/mk/js.deps.npm.mk
include support-firecloud/repo/mk/generic.misc.merge-upstream.mk

# ------------------------------------------------------------------------------

SF_BUILD_TARGETS := \
	$(SF_BUILD_TARGETS) \
	build-grunt \

# SF_CHECK_TARGETS := \
# 	$(SF_CHECK_TARGETS) \
# 	check-grunt \

GRUNT = $(call which,GRUNT,grunt)

# ------------------------------------------------------------------------------

.PHONY: build-grunt
build-grunt:
	$(GRUNT) dev
	$(GRUNT) publish


.PHONY: check-grunt
check-grunt:
	$(GRUNT) jshint
