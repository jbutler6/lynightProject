import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lynight/services/crud.dart';


class AlgoMusicReference {
  CrudMethods crudObj = new CrudMethods();
  Stream club;
  Map<dynamic, dynamic> mapOfUserMusics;
  bool electro = false;
  bool rap = false;
  bool rnb = false;
  bool populaire = false;
  bool rock = false;
  bool trans = false;
  int numberOfSameMusics= 0;


  List<DocumentSnapshot> dataClubFromBDD;
  final snapClub;

  // On demande une map des music de l'utilisateur et la snapshot
  AlgoMusicReference({
    @required this.mapOfUserMusics,
    @required this.snapClub,
  });

  Map<dynamic, dynamic> test = {};

  //retourne une liste contenant une map de chaque club
  //Faut changer la valeur de la boucle for sur lequel ça tourne
  getClubMusic() {
    crudObj.getDataFromClubFromDocument().then((value) {
      // correspond à await Firestore.instance.collection('user').document(user.uid).get();
      dataClubFromBDD = value.documents;
    });

    //print(dataClubFromBDD);

    var listClubFromDatabase = [];

    int numberOfClub = 0;
    if (snapClub != null) {
      numberOfClub = snapClub.length;
    }

    for (int i = 0; i < numberOfClub; i++) {
      if (snapClub != null) {
        var clubI = snapClub[i].data;
        //print(snapClub[i].documentID);

        listClubFromDatabase.add(clubI);
      }
    }
    //print(listClubFromDatabase.length);
    return listClubFromDatabase;
  }

  // retourne une list de map des music de l'utilisateur
  // forme = [{populaire : true, electro : ...}, {...},...]
  getMusicsOfClubMap() {
    var listMapMusicClub = [];
    Map<dynamic, dynamic> clubMap;
    if (getClubMusic() != null) {
      for (int i = 0; i < getClubMusic().length; i++) {
        List clubMusicList = getClubMusic();
        var club1 = clubMusicList[i];

        clubMap = club1['musics'];

        listMapMusicClub.add(clubMap);
      }

      return listMapMusicClub;
    }
  }

  // retourne une liste de String comportant tout les noms des club
  getClubName() {
    List<String> listNameClub = [];
    if (getClubMusic() != null) {
      var clubNameForReal;
      for (int i = 0; i < getClubMusic().length; i++) {
        var clubName;
        clubName = getClubMusic()[i];
        clubNameForReal = clubName['name'];

        listNameClub.add(clubNameForReal);
      }

      return listNameClub;
    }
  }

  Map<String, int> creationMapOfMusicAndLiked(){
      Map<String, int> club = {};
      if(snapClub != null) {
        for (int i = 0; i < 5; i++) {
          if (snapClub[i].documentID != null) {
            club[snapClub[i].documentID] = 0;
          }
        }
        return club;
      }

  }


  List<List> listNumberOfMusicLiked(){
    var m = 5;
    var n = 2;
    var x = new List.generate(m, (_) => new List(n));
    print('diezbdhuezbhudbezhubdhuzebdhezhudbezhudbeuz');
    print(x);
    return x;
  }

