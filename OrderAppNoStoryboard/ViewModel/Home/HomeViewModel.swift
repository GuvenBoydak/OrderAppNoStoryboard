//
//  HomeVoewModel.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 18.10.2023.
//

import Foundation

final class HomeViewModel {
    // MARK: Properties
    var foods = [Food]()
    
    func fetchFoods(complation: @escaping ([Food]?,Error?)->()) {
        NetworkService.fetchData(type: ResponseFood.self, url: "tumYemekleriGetir.php", method: .get, params: nil) { response, error in
            if let error = error {
                complation(nil,error)
            }
            if let data = response?.yemekler {
                self.foods = data
                complation(data,nil)
            }
        }
    }
    func numberOfRows() -> Int {
        foods.count
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
    func addToFirebase(item basket: Basket) {
        let params: [String:Any] = ["name":basket.yemek_adi ?? "","price":basket.yemek_fiyat ?? "","status":Status.added.rawValue]
        URL_FIREBASE.document().setData(params)
    }
    
    func searchFoods(searchText: String) {
        let findFood = foods.filter { $0.yemek_adi.lowercased().contains(searchText.lowercased()) }
        foods.removeAll()
        foods = findFood
    }
}
