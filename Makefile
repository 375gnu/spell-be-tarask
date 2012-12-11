# Makefile for spell-be

# Copyright (C) 2012 Mikalai Udodau

# This work is licensed under the Creative Commons
# Attribution-ShareAlike 3.0 Unported License.
# To view a copy of this license, visit
# http://creativecommons.org/licenses/by-sa/3.0/
# or send a letter to Creative Commons,
# 171 Second Street, Suite 300, San Francisco,
# California, 94105, USA.

dict: be_BY.aff be_BY.dic

# This target removes comments - all but 5 lines - from affix file
be_BY.aff:
	head -n 5 hunspell-dic/be_BY.affixes > be_BY.aff
	cut -d# -f1 hunspell-dic/be_BY.affixes \
	| tr -s ' ' ' ' | tr -s '\12' '\12' | tail -n+2 \
	>> be_BY.aff

# This target concatenate dictionary parts
# then counts words and put number in 1st line of dictionary
be_BY.dic:
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
	hunspell-dic/ext-dzeeprym.dic \
	hunspell-dic/ext-dzejasl1.dic \
	hunspell-dic/ext-dzejasl2.dic \
	hunspell-dic/ext-naz.dic \
	hunspell-dic/ext-naz1.dic \
	hunspell-dic/ext-naz2.dic \
	hunspell-dic/ext-naz3.dic \
	hunspell-dic/ext-prym.dic \
	hunspell-dic/ext-prysl.dic \
	hunspell-dic/geagraph.dic \
	hunspell-dic/im1.dic \
	hunspell-dic/im2.dic \
	hunspell-dic/najm.dic \
	hunspell-dic/prozv.dic \
	hunspell-dic/pryst.dic \
	hunspell-dic/sk.dic \
	| sort | uniq > be_BY.dictionary
	cat be_BY.dictionary | wc -l > be_BY.dic
	cat be_BY.dictionary >> be_BY.dic && rm be_BY.dictionary

dict-zip: dict
	zip -rq hunspell-be.zip be_BY.aff be_BY.dic

clean :
	rm be_BY.aff be_BY.dic
