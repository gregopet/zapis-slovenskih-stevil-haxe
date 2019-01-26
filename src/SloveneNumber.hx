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
    
    private static var nominativeTens = [ null, "deset", "dvajset", "trideset", "štirideset", "petdeset", "šestdeset", "sedemdeset", "osemdeset", "devetdeset" ];
    
    
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
        
        return billions(number, genderIdx, caseIdx);
    }
    
    private static function ones(number: Int, genderIdx: Int, caseIdx: Int): String {
        return nominativeOnes[genderIdx][number % 10];
    }
    private static function tens(number: Int, genderIdx: Int, caseIdx: Int): String {
        if (number < 10) return ones(number, genderIdx, caseIdx);
        else if (number == 11) return "enajst";
        else {
            var ten = nominativeTens[Std.int((number % 100) / 10)];
            var one = number % 10;
            if (one == 0) return ten; else {
                var oneString = (one == 2) ? "dva" : ones(one, 0, 0);
                if (number < 20) {
                    return oneString + "najst";
                } else {
                    return oneString + "in" + ten;
                }
            }
        }
    }
    private static function hundreds(number: Int, genderIdx: Int, caseIdx: Int): String {
        if (number < 100) return tens(number, genderIdx, caseIdx);
        else {
            var hundred = number % 100;
            var hundredString = (number < 200) ? "sto" : ones(Std.int(number / 100), 0, 0) + "sto";
            
            if (hundred == 0) return hundredString;
            else return hundredString + " " + tens(hundred, genderIdx, caseIdx);
        }
    }
    private static function thousands(number: Int, genderIdx: Int, caseIdx: Int) {
        if (number < 1000) return hundreds(number, genderIdx, caseIdx);
        else {
            var thousand = number % 1000;
            var thousandString = 
                if (number < 2000) "tisoč"
                else if (number < 3000) "dva tisoč"
                else hundreds(Std.int(number / 1000), 0, 0) + " tisoč";
            
            if (thousand == 0) return thousandString;
            else return thousandString + " " + hundreds(thousand, genderIdx, caseIdx);
        }
    }
    private static function millions(number: Int, genderIdx: Int, caseIdx: Int) {
        if (number < 1000000) return thousands(number, genderIdx, caseIdx);
        else {
            var million = number % 1000000;
            var millionsString = if (number < 2000000) "milijon"; else {
                var millionsOnly = Std.int(number / 1000000);
                var postfix = "milijon" + bigNumberSuffix(millionsOnly, 1, 0);
                thousands(millionsOnly, 1, 0) + " " + postfix;
            }
            
            if (million == 0) return millionsString ;
            else return millionsString + " " + thousands(million, genderIdx, caseIdx);
        }
    }
    
    private static function billions(number: Int, genderIdx: Int, caseIdx: Int) {
        if (number < 1000000000) return millions(number, genderIdx, caseIdx);
        else {
            var billion = number % 1000000000;
            var billionsString = if (number < 2000000000) "milijarda"; else {
                var billionsOnly = Std.int(number / 1000000000);
                var postfix = "milijard" + billionNumberSuffix(billionsOnly, 1, 0);
                thousands(billionsOnly, 0, 0) + " " + postfix;
            }
            
            if (billion == 0) return billionsString ;
            else return billionsString + " " + millions(billion, genderIdx, caseIdx);
        }
    }
    
    private static function bigNumberSuffix(number: Int, genderIdx: Int, caseIdx: Int) {
        var modulo = number % 100;
        return switch (modulo) {
            case 1  : "";
            case 2  : "a";
            case 3  : "i";
            case 4  : "i";
            default : "ov";
        }
    }
    
    private static function billionNumberSuffix(number: Int, genderIdx: Int, caseIdx: Int) {
        var modulo = number % 100;
        return switch (modulo) {
            case 1  : "a";
            case 2  : "i";
            case 3  : "e";
            case 4  : "e";
            default : "";
        }
    }
}
