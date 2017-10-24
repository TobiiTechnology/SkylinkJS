# Minimal version that works like support-firecloud/repo/Makefile.pkg.node.mk
#
# how to publish: make nuke all publish/0.6.17-tobii.1
#
# how to merge upstream tag: make merge/0.6.18

MAKEFLAGS += -s

LAST_PUBLISH_COMMIT=$(shell git log -1 --grep "^publish\|^Revert \"publish" --format="%h")

.PHONY: all
all: deps build


.PHONY: deps
deps:
	npm install --no-package-lock


.PHONY: build
build:
	node_modules/.bin/grunt publish
	git checkout HEAD -- doc publish # intended
	git clean -xdf doc publish # intended


.PHONY: nuke
nuke:
	git reset
	git stash --all


.PHONY: publish/%
publish/%: revert-last-publish
	node_modules/.bin/grunt publish
	git add doc publish
	git commit -m "publish ${*}"
	node_modules/.bin/npm-publish-git --tag ${*}


.PHONY: revert-last-publish
revert-last-publish:
	[ -n "$(LAST_PUBLISH_COMMIT)" ] && { \
		git log -1 "$(LAST_PUBLISH_COMMIT)"; \
		git log -1 --format="%s" "$(LAST_PUBLISH_COMMIT)" | grep -q "^Revert \"publish" && { \
			echo "Skipping. $(LAST_PUBLISH_COMMIT) is already a revert commit."; \
		} || { \
			echo "Reverting $(LAST_PUBLISH_COMMIT)..."; \
			git revert --no-edit ${LAST_PUBLISH_COMMIT}; \
		} \
	} || { \
		echo "No publish commit."; \
	}


.PHONY: merge/%
merge/%:
	git fetch --tags
	git merge --no-ff ${*}


.PHONY: help
help:
	cat Makefile | grep "^#"
