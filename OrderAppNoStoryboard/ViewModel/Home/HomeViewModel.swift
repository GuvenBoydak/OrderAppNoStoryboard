//
//  HomeVoewModel.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 18.10.2023.
//

import Foundation

final class HomeViewModel {
    var foods = [Food]()
    
    func fetchFoods(complation: @escaping ([Food]?,Error?)->()) {
        NetworkService.fetchData(type: ResponseFood.self, url: "tumYemekleriGetir.php", method: .get, params: nil) { response, error in
            if let error = error ,error != nil {
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
}
