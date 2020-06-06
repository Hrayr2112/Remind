//
//  MainRoutingService.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class MainRoutingService {
    
    static func openApplication(from viewController: UIViewController,
                                animated: Bool = true) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        if let tabBar = vc as? UITabBarController {
            tabBar.selectedIndex = 1
        }
        viewController.navigationController?.setViewControllers([vc], animated: animated)
    }
    
}
