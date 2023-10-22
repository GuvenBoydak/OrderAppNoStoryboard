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
        let params: [String:Any] = ["name":food.yemek_adi,"price":food.yemek_fiyat,"status": Status.favorited.rawValue]
        URL_FIREBASE.addDocument(data: params) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    func addToBasket(item basket: Basket) {
        let params : [String:Any] = ["sepet_yemek_id":basket.sepet_yemek_id ?? "",
                                     "yemek_adi":basket.yemek_adi ?? "",
                                     "yemek_resim_adi":basket.yemek_resim_adi ?? "",
                                     "yemek_fiyat":basket.yemek_fiyat ?? "",
                                     "yemek_siparis_adet":basket.yemek_siparis_adet ?? "",
                                     "kullanici_adi":basket.kullanici_adi ?? ""]
        NetworkService.fetchData(type: Response.self, url: "sepeteYemekEkle.php", method: .post, params: params) { result, error in
            if let error = error {
                return print(error.localizedDescription)
            }
        }
    }
    func addBasketToFirebase(item basket: Basket) {
        let params: [String:Any] = ["name":basket.yemek_adi ?? "","price":basket.yemek_fiyat ?? "","status": Status.added.rawValue]
        URL_FIREBASE.addDocument(data: params) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
