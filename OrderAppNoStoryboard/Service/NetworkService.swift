//
//  NetworkService.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 17.10.2023.
//

import Foundation
import Alamofire

struct NetworkService {
    static var shared = NetworkService()
    
    private init() {
    }
    
    static func fetchData<T: Decodable>(type: T.Type,url: String,method: HTTPMethod,params: Parameters?,complation: @escaping (T?,Error?)->()) {
        AF.request("\(URL_BASE)\(url)",method: method,parameters: params).response {  result in
            switch result.result {
            case .success(let data) :
                do {
                    let resulData = try JSONDecoder().decode(T.self, from: data!)
                    complation(resulData, nil)
                } catch let error {
                    complation(nil,error)
                }
            case .failure(let error):
                complation(nil,error)
            }
        }
    }
}
