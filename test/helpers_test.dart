import 'package:generator_common/classes.dart';
import 'package:generator_common/helpers.dart';
import 'package:test/test.dart';

void main() {
  group("getClassComment", () {
    test("1x", () {
      var interfaces = [
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"]),
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
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"]),
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
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"], comment: "///blah1"),
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"]),
        InterfaceWithComment("\$A", ["int", "String"], ["T1", "T2"], comment: "///blah2"),
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

  /*
  todo
   - method comment
   */

  group("getFunction", () {
    test("1 all positional", () {
      var returnType = "List<String>";
      var paramsPositional = [
        NameTypeWithComment("param1", "String"),
        NameTypeWithComment("param2", "List<String>"),
      ];
      var paramsNamed = <NameTypeWithComment>[];

      var methodDetails = MethodDetails(null, "Blah", paramsPositional, paramsNamed, [], returnType);

      var result = getFunctionDefinition(methodDetails);

      expect(result, """List<String> Function(
String param1,
List<String> param2)""");
    });

    test("2 all named paramsPositional", () {
      var returnType = "List<String>";
      var paramsPositional = <NameTypeWithComment>[];
      var paramsNamed = [
        NameTypeWithComment("param1", "String"),
        NameTypeWithComment("param2", "int"),
      ];

      var methodDetails = MethodDetails(null, "Blah", paramsPositional, paramsNamed, [], returnType);

      var result = getFunctionDefinition(methodDetails);

      expect(result, """List<String> Function(
{
required String param1,
required int param2})""");
    });

    test("3 zero parameters", () {
      var returnType = "List<String>";
      var paramsPositional = <NameTypeWithComment>[];
      var paramsNamed = <NameTypeWithComment>[];

      var methodDetails = MethodDetails(null, "Blah", paramsPositional, paramsNamed, [], returnType);

      var result = getFunctionDefinition(methodDetails);

      expect(result, "List<String> Function()");
    });

    test("4 mixture named and positional", () {
      var returnType = "List<String>";
      var paramsPositional = [NameTypeWithComment("param0", "String")];
      var paramsNamed = [NameTypeWithComment("param1", "String")];

      var methodDetails = MethodDetails(null, "Blah", paramsPositional, paramsNamed, [], returnType);

      var result = getFunctionDefinition(methodDetails);

      expect(result, """List<String> Function(
String param0,{
required String param1})""");
    });

    test("5 mixture named and positional & nullable", () {
      var returnType = "List<String>";
      var paramsPositional = <NameTypeWithComment>[
        NameTypeWithComment("param0", "String"),
        NameTypeWithComment("param1", "int?"),
        NameTypeWithComment("param2", "double"),
      ];
      var paramsNamed = [
        NameTypeWithComment("param3", "String"),
        NameTypeWithComment("param4", "int?"),
      ];

      var methodDetails = MethodDetails(null, "Blah", paramsPositional, paramsNamed, [], returnType);

      var result = getFunctionDefinition(methodDetails);

      expect(result, //
          """List<String> Function(
String param0,
int? param1,
double param2,{
required String param3,
int? param4})""");
    });

    test("6 mixture named and positional & nullable with comments", () {
      var returnType = "List<String>";
      var paramsPositional = <NameTypeWithComment>[
        NameTypeWithComment("param0", "String", comment: "///blah"),
        NameTypeWithComment("param1", "int?"),
        NameTypeWithComment("param2", "double", comment: "///blim"),
      ];
      var paramsNamed = [
        NameTypeWithComment("param3", "String"),
        NameTypeWithComment("param4", "int?", comment: "///bloh"),
      ];

      var methodDetails = MethodDetails(null, "Blah", paramsPositional, paramsNamed, [], returnType);

      var result = getFunctionDefinition(methodDetails);

      expect(result, //
          """List<String> Function(
///blah
String param0,
int? param1,
///blim
double param2,{
required String param3,
///bloh
int? param4})""");
    });
  });
}
