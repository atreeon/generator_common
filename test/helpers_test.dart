import 'package:generator_common/classes.dart';
import 'package:generator_common/helpers.dart';
import 'package:test/test.dart';

void main() {
  group("getClassComment", () {
    test("1x", () {
      var interfaces = [
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"], []),
      ];

      var result = getClassComment(interfaces, "///blah");

      expect(result, """///blah
///
///implements [\$A]
///

///
""");
    });

    test("2x null class comment", () {
      var interfaces = [
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"], []),
      ];

      var result = getClassComment(interfaces, "");

      expect(result, """///
///implements [\$A]
///

///
""");
    });

    test("3x with all comments", () {
      var interfaces = [
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"], [], comment: "///blah1"),
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"], []),
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"], [], comment: "///blah2"),
      ];

      var result = getClassComment(interfaces, "///blah");

      expect(result, """///blah
///
///implements [\$A]
///

///blah1
///
///implements [\$A]
///

///
///implements [\$A]
///

///blah2
///
""");
    });
  });
}
