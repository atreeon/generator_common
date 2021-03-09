// ignore: import_of_legacy_library_into_null_safe
import 'package:analyzer/dart/element/element.dart';

// ignore: import_of_legacy_library_into_null_safe

import 'classes.dart';

/// [interfaces] a list of interfaces the class implements
///
/// [classComment] the comment of the class itself
String getClassComment(List<Interface> interfaces, String? classComment) {
  var a = interfaces.where((e) => e is InterfaceWithComment && e.comment != classComment) //
      .map((e) {
    var interfaceComment = e is InterfaceWithComment && e.comment != null //
        ? "\n${e.comment}"
        : "";
    return "///implements [${e.type}]\n///\n$interfaceComment\n///";
  }).toList();

  if (classComment != null) //
    a.insert(0, classComment + "\n///");

  return a.join("\n").trim() + "\n";
}

MethodDetails<TMeta1> getMethodDetailsForFunctionType<TMeta1>(
  FunctionTypedElement fn,
  TMeta1 GetMetaData(ParameterElement parameterElement),
) {
  var returnType = fn.returnType.toString();

  var paramsPositional2 = fn.parameters.where((x) => x.isPositional);
  var paramsNamed2 = fn.parameters.where((x) => x.isNamed);

  var paramsPositional = paramsPositional2
      .map((x) => NameTypeWithComment<TMeta1>(
            x.name.toString(),
            x.type.toString(),
            comment: x.documentationComment,
            meta1: GetMetaData(x),
          ))
      .toList();
  var paramsNamed = paramsNamed2
      .map((x) => NameTypeWithComment<TMeta1>(
            x.name.toString(),
            x.type.toString(),
            comment: x.documentationComment,
            meta1: GetMetaData(x),
          ))
      .toList();

  var typeParameters2 = fn.typeParameters //
      .map((e) => GenericsNameType(e.name, e.bound == null ? null : e.bound.toString()))
      .toList();

  return MethodDetails<TMeta1>(fn.documentationComment, fn.name ?? "", paramsPositional, paramsNamed, typeParameters2, returnType);
}
