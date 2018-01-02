//
//  ViewController.swift
//  Utility
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 MYXG. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        utility()
        
        alamofire()

    }

    fileprivate func utility() {
    
        let diys = [1, 2, 3, 4]
        
        diys.accumulate(0, +)
        
        diys.accumulate(2) { (a, b) -> Int in
        return a + b
        }
        
        diys.reduce(0, +)
        
        diys.forEach { diy in
        //            print(diy)
        }
        
        view.backgroundColor = "#bac8e1".ul.hex
        
        let str = "12345678"
        print(str.dropLast(2))
        
        let array = Array(str)
        
        print(String(array[0..<2]))
        
        
        print("md5: \(str.ul.md5.str!)")
        print("md5: \(str.ul.md5.data!)")
    }
    
    fileprivate func alamofire() {
        Alamofire.request("https://httpbin.org/get").responseJSON { (response) in
            
            debugPrint("All Response Info: \(response)")
            
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Result: \(String(describing: response.result))")

            if let json  = response.result.value {
                print("JOSN: \(json)")
            }
            
            if let data = response.data, let utf8Text = String.init(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
        
        //more handler
        Alamofire.request("https://httpbin.org/get").responseString { (response) in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value!)")
            }
            .responseJSON { (response) in
                print("Response JSON: \(response.result.value!)")
        }
        
        //validation
        Alamofire.request("https://httpbin.org/get")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { (response) in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
        }
        
        //encoding
        Alamofire.request("https://httpbin.org/get", method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            print(response.result.value!)
        }
    }

}

