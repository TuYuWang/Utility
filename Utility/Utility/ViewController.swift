//
//  ViewController.swift
//  Utility
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 MYXG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let diys = [1, 2, 3, 4]
        
        diys.accumulate(0, +)
        
        diys.accumulate(2) { (a, b) -> Int in
            return a + b
        }
        
        diys.reduce(0, +)

        diys.forEach { diy in
            print(diy)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

