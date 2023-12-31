//
//  MainTabBarViewController.swift
//  OrderAppNoStoryboard
//
//  Created by Güven Boydak on 16.10.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
// MARK: - Helpers
extension MainTabBarController {
    private func setup() {
        viewControllers = [
           createViewController(controller: HomeViewController(), name: "Anasayfa", image: "homekit"),
           createViewController(controller: BasketViewController(), name: "Sepet", image: "backpack.circle"),
           createViewController(controller: ProfileViewController(), name: "Profile", image: "person.crop.circle")
        ]
        
    }
    private func createViewController(controller:UIViewController,name: String,image: String)-> UIViewController {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "background")
        controller.title = name
        let rootcontroller = UINavigationController(rootViewController: controller)
        rootcontroller.navigationBar.standardAppearance = appearance
        rootcontroller.navigationBar.scrollEdgeAppearance = appearance
        rootcontroller.navigationBar.scrollEdgeAppearance = appearance
        rootcontroller.navigationBar.compactAppearance = appearance
        rootcontroller.tabBarItem.title = name
        rootcontroller.tabBarItem.image = UIImage(systemName: image)
        return rootcontroller
    }
}
