//
//  ViewController.swift
//  Utility
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 MYXG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        utility()
        
//        alamofire()

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
        
        
        print("md5: \(str.ul.md5)")
        print("md5: \(str.ul.md5.data!)")

        print("img: \("2".ul.img!)")
        
        let float: CGFloat = 2
        
        print("CGFloat: \(float.ul.vpx)")
        print("CGFloat: \(CGFloat(float.hashValue))")

        let md5 = str.ul.md5
        print(md5)
        
        print(100.ul.vpx)
        print(100.ul.hpx)
        print(2.0.ul.vpx)
        
        
        print("12333".ul.isPhone)
        print("@163.com".ul.isEmail)
        print("_aas".ul.isName)
        print("123456".ul.isPassword)
        print("3508211993110".ul.isIDCard)
        
        for prefix in PrefixSequence(string: "Hello") {
            print(prefix)
        }
        let dic = ["A": "a", "B": "b", "C": ["1", "2", "3"]] as [String : Any]
        let json = JSON(dic)
        print(json["C", 1])
        
        
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
            print(JSON(response.result.value!))
        }
    }

}

struct Test {}
//extension Test: Collection {
//    
//}

