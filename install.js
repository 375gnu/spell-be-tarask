var name = "spell-be.sourceforge.net";
var err = initInstall("Belarusian spellcheck dictionary", name, "0.54");
if (err != SUCCESS)
    cancelInstall();

var fProgram = getFolder("Program");
err = addDirectory("", name, "dictionaries", fProgram, "dictionaries", true);
if (err != SUCCESS)
    cancelInstall();

performInstall();
