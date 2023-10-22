//
//  Extension.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 18.10.2023.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(fromURL urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.main.async {
                self.kf.setImage(with: url)
            }
        }
    }
}
