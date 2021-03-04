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

MethodDetails GetMethodDetailsForMethodElement<T>(MethodElement method, T GetMetaData()) {
  var returnType = method.type.returnType.toString();

  var paramsPositional2 = method.type.parameters.where((x) => x.isPositional);
  var paramsNamed2 = method.type.parameters.where((x) => x.isNamed);

  var paramsPositional = paramsPositional2
      .map((x) => NameTypeWithComment(
            x.name.toString(),
            x.type.toString(),
            comment: x.documentationComment,
          ))
      .toList();
  var paramsNamed = paramsNamed2
      .map((x) => NameTypeWithComment(
            x.name.toString(),
            x.type.toString(),
            comment: x.documentationComment,
          ))
      .toList();

  var typeParameters = method.typeParameters //
      .map((e) => NameType(e.name, e.runtimeType.toString()))
      .toList();

  return MethodDetails(method.documentationComment, method.name, paramsPositional, paramsNamed, typeParameters, returnType);
}

//final String Function(String name,) fn;
String getFunctionDefinition(
  MethodDetails methodDetails,
) {
  if (methodDetails.paramsPositional.length == 0 && methodDetails.paramsNamed.length == 0) {
    return "${formattedComment(methodDetails.methodComment)}${methodDetails.returnType} Function()";
  }

  var strParamsPositional = methodDetails.paramsPositional.map((x) => //
      "${formattedComment(x.comment)}${x.type} ${x.name}").join(",\n");

  var strParamsNamed = methodDetails.paramsNamed
      .map((x) => //
          x.type.contains("?") //
              ? "${formattedComment(x.comment)}${x.type} ${x.name}"
              : "${formattedComment(x.comment)}required ${x.type} ${x.name}")
      .join(",\n");

  var params = [
    if (methodDetails.paramsPositional.isNotEmpty) //
      strParamsPositional,
    if (methodDetails.paramsNamed.isNotEmpty) //
      "{\n$strParamsNamed}",
  ].join(",");

  return "${formattedComment(methodDetails.methodComment)}${methodDetails.returnType} Function(\n$params)";
}

String formattedComment(String? comment) {
  return comment == null ? "" : comment + "\n";
}
