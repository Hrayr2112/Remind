//
//  ViewController.swift
//  Remind
//
//  Created by Hrayr Yeghiazaryan on 06.06.2020.
//  Copyright © 2020 Remind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: REMOVE THIS SAMPLE
        
        let service = RequestService()
        service.createClassroom(name: "Sample") { result in
            switch result {
            case let .success(response):
                
                break
            case let .failure(error):
                
                break
            }
        }
    }

}

