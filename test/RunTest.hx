class RunTest {
    static public function main(): Void {
        var r = new haxe.unit.TestRunner();
        r.add(new WholeNumbersTest());
        r.run();
    }
}
