APIFILEPATH=docs/api/v1/
APIFILES=README.md general.md cache_option.md node.md node_state.md storage.md storage_type.md virt_method.md virt_node.md vm.md vm_state.md
PANDOC?=$(HOME)/.cabal/bin/pandoc
BUILDDIR=build

all: clean virtapi.pdf

$(APIFILES): %: setup
	cp $(APIFILEPATH)$@ $(BUILDDIR)/$@
	sed --in-place '1s|^|\\newpage\n\n|' $(BUILDDIR)/$@
	cat $(BUILDDIR)/$@ >> $(BUILDDIR)/SECOND.md

setup:
	mkdir -p $(BUILDDIR)

virtapi.pdf: $(APIFILES)
	cp README.md $(BUILDDIR)/FIRST.md
	cp CONTRIBUTING.md $(BUILDDIR)/
	sed --in-place --expression 's|database/images/virtapi.svg|https://cdn.rawgit.com/virtapi/virtapi/46b9e93942d65e7ca91f10b4602edb26917bb78c/database/images/virtapi.svg|' $(BUILDDIR)/FIRST.md
	sed --in-place --expression '/#links-and-sources.*/a \+ [API Call Documentation](#api-call-documentation)' $(BUILDDIR)/FIRST.md
	sed --in-place --regexp-extended 's/(#{1,3})/\1#/g' $(BUILDDIR)/CONTRIBUTING.md
	sed --in-place --expression '/## contribution/{r CONTRIBUTING.md' --expression 'd}' $(BUILDDIR)/FIRST.md
	$(PANDOC) -f markdown_github+raw_tex -V documentclass=scrartcl -o $(BUILDDIR)/virtapi.pdf $(BUILDDIR)/FIRST.md $(BUILDDIR)/SECOND.md

clean:
	rm -rf build

.PHONY: clean all