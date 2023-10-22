//
//  Activity.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 22.10.2023.
//

import Foundation

struct Activity {
    var name: String
    var price: String
    var status: String
    
    init(name: String, price: String, status: String) {
        self.name = name
        self.price = price
        self.status = status
    }
}
