MECAB_DICT_INDEX	= /usr/local/libexec/mecab/mecab-dict-index
MECAB_DIC_DIR		= /usr/local/lib/mecab/dic/ipadic

WIKI_SOURCE		= https://dumps.wikimedia.org/jawiki/latest/jawiki-latest-all-titles-in-ns0.gz
HATENA_SOURCE	= http://d.hatena.ne.jp/images/keyword/keywordlist_furigana.csv

WIKI_ARCHIVE	= $(WIKI_TEXT).gz
WIKI_TEXT		= jawiki-titles
WIKI_CSV		= $(WIKI_TEXT).csv
WIKI_DIC		= $(WIKI_TEXT).dic

HATENA_TEXT		= hatena-words
HATENA_CSV		= $(HATENA_TEXT).csv
HATENA_DIC		= $(HATENA_TEXT).dic

all : wiki hatena

clean : clean-wiki clean-hatena


wiki : $(WIKI_DIC)

clean-wiki :
	rm -f $(WIKI_ARCHIVE) $(WIKI_TEXT) $(WIKI_CSV) $(WIKI_DIC)

$(WIKI_ARCHIVE)	:
	wget $(WIKI_SOURCE) -O $(WIKI_ARCHIVE)

$(WIKI_TEXT)	: $(WIKI_ARCHIVE)
	gzip -d $(WIKI_ARCHIVE)

$(WIKI_CSV)		: $(WIKI_TEXT)
	perl wiki.pl $(WIKI_TEXT) $(WIKI_CSV)

$(WIKI_DIC)		: $(WIKI_CSV)
	$(MECAB_DICT_INDEX) -d $(MECAB_DIC_DIR) -u $(WIKI_DIC) -f utf8 -t utf8 $(WIKI_CSV)


hatena : $(HATENA_DIC)

clean-hatena :
	rm -f $(HATENA_TEXT) $(HATENA_CSV) $(HATENA_DIC)

$(HATENA_TEXT)	:
	wget $(HATENA_SOURCE) -O $(HATENA_TEXT)

$(HATENA_CSV)	: $(HATENA_TEXT)
	perl hatena.pl $(HATENA_TEXT) $(HATENA_CSV)

$(HATENA_DIC)	: $(HATENA_CSV)
	$(MECAB_DICT_INDEX) -d $(MECAB_DIC_DIR) -u $(HATENA_DIC) -f utf8 -t utf8 $(HATENA_CSV)

