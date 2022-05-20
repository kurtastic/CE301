import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';

class Server {
  int port = 8081;
  Db? _db;



void start()async {

  var server = await HttpServer.bind('localhost', port);
  // var server = HttpServer.bind('localhost',port);

 
 //  final db = await Db.create("mongodb+srv://admin:admin@imhungary.sdot6.mongodb.net/community?retryWrites=true&w=majority");
    _db = await Db.create("mongodb+srv://admin:admin@imhungary.sdot6.mongodb.net/community?retryWrites=true&w=majority");
  await _db?.open();
  final foodCollection = await _db?.collection("foods");
  final markersCollection  = await _db?.collection("markers");
  final testCollection  = await _db?.collection("test");


print("Connected to Database");

 //print(await coll?.find().toList());

  //_db = await _db;

  server.listen((HttpRequest request) async { 
    // if (request.uri.path == '/'){
    // request.response.write("hello friend");
    // }
    // else if (request.uri.path == '/markers'){
    //   request.response.write (await markersCollection?.find().toList());
    // }
    //  else if (request.uri.path == '/food'){
    //   request.response.write("markers");
    //   request.response.write (await foodCollection?.find().toList());
    // }
    // await  request.response.close();
  
  
  switch (request.uri.path) {
    case '/':
      await request.response
      ..write("hello friend")
      ..close();
      break;    
    case '/markers':
      if(request.method == 'GET'){
        await request.response
      ..write (await markersCollection?.find().toList())
      ..close();
      }
      
      
      break;
    case '/foods':
      await request.response
      ..write (await foodCollection?.find().toList())
      ..close();
      break;
    case '/test':
      await request.response
      ..write (await testCollection?.find().toList())
      ..close();
      break;
    default:
      request.response..statusCode = HttpStatus.notFound
      ..write('Not found')
      ..close();
  }
  
  }
  );
  

  print ("Server listening at http://localhost:$port");
}


void stop() async => await  _db?.close(); 

 
//final server;



}

void main(List<String> args) async {
 // http.get(url)
  
 var server =  Server();
  server.start();
 //await server._db?.close();
  
}