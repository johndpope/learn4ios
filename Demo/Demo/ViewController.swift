//
//  ViewController.swift
//  Demo
//
//  Created by Luan Guangmiao on 27/03/2018.
//  Copyright © 2018 Guangmiao Luan. All rights reserved.
//

import UIKit
import Learn4iOS
import Tensor4iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let a = Tensor(data: [1,2,3], shape: [3])
        let b = Tensor(data: [2, 1], shape: [2, 1])
        let c = a + b

        print(c)

        let k = parameter(a)
        print(k)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

