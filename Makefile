SUBTREE_REPO_NAME := fish-shell
SUBTREE_REPO_URL := git@github.com:fish-shell/$(SUBTREE_REPO_NAME).git

TEMP_DIR := $(shell mktemp -d 2>/dev/null || mktemp -d -t 'temp')

build: fish.tgz

fish.tgz: fish.docset
	tar --exclude='.DS_Store' -cvzf fish.tgz fish.docset

fish.docset: stripped_html
	dashing build --source html fish

stripped_html: HTML_FILES = $(shell find html -name "*.html")
stripped_html: html
	@for file in $(HTML_FILES); do \
		perl -0777 -i -pe 's/<div.+role="navigation".*>(?s:.)*?<\/div>//g' $$file; \
		perl -0777 -i -pe 's/<div.+role="contentinfo".*>(?s:.)*?<\/div>//g' $$file; \
	done

html:
	sphinx-build -b html source html
	rm -f html/genindex.html html/search.html

fetch_subtree:
	@git clone $(SUBTREE_REPO_URL) $(TEMP_DIR); \
	cd $(TEMP_DIR); \
	git filter-repo --paths-from-file $(CURDIR)/$(SUBTREE_REPO_NAME).gitfilter
	git remote add $(SUBTREE_REPO_NAME) file://$(TEMP_DIR)
	git fetch --no-tags $(SUBTREE_REPO_NAME) master:$(SUBTREE_REPO_NAME)
	git remote rm $(SUBTREE_REPO_NAME)
	rm -rf $(TEMP_DIR)

clean:
	rm -f fish.tgz
	rm -rf fish.docset
	rm -rf html

.PHONY:
	build stripped_html fetch_subtree clean
