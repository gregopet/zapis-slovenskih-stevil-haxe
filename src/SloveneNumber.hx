/**
 * A formatter of numbers into Slovene words.
 */
@:keep
class SloveneNumber {

    // Hidden constructor since we don't need an instance
    @:protected private function new() {}

    @:protected private static var femaleNominativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "ena", "dve", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ]);
    
    @:protected private static var maleNominativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "en", "dva", "trije", "štirje", "pet", "šest", "sedem", "osem", "devet"
    ]);
    @:protected private static var neutralNominativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "eno", "dve", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ]);
    @:protected private static var nominativeOnes = haxe.ds.Vector.fromArrayCopy([ femaleNominativeOnes, maleNominativeOnes, neutralNominativeOnes ]);
    
    @:protected private static var femaleGenitiveOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "ene", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ]);
    @:protected private static var maleGenitiveOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enega", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ]);
    @:protected private static var neutralGenitiveOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enega", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ]);
    @:protected private static var genitiveOnes = haxe.ds.Vector.fromArrayCopy([ femaleGenitiveOnes, maleGenitiveOnes, neutralGenitiveOnes ]);
    
    @:protected private static var femaleDativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "eni", "dvema", "trem", "štirim", "petim", "šestim", "sedmim", "osmim", "devetim"
    ]);
    @:protected private static var maleDativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enemu", "dvema", "trem", "štirim", "petim", "šestim", "sedmim", "osmim", "devetim"
    ]);
    @:protected private static var neutralDativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enemu", "dvema", "trem", "štirim", "petim", "šestim", "sedmim", "osmim", "devetim"
    ]);
    @:protected private static var dativeOnes = haxe.ds.Vector.fromArrayCopy([ femaleDativeOnes, maleDativeOnes, neutralDativeOnes ]);
    
    @:protected private static var femaleAccusativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "eno", "dve", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ]);
    @:protected private static var maleAccusativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enega", "dva", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ]);
    @:protected private static var neutralAccusativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "eno", "dve", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ]);
    @:protected private static var accusativeOnes = haxe.ds.Vector.fromArrayCopy([ femaleAccusativeOnes, maleAccusativeOnes, neutralAccusativeOnes ]);


    @:protected private static var femaleLocativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "eni", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ]);
    @:protected private static var maleLocativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enem", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ]);
    @:protected private static var neutralLocativeOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enem", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ]);
    @:protected private static var locativeOnes = haxe.ds.Vector.fromArrayCopy([ femaleLocativeOnes, maleLocativeOnes, neutralLocativeOnes ]);
    
    
    @:protected private static var femaleInstrumentalOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "eno", "dvema", "tremi", "štirimi", "petimi", "šestimi", "sedmimi", "osmimi", "devetimi"
    ]);
    @:protected private static var maleInstrumentalOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enim", "dvema", "tremi", "štirimi", "petimi", "šestimi", "sedmimi", "osmimi", "devetimi"
    ]);
    @:protected private static var neutralInstrumentalOnes = haxe.ds.Vector.fromArrayCopy([
        "nič", "enim", "dvema", "tremi", "štirimi", "petimi", "šestimi", "sedmimi", "osmimi", "devetimi"
    ]);
    @:protected private static var instrumentalOnes = haxe.ds.Vector.fromArrayCopy([ femaleInstrumentalOnes, maleInstrumentalOnes, neutralInstrumentalOnes ]);
    
    
    @:protected private static var onesByCaseAndGender = haxe.ds.Vector.fromArrayCopy([
        nominativeOnes, genitiveOnes, dativeOnes, accusativeOnes, locativeOnes, instrumentalOnes
    ]);
    
    @:protected private static var nominativeTens = haxe.ds.Vector.fromArrayCopy([ 
        null, "deset", "dvajset", "trideset", "štirideset", "petdeset", "šestdeset", "sedemdeset", "osemdeset", "devetdeset" 
    ]);
    @:protected private static var tensSuffixPerCase = haxe.ds.Vector.fromArrayCopy([
        "", "ih", "im", "", "ih", "imi" 
    ]);
    @:protected private static var thousandsSuffixPerCase = haxe.ds.Vector.fromArrayCopy([
        "", "ih", "im", "", "ih", ""
    ]);
    @:protected private static var hundredsSuffixPerCase = haxe.ds.Vector.fromArrayCopy([
        "", "tih", "tim", "", "tih", "timi" 
    ]);
    
    /**
     * Formats the given number into Slovene words using the default form according to
     * the Slovene grammar which is female case nominative.
     * @param number The number to format into words
     */
    public static function formatDefault(number: Int): String {
        return format(number, Gender.Female, Case.Nominative);
    }
    
    /**
     * Formats the given number into Slovene words.
     * @param number The number to format into words
     * @param ofGender The grammatical gender to use for the created number
     * @param ofCase The grammatical case to use for the created number
     */
    public static function format(number: Int, ofGender: Gender, ofCase: Case): String {
        var genderIdx = switch(ofGender) {
            case Gender.Female: 0;
            case Gender.Male: 1;
            case Gender.Neutral: 2;
        }
        var caseIdx = switch(ofCase) {
            case Case.Nominative: 0;
            case Case.Genitive: 1;
            case Case.Dative: 2;
            case Case.Accusative: 3;
            case Case.Locative: 4;
            case Case.Instrumental: 5;
        }
        
        var withWords = billions(number, genderIdx, caseIdx);
        if (caseIdx == 5) {
            var firstLetter = withWords.charAt(0);
            if (firstLetter == 'p' || firstLetter == 's' || firstLetter == 't' || firstLetter == 'f' || firstLetter == 'h' || firstLetter == 'c' || firstLetter == 'k' || withWords.charCodeAt(0) == 197 || withWords.charCodeAt(0) == 196) {
                return "s " + withWords;
            } else {
                return "z " + withWords;
            }
        } else {
            return withWords;
        }
    }
    
    @:protected private static function ones(number: Int, genderIdx: Int, caseIdx: Int, pluralAccusativeOne: Bool): String {
        if (pluralAccusativeOne && number == 1 && (caseIdx == 0 || caseIdx == 3)) return "en";
        return onesByCaseAndGender[caseIdx][genderIdx][number % 10];
    }
    @:protected private static function tens(number: Int, genderIdx: Int, caseIdx: Int, pluralAccusativeOne: Bool): String {
        if (number < 10) return ones(number, genderIdx, caseIdx, pluralAccusativeOne);
        else if (number == 11) return "enajst" + tensSuffixPerCase[caseIdx];
        else {
            var ten = nominativeTens[Std.int((number % 100) / 10)];
            var one = number % 10;
            if (one == 0) {
                return ten + tensSuffixPerCase[caseIdx]; 
            } else {
                var oneString = (one == 2) ? "dva" : ones(one, 0, 0, pluralAccusativeOne);
                if (number < 20) {
                    return oneString + "najst" + tensSuffixPerCase[caseIdx];
                } else {
                    return oneString + "in" + ten + tensSuffixPerCase[caseIdx];
                }
            }
        }
    }
    @:protected private static function hundreds(number: Int, genderIdx: Int, caseIdx: Int, pluralAccusativeOne: Bool): String {
        if (number < 100) return tens(number, genderIdx, caseIdx, pluralAccusativeOne);
        else {
            var hundred = number % 100;
            var hundredString = (number < 200) ? "sto" : ones(Std.int(number / 100), 0, 0, pluralAccusativeOne) + "sto";
            
            if (hundred == 0) return hundredString + hundredsSuffixPerCase[caseIdx];
            else return hundredString + " " + tens(hundred, genderIdx, caseIdx, pluralAccusativeOne);
        }
    }
    @:protected private static function thousands(number: Int, genderIdx: Int, caseIdx: Int) {
        if (number < 1000) return hundreds(number, genderIdx, caseIdx, false);
        else {
            var thousand = number % 1000;
            var thousandString = 
                if (number < 2000) "tisoč"
                else if (number < 3000) "dva tisoč"
                else hundreds(Std.int(number / 1000), 0, 0, true) + " tisoč";
            
            if (thousand == 0) return thousandString + thousandsSuffixPerCase[caseIdx];
            else return thousandString + " " + hundreds(thousand, genderIdx, caseIdx, false);
        }
    }
    @:protected private static function millions(number: Int, genderIdx: Int, caseIdx: Int) {
        if (number < 1000000) return thousands(number, genderIdx, caseIdx);
        else {
            var million = number % 1000000;
            var millionsOnly = Std.int(number / 1000000);
            
            if (million == 0) {
                var prefix = (number < 2000000) ? "" : hundreds(millionsOnly, 1, caseIdx, true) + " ";
                return prefix + "milijon" + bigNumberSuffix(millionsOnly, caseIdx);
            } else {
                var prefix = (number < 2000000) ? "" : hundreds(millionsOnly, 1, caseIdx == 5 ? 5 : 0, true) + " ";
                return prefix + "milijon" + bigNumberSuffix(millionsOnly, caseIdx == 5 ? 5 : 0) + " " + thousands(million, genderIdx, caseIdx);
            }
        }
    }
    
    @:protected private static function billions(number: Int, genderIdx: Int, caseIdx: Int) {
        if (number < 1000000000) return millions(number, genderIdx, caseIdx);
        else {
            var billion = number % 1000000000;
            var billionsOnly = Std.int(number / 1000000000);
            
            if (billion == 0) {
                var prefix = (number < 2000000000) ? "" : hundreds(billionsOnly, 0, caseIdx, false) + " ";
                return prefix + "milijard" + billionNumberSuffix(billionsOnly, caseIdx);
            } else {
                var prefix = (number < 2000000000) ? "" : hundreds(billionsOnly, 0, 0, false) + " ";
                return prefix + "milijard" + billionNumberSuffix(billionsOnly, caseIdx == 5 ? 5 : 0) + " " + millions(billion, genderIdx, caseIdx);
            }
        }
    }
    
    @:protected private static var bigNumberSuffixes1 = haxe.ds.Vector.fromArrayCopy(["", "a", "u", "", "u", "om"]);
    @:protected private static var bigNumberSuffixes2 = haxe.ds.Vector.fromArrayCopy(["a", "ov", "oma", "a", "ih", "oma"]);
    @:protected private static var bigNumberSuffixes34 = haxe.ds.Vector.fromArrayCopy(["i", "ov", "om", "e", "ih", "i"]);
    @:protected private static var bigNumberSuffixesDefault = haxe.ds.Vector.fromArrayCopy(["ov", "ov", "om", "ov", "ih", "i"]);
    
    @:protected private static function bigNumberSuffix(number: Int, caseIdx: Int) {
        var modulo = number % 100;
        return switch (modulo) {
            case 1      : bigNumberSuffixes1[caseIdx];
            case 2      : bigNumberSuffixes2[caseIdx];
            case 3 | 4  : bigNumberSuffixes34[caseIdx];
            default     : bigNumberSuffixesDefault[caseIdx];
        }
    }
    
    
    @:protected private static var billionNumberSuffixes1 = haxe.ds.Vector.fromArrayCopy(["a", "e", "i", "o", "i", "o"]);
    @:protected private static var billionNumberSuffixes2 = haxe.ds.Vector.fromArrayCopy(["i", "", "ama", "i", "ah", "ama"]);
    @:protected private static var billionNumberSuffixes34 = haxe.ds.Vector.fromArrayCopy(["e", "", "am", "e", "ah", "ami"]);
    @:protected private static var billionNumberSuffixesDefault = haxe.ds.Vector.fromArrayCopy(["", "", "am", "", "ami", "ami"]);
    
    @:protected private static function billionNumberSuffix(number: Int, caseIdx: Int) {
        var modulo = number % 100;
        return switch (modulo) {
            case 1      : billionNumberSuffixes1[caseIdx];
            case 2      : billionNumberSuffixes2[caseIdx];
            case 3 | 4  : billionNumberSuffixes34[caseIdx];
            default     : billionNumberSuffixesDefault[caseIdx];
        }
    }
}
