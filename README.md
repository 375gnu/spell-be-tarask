Слоўнік правяраць артаграфію беларускае мовы (клясычны правапіс 2005 году) у фармаце Hunspell.

Асаблівасьці:

* асэнсаваныя прапановы для найбольш пашыраных памылак
* кампактны памер за кошт ужываньня афіксаў для ўсіх зьменных часьцін мовы

Усталяваньне:

Усе пералічаныя тут файлы трэба загружаць з [github](https://github.com/375gnu/spell-be-tarask/releases). Замяніце `${version}` на патрэбную вэрсію, напрыклад, `0.63`.

Калі маеце *Debian*, або сыстэму на ягонай базе (*Devuan*, *Ubuntu*, *Mint* і т.п.), то трэба ўсталяваць адзін з файлаў `deb`:

* `hunspell-be-tarask_${version}_all.deb` — асноўная вэрсія. Канфліктуе з `hunspell-be`, бо дадае спасылкі `be_BY@tarask.aff->be_BY.aff` і `be_BY@tarask.dic->be_BY.dic`.
* `hunspell-be-tarask-alt_${version}_all.deb` — альтэрнатыўны пакет, не дадае спасылак `be_BY.aff` ды `be_BY.dic`, таму можа суіснаваць разам з `hunspell-be`.

Калі ж маеце іншую сыстэму, у тым ліку *Windows* або *macOS*, то можна ўсталяваць наступныя пакеты:

* `hunspell-be-tarask-${version}.zip` — распакуйце архіў у каталёгу зь іншымі слоўнікамі `hunspell`, напрыклад: `cd /usr/share/hunspell/ && unzip hunspell-be-tarask-${version}.zip`.
* `hunspell-be-tarask-bdic-${version}.zip` — двайковы слоўнік для праграм на базе *QtWebEngine* (*Falkon* і т. п.). Распакуйце ў каталёг, дзе ўсталявана праграма.
* `dict-be-tarask-${version}.oxt` — файл для *LibreOffice*, усталяваньне праз *Tools->Extension Manager*.
* `spell-be-tarask-${version}-1.xpi` — файл для *Mozilla Firefox*, усталяваньне праз *File->Open File…*.

---

Dictionary to check spelling of the Belarusian language (classic orthography, 2005 ed.) in Hunspell format.

Features:

* smart suggestions for most typical misspell
* affixes for nouns, adjectives, and verbs

Installation:

All files listed here should be downloaded from [github](https://github.com/375gnu/spell-be-tarask/releases). Replace `${version}` with a required version, e.g. with `0.63`.

If you have *Debian* or a system on its base (*Devuan*, *Ubuntu*, *Mint*, etc), then you need to install one of `deb` files:

* `hunspell-be-tarask_${version}_all.deb` — base version. Conflicts with `hunspell-be`, as it adds links `be_BY@tarask.aff->be_BY.aff` and `be_BY@tarask.dic->be_BY.dic`.
* `hunspell-be-tarask-alt_${version}_all.deb` — alternative package that doesn't add links `be_BY.aff` and `be_BY.dic`, so it can co-exist with `hunspell-be`.

If you have another system, including *Windows* or *macOS*, then you can install the following packages:

* `hunspell-be-tarask-${version}.zip` — unpack it into the directory with other `hunspell` dictionaries, e.g.: `cd /usr/share/hunspell/ && unzip hunspell-be-tarask-${version}.zip`.
* `hunspell-be-tarask-bdic-${version}.zip` — binary dictionary for *QtWebEngine*-based applications (*Falkon* and so on). Unpack to the application directory.
* `dict-be-tarask-${version}.oxt` — file for *LibreOffice*, install via *Tools->Extension Manager*.
* `spell-be-tarask-${version}-1.xpi` — file for *Mozilla Firefox*, install via *File->Open File…*.