  // Compare les 2 map
  List<String> compareMusic() {
    Map<String, int> mapOfClubAndMatch = creationMapOfMusicAndLiked();
    print('dheiuzduiezidez');
    print(mapOfClubAndMatch);

    final List<String> bestClub = []; //club retenu pour la liste à retourner

    //print('==================');
    //print('Valeur de getMusic : ');
    //print(getMusicsOfClubMap());
    List<dynamic> getMusic = [
      {
        populaire: true,
        rap: false,
        rock: true,
        electro: false,
        rnb: false,
        trans: true
      },
      {
        populaire: false,
        rap: false,
        rock: false,
        electro: true,
        rnb: true,
        trans: true
      },
      {
        populaire: false,
        rap: true,
        rock: true,
        electro: true,
        rnb: true,
        trans: false
      }
    ];
    getMusic = getMusicsOfClubMap();
    //print(getMusic);
    //print('==================');




    // Va boucler sur la taille de la liste complete
    for (int i = 0; i < getMusic.length; i++) {
      if (mapOfUserMusics != null) {
        if (getMusic != null) {
          Map<dynamic, dynamic> mapOfMusicFromList = getMusic[i];

          // Va verifier tout les style de musique d'abord si ils ont là même valeur et ensuite si il retourne true
          // Si c'est le cas on va l'ajouter à la liste qui sera retourné

          if ((mapOfUserMusics['populaire'] == mapOfMusicFromList['populaire']) && (mapOfUserMusics['populaire'] == true)) {
            listNumberOfMusicLiked();
            //print('debut de la boucle de verif de style de music');
            //print('*********************');
            // print('Les deux il kiffe populaire');


            var numberOfMatch = mapOfClubAndMatch['${snapClub[i].documentID}'];
            print('---------------------');
            print('number of match au debut, devrait etre 0  ');
            print(numberOfMatch);
            if(numberOfMatch != null) {
              numberOfMatch = numberOfMatch + 1;
              mapOfClubAndMatch['${snapClub[i].documentID}'] = numberOfMatch;
              print('number of match :;;;;;;;;;;;;;; ');
              print(numberOfMatch);
              print(mapOfClubAndMatch);
            }


            print('---------------');
            print(mapOfClubAndMatch);
            bestClub.add(snapClub[i].documentID);
            //print('Valur après ajout de populaire');
            //print(bestClub);
            //return bestClub;
          } else {
            if ((mapOfUserMusics['electro'] == mapOfMusicFromList['electro']) && (mapOfUserMusics['electro'] == true)) {
              //print('*****************');
              //print('ils aiment le electro tout les 2 ');
              bestClub.add(snapClub[i].documentID);
              //print('Valur après ajout de electro');
              //print(bestClub);
            } else {
              if ((mapOfUserMusics['rap'] == mapOfMusicFromList['rap']) && (mapOfUserMusics['rap'] == true)) {
                //print('*****************');
                //print('ils aiment le rap tout les 2 ');
                bestClub.add(snapClub[i].documentID);
                //print('Valur après ajout de rap');
                //print(bestClub);
              } else {
                if ((mapOfUserMusics['rnb'] == mapOfMusicFromList['rnb']) && (mapOfUserMusics['rnb'] == true)) {
                  //print('*****************');
                  //print('ils aiment le rnb tout les 2 ');
                  bestClub.add(snapClub[i].documentID);
                  //print('Valur après ajout de rnb');
                  //print(bestClub);
                } else {
                  if ((mapOfUserMusics['rock'] == mapOfMusicFromList['rock']) && (mapOfUserMusics['rock'] == true)) {
                    //print('*****************');
                    //print('ils aiment le rock tout les 2 ');
                    bestClub.add(snapClub[i].documentID);
                    //print('Valur après ajout de rock');
                    //print(bestClub);
                  } else {
                    if ((mapOfUserMusics['trans'] == mapOfMusicFromList['trans']) && (mapOfUserMusics['trans'] == true)) {
                      //print('*****************');
                      //print('ils aiment la trans tout les 2 ');
                      bestClub.add(snapClub[i].documentID);
                      //print('Valur après ajout de trans');
                      //print(bestClub);
                    }
                  }
                }
              }
              print('Valeur de bestclub quoi quil arrive');
              print(bestClub);
              //print('Le club ' +nameOfClubList[i] +'a aucun son en commun avec le user');
            }
          }
//          print('--------------------------------------------------');
        }
      }
    }

//    print(bestClub);
//    return bestClub;

    if (bestClub.isNotEmpty) {
      int length = bestClub.length;
      if (length >= 5) {
//        print(length);
        var rdm = new Random();
        int loop = 5;
        List<String> mutableListRandomClub = [];
        for (int i = 0; i < loop; i++) {
          bool sameClub = false;
          var currentRandom = rdm.nextInt(length);
//        print('current random' + currentRandom.toString());
          if (mutableListRandomClub.isEmpty) {
//          print('ISEMPTY');
            mutableListRandomClub.add(bestClub[currentRandom]);
          } else {
            for (int j = 0; j < mutableListRandomClub.length; j++) {
              if (bestClub[currentRandom] == mutableListRandomClub[j]) {
//              print('SAME CLUB DOMMAGE');
                sameClub = true;
                break;
              }
            }
            if (!sameClub) {
//            print('sur le point dajouter : ' + queryClubList[currentRandom]['name']);
              mutableListRandomClub.add(bestClub[currentRandom]);
            } else {
              loop++;
            }
          }
        }
//        print(mutableListRandomClub);
        return mutableListRandomClub;
      } else {
        return bestClub;
      }
    } else {
      print('liste des clubs pas encore fetch de la base');
      return null;
    }
  }
}
