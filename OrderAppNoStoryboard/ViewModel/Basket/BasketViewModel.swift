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
        NetworkService.fetchData(type: ResponseBasket.self, url: URL_BASKET, method: .post, params: params) { resul, error in
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
        NetworkService.fetchData(type: Response.self, url: URL_DELETEITEM, method: .post, params: params) { result, error in
            if error != nil {
               return print(error?.localizedDescription ?? "error")
            }
        }
    }
}
