//
//  BasketViewModel.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 20.10.2023.
//

import Foundation


final class BasketViewModel {
    var basketFoods: [Basket]?
        
    func getBasketFoods(complation: @escaping ([Basket]?)->()) {
        let params : [String:Any] = ["kullanici_adi":"Guven"]
        NetworkService.fetchData(type: ResponseBasket.self, url: "sepettekiYemekleriGetir.php", method: .post, params: params) { resul, error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                return
            }
            if let data = resul?.sepet_yemekler {
                self.basketFoods = data
                complation(data)
            }
        }
    }
    func deleteFromBasket(id: Int) {
        let params : [String:Any] = ["sepet_yemek_id":id,"kullanici_adi":"Guven"]
        NetworkService.fetchData(type: Response.self, url: "sepettenYemekSil.php", method: .post, params: params) { result, error in
            if error != nil {
               return print(error?.localizedDescription ?? "error")
            }
        }
    }
    func addToFirebase(id: Int){
        let item = basketFoods?.first{food in food.sepet_yemek_id == String(id)}
        let params: [String:Any] = ["name":item?.yemek_adi ?? "","fiyat":item?.yemek_fiyat ?? "","status":Status.deleted.rawValue]
        URL_FIREBASE.addDocument(data: params) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
