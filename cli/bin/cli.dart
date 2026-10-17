// import 'package:cli/cli.dart' as cli;
import 'dart:io';
//Invoca http al proyecto
import 'package:http/http.dart' as http;
// creacion de una costante
const version = '0.0.1';
// funcion main para iniciar el programa
void main(List<String> arguments) {
// funcion if
//arguments es para escribir en consola y 'isEmpty' para no escribir nada
// se usa el o(||) para que se invoque la funcion con una u otra opcion
  if (arguments.isEmpty || arguments.first == 'help'){
  printUsage();
  }
// Se usan comillas simples('') cuando es un string y 2 iguales (==)si debe ser exactamente eso
  else if(arguments.first == 'version'){
  print('La version es $version');
  }
  else if(arguments.first == 'wikipedia'){
  final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
  searchWikipedia(inputArgs);
  }

  else { //Sale al no reconocer el comando
  printUsage();
  }
}
//Creacion de una funcion sin salida
void printUsage (){
print("Funciones usables: 'help', 'version', 'search <ARTICLE-TITLE>'");
}
//Funcion para recibir argumentos de la funcion search
void searchWikipedia (List<String>? arguments) async {
  //declaracion de una variable para guardar datos
  final String articleTitle;
  //bucle para verificar si hay argumentos en search
if(arguments == null || arguments.isEmpty){
  print('Porfavor introduce un argumento');
  //espera a una respuesta
  //articleTitle = stdin.readLineSync() ?? '';
final inputFromStdin = stdin.readLineSync();
if(inputFromStdin == null||inputFromStdin.isEmpty){
  return;
}
 articleTitle = inputFromStdin;
}else{
  articleTitle = arguments.join(' ');
}
print('searchWikipedia arguments recibidos: "$articleTitle"');


var articleContent = await getWikipediaArticle(articleTitle);
print(articleContent);
}
//Funcion para recibir respuestas del API de wikipedia
Future <String> getWikipediaArticle(String articleTitle) async{
  final url = Uri.https(
    'en.wikipedia.org', //API de wikipedia
    '/api/rest_v1/page/summary/$articleTitle'//aqui va a llegar el articulo
  );
  final response = await http.get(url); //crea una variable que espera una respuesta
  if(response.statusCode == 200){
    return response.body; //devuelve la respuesta si encontro el articulo
  }
  //devuelve un mensaje si falla
  return 'Fallo al encontrar $articleTitle, codigo de error ${response.statusCode}';
}
