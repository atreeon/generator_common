import 'package:generator_common/classes.dart';
import 'package:test/test.dart';

void main() {
  group("getClassComment", () {
    test("1x generic types are correct", () {
      var blah = InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"], []);

      expect(blah.toString(), "\$A|[T1:int, T2:String]|[]");
    });
  });
}
