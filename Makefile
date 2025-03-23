# Makefile for spell-be

# Copyright (C) 2012-2023 Mikalai Udodau

# This work is licensed under the Creative Commons
# Attribution-ShareAlike 3.0 Unported License.
# To view a copy of this license, visit
# http://creativecommons.org/licenses/by-sa/3.0/
# or send a letter to Creative Commons,
# 171 Second Street, Suite 300, San Francisco,
# California, 94105, USA.

VERSION_NUMBER=$(shell grep -F Version: src/be_BY.affixes | cut -f2 -d: | tr -d ' ')
XPI_BUILD=1

SOURCES=src/chasc.dic \
        src/dzeeprym.dic \
        src/dzeeprysl.dic \
        src/dzejasl1.dic \
        src/dzejasl2.dic \
        src/lich.dic \
        src/naz.dic \
        src/naz1.dic \
        src/naz2.dic \
        src/naz3.dic \
        src/prym.dic \
        src/pryn.dic \
        src/prysl.dic \
        src/vykl.dic \
        src/zajm.dic \
        src/zluchn.dic \
        src/ext-chim.dic \
        src/ext-dzeeprym.dic \
        src/ext-dzejasl1.dic \
        src/ext-dzejasl2.dic \
        src/ext-naz.dic \
        src/ext-naz1.dic \
        src/ext-naz2.dic \
        src/ext-naz3.dic \
        src/ext-prym.dic \
        src/ext-pryn.dic \
        src/ext-prysl.dic \
        src/ext-zajm.dic \
        src/geagraph.dic \
        src/im1.dic \
        src/im2.dic \
        src/najm.dic \
        src/prozv.dic \
        src/pryst.dic \
        src/sk.dic

all: dict-zip dict-xpi dict-oxt

dict: be_BY@tarask.aff be_BY@tarask.dic

# This target removes comments - all but 5 lines - from affix file
be_BY@tarask.aff: src/be_BY.affixes
	head -n 5 src/be_BY.affixes > be_BY@tarask.aff
	cut -d# -f1 src/be_BY.affixes \
	| tr -s ' ' ' ' | tr -s '\12' '\12' | tail -n+2 \
	>> be_BY@tarask.aff

# This target concatenates dictionary parts
# then counts words and put number in 1st line of dictionary
be_BY@tarask.dic: $(SOURCES)
	cat $(SOURCES) | sort -u > be_BY.dictionary
	cat be_BY.dictionary | wc -l > be_BY@tarask.dic
	cat be_BY.dictionary >> be_BY@tarask.dic && rm be_BY.dictionary

dict-zip: dict
	zip -rq hunspell-be-tarask-$(VERSION_NUMBER).zip be_BY@tarask.aff be_BY@tarask.dic

dict-xpi: dict
	cp be_BY@tarask.aff be_BY@tarask.dic dictionaries/
	sed -i \
	's/\"version\": \"[[:graph:]]*\.1w/\"version\": \"$(VERSION_NUMBER)\.1w/' \
	manifest.json
	zip -rq spell-be-tarask-$(VERSION_NUMBER)-$(XPI_BUILD).xpi \
	manifest.json \
	dictionaries/be_BY@tarask.aff dictionaries/be_BY@tarask.dic \
	dictionaries/README_be_BY.txt

dict-oxt: dict
	sed -i \
	's/<version value=\"[[:graph:]]*\"/<version value=\"$(VERSION_NUMBER)\"/' \
	description.xml
	zip -rq dict-be-tarask-$(VERSION_NUMBER).oxt \
	META-INF/manifest.xml README_spell_be_BY.txt \
	be_BY@tarask.aff be_BY@tarask.dic description.xml dictionaries.xcu

rpm:
	rpmbuild -v -bb --build-in-place hunspell-be-tarask.spec

clean:
	rm -f be_BY@tarask.aff be_BY@tarask.dic hunspell-be-tarask-$(VERSION_NUMBER).zip \
	dictionaries/be_BY@tarask.aff dictionaries/be_BY@tarask.dic \
	spell-be-tarask-$(VERSION_NUMBER)-$(XPI_BUILD).xpi \
	dict-be-tarask-$(VERSION_NUMBER).oxt

.PHONY: clean rpm
