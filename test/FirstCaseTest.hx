class FirstCaseTest extends haxe.unit.TestCase {
    public function testImenovalnik() {
        var json: Array<TestNumber> = haxe.Json.parse(sys.io.File.getContent("test/zapis-slovenskih-stevil/cela_stevila.json"));
        for (number in json) {
            assertEquals("Z: " + zenski(number.imenovalnik), "Z: " + SloveneNumber.format(number.stevilo, Gender.Female, Case.Nominative)); 
            assertEquals("M: " + moski(number.imenovalnik), "M: " + SloveneNumber.format(number.stevilo, Gender.Male, Case.Nominative)); 
            assertEquals("S: " + srednji(number.imenovalnik), "S: " + SloveneNumber.format(number.stevilo, Gender.Neutral, Case.Nominative)); 
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
