//
//  ProfileViewModel.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 22.10.2023.
//

import UIKit

final class ProfileViewModel {
    var activities = [Activity]()
    
    func numberOfItems() -> Int {
        activities.count
    }
    func filterActivity(filter: String) {
        URL_FIREBASE.addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else { return }
            self.activities.removeAll()
            for document in documents {
                let data = document.data()
                let name = data["name"] as? String ?? ""
                let price = data["price"] as? String ?? ""
                let status = data["status"] as? String ?? ""
                let activity = Activity(name: name, price: price, status: status)
                if filter == status {
                    self.activities.append(activity)
                }
            }
        }
    }
}
