//
//  DetailViewModel.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 19.10.2023.
//

import Foundation
import FirebaseFirestore

final class DetailViewModel {
    
    func addToFavorite(food: Food) {
        let params: [String:Any] = ["name":food.yemek_adi,"price":food.yemek_fiyat,"status":"Favoriye Eklendi"]
        URL_FIREBASE.addDocument(data: params) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
