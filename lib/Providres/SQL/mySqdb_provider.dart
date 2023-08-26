
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'weathermodel.dart';

class mySqdb extends ChangeNotifier {

 bool col = true ;
  Future<Database> weatherdata() async {
    return openDatabase(
      join(await getDatabasesPath(), 'weather_db.db'),
      onCreate: (db, version) {
        
        return db.execute(
            'CREATE TABLE weather (id INTEGER PRIMERY KEY, lable TEXT)');    
      },
      version: 1,
    );
    
  }



 Future<bool> con(weathermodel model) async {


var value =await getAll('weather', 'weather_db');


if( value.any((element) => element.id==model.id))
{
  col = false; 
  notifyListeners();
  return false;

}

else{
 col = true; 
  notifyListeners();
  return true;
}


 }



  Future<void> insert(weathermodel model) async {
    final Database db = await weatherdata();


getAll('weather', 'weather_db').then((value) {



if(value.any((element) => element.id==model.id))
{

delete(model);
}

else{

  db.insert(model.tabel(), model.tomap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
        notifyListeners();
    db.close();
}


 con(model);


} 



);

   
  }

  Future<void> delete(weathermodel model) async {

    final Database db = await weatherdata();
    await db.delete(model.tabel(), where: 'id = ?', whereArgs: [model.getid()]);
    notifyListeners();
    db.close();
    con(model);
  }


  Future<List<weathermodel>> getAll(String table, String dbname) async {

    final Database db = await weatherdata();
    final List<Map<String, dynamic>> maps = await db.query(table);
    List<weathermodel> models = [];
    for (var item in maps) models.add(weathermodel.fromMap(item));
    return models;
  }






}
