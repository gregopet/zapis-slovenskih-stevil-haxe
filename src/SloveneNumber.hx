class SloveneNumber {

    private static var femaleNominativeOnes = [
        "nič", "ena", "dve", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ];
    private static var maleNominativeOnes = [
        "nič", "en", "dva", "trije", "štirje", "pet", "šest", "sedem", "osem", "devet"
    ];
    private static var neutralNominativeOnes = [
        "nič", "eno", "dve", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ];
    private static var nominativeOnes = [ femaleNominativeOnes, maleNominativeOnes, neutralNominativeOnes ];
    
    private static var femaleGenitiveOnes = [
        "nič", "ene", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ];
    private static var maleGenitiveOnes = [
        "nič", "enega", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ];
    private static var neutralGenitiveOnes = [
        "nič", "enega", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ];
    private static var genitiveOnes = [ femaleGenitiveOnes, maleGenitiveOnes, neutralGenitiveOnes ];
    
    private static var femaleDativeOnes = [
        "nič", "eni", "dvema", "trem", "štirim", "petim", "šestim", "sedmim", "osmim", "devetim"
    ];
    private static var maleDativeOnes = [
        "nič", "enemu", "dvema", "trem", "štirim", "petim", "šestim", "sedmim", "osmim", "devetim"
    ];
    private static var neutralDativeOnes = [
        "nič", "enemu", "dvema", "trem", "štirim", "petim", "šestim", "sedmim", "osmim", "devetim"
    ];
    private static var dativeOnes = [ femaleDativeOnes, maleDativeOnes, neutralDativeOnes ];
    
    private static var femaleAccusativeOnes = [
        "nič", "eno", "dve", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ];
    private static var maleAccusativeOnes = [
        "nič", "enega", "dva", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ];
    private static var neutralAccusativeOnes = [
        "nič", "eno", "dve", "tri", "štiri", "pet", "šest", "sedem", "osem", "devet"
    ];
    private static var accusativeOnes = [ femaleAccusativeOnes, maleAccusativeOnes, neutralAccusativeOnes ];


    private static var femaleLocativeOnes = [
        "nič", "eni", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ];
    private static var maleLocativeOnes = [
        "nič", "enem", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ];
    private static var neutralLocativeOnes = [
        "nič", "enem", "dveh", "treh", "štirih", "petih", "šestih", "sedmih", "osmih", "devetih"
    ];
    private static var locativeOnes = [ femaleLocativeOnes, maleLocativeOnes, neutralLocativeOnes ];
    
    
    private static var femaleInstrumentalOnes = [
        "nič", "eno", "dvema", "tremi", "štirimi", "petimi", "šestimi", "sedmimi", "osmimi", "devetimi"
    ];
    private static var maleInstrumentalOnes = [
        "nič", "enim", "dvema", "tremi", "štirimi", "petimi", "šestimi", "sedmimi", "osmimi", "devetimi"
    ];
    private static var neutralInstrumentalOnes = [
        "nič", "enim", "dvema", "tremi", "štirimi", "petimi", "šestimi", "sedmimi", "osmimi", "devetimi"
    ];
    private static var instrumentalOnes = [ femaleInstrumentalOnes, maleInstrumentalOnes, neutralInstrumentalOnes ];
    
    
    private static var onesByCaseAndGender = [
        nominativeOnes, genitiveOnes, dativeOnes, accusativeOnes, locativeOnes, instrumentalOnes
    ];
    
    private static var nominativeTens = [ null, "deset", "dvajset", "trideset", "štirideset", "petdeset", "šestdeset", "sedemdeset", "osemdeset", "devetdeset" ];
    private static var tensSuffixPerCase = ["", "ih", "im", "", "ih", "imi" ];
    private static var thousandsSuffixPerCase = ["", "ih", "im", "", "ih", "" ];
    private static var hundredsSuffixPerCase = ["", "tih", "tim", "", "tih", "timi" ];
    
    public static function formatDefault(number: Int): String {
        return format(number, Gender.Female, Case.Nominative);
    }
    
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
    
    private static function ones(number: Int, genderIdx: Int, caseIdx: Int, pluralAccusativeOne: Bool): String {
        if (pluralAccusativeOne && number == 1 && (caseIdx == 0 || caseIdx == 3)) return "en";
        return onesByCaseAndGender[caseIdx][genderIdx][number % 10];
    }
    private static function tens(number: Int, genderIdx: Int, caseIdx: Int, pluralAccusativeOne: Bool): String {
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
    private static function hundreds(number: Int, genderIdx: Int, caseIdx: Int, pluralAccusativeOne: Bool): String {
        if (number < 100) return tens(number, genderIdx, caseIdx, pluralAccusativeOne);
        else {
            var hundred = number % 100;
            var hundredString = (number < 200) ? "sto" : ones(Std.int(number / 100), 0, 0, pluralAccusativeOne) + "sto";
            
            if (hundred == 0) return hundredString + hundredsSuffixPerCase[caseIdx];
            else return hundredString + " " + tens(hundred, genderIdx, caseIdx, pluralAccusativeOne);
        }
    }
    private static function thousands(number: Int, genderIdx: Int, caseIdx: Int) {
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
    private static function millions(number: Int, genderIdx: Int, caseIdx: Int) {
        if (number < 1000000) return thousands(number, genderIdx, caseIdx);
        else {
            var million = number % 1000000;
            var millionsOnly = Std.int(number / 1000000);
            
            if (million == 0) {
                var prefix = (number < 2000000) ? "" : hundreds(millionsOnly, 1, caseIdx, true) + " ";
                return prefix + "milijon" + bigNumberSuffix(millionsOnly, 0, caseIdx);
            } else {
                var prefix = (number < 2000000) ? "" : hundreds(millionsOnly, 1, caseIdx == 5 ? 5 : 0, true) + " ";
                return prefix + "milijon" + bigNumberSuffix(millionsOnly, 1, caseIdx == 5 ? 5 : 0) + " " + thousands(million, genderIdx, caseIdx);
            }
        }
    }
    
    private static function billions(number: Int, genderIdx: Int, caseIdx: Int) {
        if (number < 1000000000) return millions(number, genderIdx, caseIdx);
        else {
            var billion = number % 1000000000;
            var billionsOnly = Std.int(number / 1000000000);
            
            if (billion == 0) {
                var prefix = (number < 2000000000) ? "" : hundreds(billionsOnly, 0, caseIdx, false) + " ";
                return prefix + "milijard" + billionNumberSuffix(billionsOnly, 0, caseIdx);
            } else {
                var prefix = (number < 2000000000) ? "" : hundreds(billionsOnly, 0, 0, false) + " ";
                return prefix + "milijard" + billionNumberSuffix(billionsOnly, 1, caseIdx == 5 ? 5 : 0) + " " + millions(billion, genderIdx, caseIdx);
            }
        }
    }
    
    private static function bigNumberSuffix(number: Int, genderIdx: Int, caseIdx: Int) {
        var modulo = number % 100;
        return switch (modulo) {
            case 1      : ["", "a", "u", "", "u", "om"][caseIdx];
            case 2      : ["a", "ov", "oma", "a", "ih", "oma"][caseIdx];
            case 3 | 4  : ["i", "ov", "om", "e", "ih", "i"][caseIdx];
            default     : ["ov", "ov", "om", "ov", "ih", "i"][caseIdx];
        }
    }
    
    private static function billionNumberSuffix(number: Int, genderIdx: Int, caseIdx: Int) {
        var modulo = number % 100;
        return switch (modulo) {
            case 1      : ["a", "e", "i", "o", "i", "o"][caseIdx];
            case 2      : ["i", "", "ama", "i", "ah", "ama"][caseIdx];
            case 3 | 4  : ["e", "", "am", "e", "ah", "ami"][caseIdx];
            default     : ["", "", "am", "", "ami", "ami"][caseIdx];
        }
    }
}
