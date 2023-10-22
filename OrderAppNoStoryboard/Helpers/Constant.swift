//
//  Constant.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 17.10.2023.
//

import Foundation
import FirebaseFirestore


let URL_BASE = "http://kasimadalan.pe.hu/yemekler/"
let URL_IMAGE = "http://kasimadalan.pe.hu/yemekler/resimler/"
let URL_FIREBASE = Firestore.firestore().collection("food")

enum Status: String {
    case added = "Sepete Eklenen"
    case deleted = "Sepeten Silinen"
    case favorited = "Favoriler"
}
