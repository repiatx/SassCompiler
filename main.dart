import 'dart:io';
import 'package:ansicolor/ansicolor.dart';
import 'package:sass/sass.dart' as sass;

var warningFont = new AnsiPen();
var errorFont = new AnsiPen();
var infoFont = new AnsiPen();
var successFont = new AnsiPen();
var creatorFont = new AnsiPen();
var boldWhite = new AnsiPen();
Future<void> main(List<String> arguments) async {
  initColors();
  welcome();
  if (arguments.length == 0) {
    noParamters();
    creator();
    return;
  }

  if (arguments[0] == "-h") {
    wrongParamters();
    creator();
    return;
  }
  if (arguments[1] == "") {
    print(errorFont("You have entered wrong paramters. Please type -h to get started"));
    creator();
    return;
  }
  try {
    
    if( ! await File(arguments[0]).exists()){
      throw new FileSystemException("Could not find inputFile.");
    }
    var folderPath = File(arguments[1]).parent.path;
    if(! await File(folderPath).exists()){
      throw new FileSystemException("Could not find the outputFolder");
    }



    var result = sass.compile(arguments[0]);

    new File(arguments[1]).writeAsStringSync(result);
    print(successFont("Successfuly created!"));
    creator();
  } catch (e) {

    print(warningFont("Something went wrong!!!"));
    print(errorFont(e));
  }
}

void initColors() {
  warningFont
    ..white(bold: true)
    ..rgb(r: 1.0, g: 0.8, b: 0.2);
  boldWhite..white(bold: true);
  errorFont..red(bold: true);
  infoFont..blue();
  successFont..green();
  creatorFont.cyan(bold: true);
}
void welcome() {
  print(warningFont("================================================================="));
print("");
  print(warningFont("  >  Welcome to Sass Compiler !!!"));
  print("");
  print(warningFont("================================================================="));
  print("");

}
void wrongParamters() {
  print(boldWhite(" > compiler 'inputFilePath' 'outputFilePath"));
  print("");
  print("");
  print(boldWhite("exp: compiler style.scss style.css"));
  print("");
  print("");
  print(warningFont("Have fun!!!"));
}

void noParamters() {
  print(errorFont("You didnt enter any arguments."));
  print(boldWhite(" - To get started type -h"));
}

void creator() {
  print("");
  print(creatorFont("================================================================="));
  print("");
  print(creatorFont("   made by RepiatX"));
  print("");
  print(creatorFont("================================================================="));
}
