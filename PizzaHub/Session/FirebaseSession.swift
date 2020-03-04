//
//  FirebaseSession.swift
//  PizzaHub
//
//  Created by Charles Hefele on 3/3/20.
//  Copyright © 2020 Charles Hefele. All rights reserved.
//

import FirebaseFirestore

class FirebaseSession: ObservableObject {
    
    @Published var pizzerias: [Pizzeria] = []
    
    let db: Firestore = Firestore.firestore()
    
    func listen() {
        self.getPizzerias()
    }
    
    func getPizzerias() {
        db.collection("pizzerias").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for docSnapshot in querySnapshot!.documents {
                    let pizzeria = Pizzeria(docSnapshot: docSnapshot)
                    self.pizzerias.append(pizzeria!)
                    print("\(docSnapshot.documentID) => \(docSnapshot.data())")
                }
            }
        }
    }
}
