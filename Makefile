# Makefile for spell-be

# Copyright (C) 2012-2023 Mikalai Udodau

# This work is licensed under the Creative Commons
# Attribution-ShareAlike 3.0 Unported License.
# To view a copy of this license, visit
# http://creativecommons.org/licenses/by-sa/3.0/
# or send a letter to Creative Commons,
# 171 Second Street, Suite 300, San Francisco,
# California, 94105, USA.

VERSION_NUMBER=$(shell echo $$(head -n2 hunspell-dic/be_BY.affixes | tail -n1 | cut -c19-))

all: dict-zip dict-xpi dict-oxt

dict: be_BY@tarask.aff be_BY@tarask.dic

# This target removes comments - all but 5 lines - from affix file
be_BY@tarask.aff:
	head -n 5 hunspell-dic/be_BY.affixes > be_BY@tarask.aff
	cut -d# -f1 hunspell-dic/be_BY.affixes \
	| tr -s ' ' ' ' | tr -s '\12' '\12' | tail -n+2 \
	>> be_BY@tarask.aff

# This target concatenates dictionary parts
# then counts words and put number in 1st line of dictionary
be_BY@tarask.dic:
	cat \
	hunspell-dic/chasc.dic \
	hunspell-dic/dzeeprym.dic \
	hunspell-dic/dzeeprysl.dic \
	hunspell-dic/dzejasl1.dic \
	hunspell-dic/dzejasl2.dic \
	hunspell-dic/lich.dic \
	hunspell-dic/naz.dic \
	hunspell-dic/naz1.dic \
	hunspell-dic/naz2.dic \
	hunspell-dic/naz3.dic \
	hunspell-dic/prym.dic \
	hunspell-dic/pryn.dic \
	hunspell-dic/prysl.dic \
	hunspell-dic/vykl.dic \
	hunspell-dic/zajm.dic \
	hunspell-dic/zluchn.dic \
	hunspell-dic/ext-chim.dic \
	hunspell-dic/ext-dzeeprym.dic \
	hunspell-dic/ext-dzejasl1.dic \
	hunspell-dic/ext-dzejasl2.dic \
	hunspell-dic/ext-naz.dic \
	hunspell-dic/ext-naz1.dic \
	hunspell-dic/ext-naz2.dic \
	hunspell-dic/ext-naz3.dic \
	hunspell-dic/ext-prym.dic \
	hunspell-dic/ext-pryn.dic \
	hunspell-dic/ext-prysl.dic \
	hunspell-dic/ext-zajm.dic \
	hunspell-dic/geagraph.dic \
	hunspell-dic/im1.dic \
	hunspell-dic/im2.dic \
	hunspell-dic/najm.dic \
	hunspell-dic/prozv.dic \
	hunspell-dic/pryst.dic \
	hunspell-dic/sk.dic \
	| sort | uniq > be_BY.dictionary
	cat be_BY.dictionary | wc -l > be_BY@tarask.dic
	cat be_BY.dictionary >> be_BY@tarask.dic && rm be_BY.dictionary

dict-zip: dict
	zip -rq hunspell-be-tarask-$(VERSION_NUMBER).zip be_BY@tarask.aff be_BY@tarask.dic

dict-xpi: dict
	cp be_BY@tarask.aff be_BY@tarask.dic dictionaries/
	sed -i \
	's/\"version\": \"[[:graph:]]*\.1w/\"version\": \"$(VERSION_NUMBER)\.1w/' \
	manifest.json
	zip -rq spell-be-tarask-$(VERSION_NUMBER)-2.xpi \
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
	spell-be-tarask-$(VERSION_NUMBER).1.xpi \
	dict-be-tarask-$(VERSION_NUMBER).oxt

.PHONY: clean rpm
