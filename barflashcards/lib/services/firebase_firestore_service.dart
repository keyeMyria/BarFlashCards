import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barflashcards/models/drink.dart';

final CollectionReference drinksCollection =
    Firestore.instance.collection('drinks');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  Future<Drink> createDrink(String name, String category,
      [String description]) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(drinksCollection.document());

      final Drink drink = new Drink.withId(
          id: ds.documentID,
          name: name,
          category: category,
          description: description,
          dateAdded: DateTime.now());

      final Map<String, dynamic> data = drink.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Drink.fromObject(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getDrinksList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = drinksCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getBeerList({int offset, int limit}) {
    Stream<QuerySnapshot> beers = Firestore.instance
        .collection('drinks')
        .where("category", isEqualTo: "beer")
        .snapshots();
    if (offset != null) {
      beers = beers.skip(offset);
    }

    if (limit != null) {
      beers = beers.take(limit);
    }

    return beers;
  }

  Stream<QuerySnapshot> getCocktailList({int offset, int limit}) {
    Stream<QuerySnapshot> cocktails = Firestore.instance
        .collection('drinks')
        .where("category", isEqualTo: "cocktail")
        .snapshots();
    if (offset != null) {
      cocktails = cocktails.skip(offset);
    }

    if (limit != null) {
      cocktails = cocktails.take(limit);
    }

    return cocktails;
  }

  Stream<QuerySnapshot> getWineList({int offset, int limit}) {
    Stream<QuerySnapshot> wines = Firestore.instance
        .collection('drinks')
        .where("category", isEqualTo: "wine")
        .snapshots();
    if (offset != null) {
      wines = wines.skip(offset);
    }

    if (limit != null) {
      wines = wines.take(limit);
    }

    return wines;
  }

  Stream<QuerySnapshot> getNonAlcoholicList({int offset, int limit}) {
    Stream<QuerySnapshot> nonAlcoholics = Firestore.instance
        .collection('drinks')
        .where("category", isEqualTo: "non-alcoholic")
        .snapshots();
    if (offset != null) {
      nonAlcoholics = nonAlcoholics.skip(offset);
    }

    if (limit != null) {
      nonAlcoholics = nonAlcoholics.take(limit);
    }

    return nonAlcoholics;
  }

  Future<dynamic> updateDrink(Drink drink) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(drinksCollection.document(drink.id));

      await tx.update(ds.reference, drink.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteDrink(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(drinksCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
