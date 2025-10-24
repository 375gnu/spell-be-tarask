# Makefile for spell-be-tarask. Requires GNU Make.
#
# Copyright (C) 2012-2023 Mikalai Udodau, 2025 Hleb Valoshka
#
# This work is licensed under the Creative Commons
# Attribution-ShareAlike 3.0 Unported License.
# To view a copy of this license, visit
# http://creativecommons.org/licenses/by-sa/3.0/
# or send a letter to Creative Commons,
# 171 Second Street, Suite 300, San Francisco,
# California, 94105, USA.

VERSION_NUMBER := $(shell git describe --tags | tr -d v)
XPI_BUILD      := 1
SOURCES        := $(wildcard src/*.dic)

build_$(VERSION_NUMBER).lock:
	touch $@

# This target removes comments - all but 5 lines - from affix file
be_BY@tarask.aff: src/be_BY.affixes
	head -n 5 src/be_BY.affixes | sed 's/@VERSION@/$(VERSION_NUMBER)/' > $@
	cut -d# -f1 src/be_BY.affixes | tr -s ' ' ' ' | tr -s '\12' '\12' | tail -n+2 >> $@

# This target concatenates dictionary parts
# then counts words and put number in 1st line of dictionary
be_BY@tarask.dic: $(SOURCES)
	cat $(SOURCES) | sort -u > be_BY.dictionary
	cat be_BY.dictionary | wc -l > $@
	cat be_BY.dictionary >> $@
	rm be_BY.dictionary

hunspell-be-tarask-$(VERSION_NUMBER).zip: be_BY@tarask.aff be_BY@tarask.dic
	zip -rq $@ $^

hunspell-be-tarask-bdic-$(VERSION_NUMBER).zip: qtwebengine_dictionaries/be_BY@tarask.bdic
	zip -rq $@ $^

manifest.json: manifest.json.in build_$(VERSION_NUMBER).lock
	sed 's/@VERSION@/$(VERSION_NUMBER)/' < $< > $@

dictionaries/be_BY@tarask.aff: be_BY@tarask.aff
	cp $< $@

dictionaries/be_BY@tarask.dic: be_BY@tarask.dic
	cp $< $@

spell-be-tarask-$(VERSION_NUMBER)-$(XPI_BUILD).xpi: dictionaries/be_BY@tarask.aff dictionaries/be_BY@tarask.dic manifest.json
	zip -rq $@ $^ dictionaries/README_be_BY.txt

description.xml: description.xml.in build_$(VERSION_NUMBER).lock
	sed 's/@VERSION@/$(VERSION_NUMBER)/' < $< > $@

dict-be-tarask-$(VERSION_NUMBER).oxt: be_BY@tarask.aff be_BY@tarask.dic description.xml
	zip -rq $@ $^  META-INF/manifest.xml README_spell_be_BY.txt dictionaries.xcu

qtwebengine_dictionaries:
	mkdir qtwebengine_dictionaries

qtwebengine_dictionaries/be_BY@tarask.bdic: be_BY@tarask.dic be_BY@tarask.aff qtwebengine_dictionaries
	convert-bdic $< $@

wordlist: be_BY@tarask.aff be_BY@tarask.dic
	hunaftool -i=dic -o=csv $^ $@

rpm:
	rpmbuild -v -bb --build-in-place hunspell-be-tarask.spec

clean:
	rm -rf be_BY@tarask.aff be_BY@tarask.dic \
	be_BY@tarask.bdic \
	hunspell-be-tarask-$(VERSION_NUMBER).zip \
	hunspell-be-tarask-bdic-$(VERSION_NUMBER).zip \
	dictionaries/be_BY@tarask.aff \
	dictionaries/be_BY@tarask.dic \
	spell-be-tarask-$(VERSION_NUMBER)-$(XPI_BUILD).xpi \
	dict-be-tarask-$(VERSION_NUMBER).oxt \
	description.xml \
	manifest.json \
	qtwebengine_dictionaries \
	build_$(VERSION_NUMBER).lock

# useful aliases

oxt: dict-be-tarask-$(VERSION_NUMBER).oxt
xpi: spell-be-tarask-$(VERSION_NUMBER)-$(XPI_BUILD).xpi
bdic: qtwebengine_dictionaries/be_BY@tarask.bdic
bdic-zip: hunspell-be-tarask-bdic-$(VERSION_NUMBER).zip
zip: hunspell-be-tarask-$(VERSION_NUMBER).zip
dict: be_BY@tarask.aff be_BY@tarask.dic
all: zip xpi oxt bdic-zip

.PHONY: clean rpm
