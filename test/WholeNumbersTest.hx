class WholeNumbersTest extends haxe.unit.TestCase {
    public function testImenovalnik() {
        var json: Array<TestNumber> = haxe.Json.parse(sys.io.File.getContent("test/zapis-slovenskih-stevil/cela_stevila.json"));
        for (number in json) {
            assertEquals("Z: " + zenski(number.imenovalnik), "Z: " + SloveneNumber.format(number.stevilo, Gender.Female, Case.Nominative)); 
            assertEquals("M: " + moski(number.imenovalnik), "M: " + SloveneNumber.format(number.stevilo, Gender.Male, Case.Nominative)); 
            assertEquals("S: " + srednji(number.imenovalnik), "S: " + SloveneNumber.format(number.stevilo, Gender.Neutral, Case.Nominative)); 
        }
    }
    
    public function testRodilnik() {
        var json: Array<TestNumber> = haxe.Json.parse(sys.io.File.getContent("test/zapis-slovenskih-stevil/cela_stevila.json"));
        for (number in json) {
            assertEquals("Z: " + zenski(number.rodilnik), "Z: " + SloveneNumber.format(number.stevilo, Gender.Female, Case.Genitive)); 
            assertEquals("M: " + moski(number.rodilnik), "M: " + SloveneNumber.format(number.stevilo, Gender.Male, Case.Genitive)); 
            assertEquals("S: " + srednji(number.rodilnik), "S: " + SloveneNumber.format(number.stevilo, Gender.Neutral, Case.Genitive)); 
        }
    }
    
    public function testDajalnik() {
        var json: Array<TestNumber> = haxe.Json.parse(sys.io.File.getContent("test/zapis-slovenskih-stevil/cela_stevila.json"));
        for (number in json) {
            assertEquals("Z: " + zenski(number.dajalnik), "Z: " + SloveneNumber.format(number.stevilo, Gender.Female, Case.Dative)); 
            assertEquals("M: " + moski(number.dajalnik), "M: " + SloveneNumber.format(number.stevilo, Gender.Male, Case.Dative)); 
            assertEquals("S: " + srednji(number.dajalnik), "S: " + SloveneNumber.format(number.stevilo, Gender.Neutral, Case.Dative)); 
        }
    }
    
    public function testTozilnik() {
        var json: Array<TestNumber> = haxe.Json.parse(sys.io.File.getContent("test/zapis-slovenskih-stevil/cela_stevila.json"));
        for (number in json) {
            assertEquals("Z: " + zenski(number.tozilnik), "Z: " + SloveneNumber.format(number.stevilo, Gender.Female, Case.Accusative)); 
            assertEquals("M: " + moski(number.tozilnik), "M: " + SloveneNumber.format(number.stevilo, Gender.Male, Case.Accusative)); 
            assertEquals("S: " + srednji(number.tozilnik), "S: " + SloveneNumber.format(number.stevilo, Gender.Neutral, Case.Accusative)); 
        }
    }
    
    public function testMestnik() {
        var json: Array<TestNumber> = haxe.Json.parse(sys.io.File.getContent("test/zapis-slovenskih-stevil/cela_stevila.json"));
        for (number in json) {
            assertEquals("Z: " + zenski(number.mestnik), "Z: " + SloveneNumber.format(number.stevilo, Gender.Female, Case.Locative)); 
            assertEquals("M: " + moski(number.mestnik), "M: " + SloveneNumber.format(number.stevilo, Gender.Male, Case.Locative)); 
            assertEquals("S: " + srednji(number.mestnik), "S: " + SloveneNumber.format(number.stevilo, Gender.Neutral, Case.Locative)); 
        }
    }
    
    public function testOrodnik() {
        var json: Array<TestNumber> = haxe.Json.parse(sys.io.File.getContent("test/zapis-slovenskih-stevil/cela_stevila.json"));
        for (number in json) {
            assertEquals("Z: " + zenski(number.orodnik), "Z: " + SloveneNumber.format(number.stevilo, Gender.Female, Case.Instrumental)); 
            assertEquals("M: " + moski(number.orodnik), "M: " + SloveneNumber.format(number.stevilo, Gender.Male, Case.Instrumental)); 
            assertEquals("S: " + srednji(number.orodnik), "S: " + SloveneNumber.format(number.stevilo, Gender.Neutral, Case.Instrumental)); 
        }
    }
    
    static public function zenski(num: TestNumberCase) { 
        return num.vsi == null ? num.z : num.vsi;
    }
    static public function moski(num: TestNumberCase) { 
        return num.vsi == null ? num.m : num.vsi;
    }
    static public function srednji(num: TestNumberCase) { 
        return num.vsi == null ? num.s : num.vsi;
    }
}
