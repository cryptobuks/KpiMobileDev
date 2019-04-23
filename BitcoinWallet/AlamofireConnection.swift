//
//  AlamofireConnection.swift
//  BitcoinWallet
//
//  Created by Lado on 6/4/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import JWTDecode
import UIKit

class AlamofireConnection {
    weak var delegate: MainMenuViewController?
    //var delegate_login: ViewController?
    //weak var delegate_register: RegistrationViewController?
    
    func register(email: String, password: String) {
        let params: Parameters = ["password": password, "username": email]
        print(params)
        Alamofire.request("http://176.37.12.50:8364/auth/register", method: .post, parameters: params).responseJSON {
            (response) in
            print(response.response, response.data, response.request)
            print(response.result.value)
            switch response.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                var vc = RegistrationViewController()
                let response = JSON as! NSDictionary
                if let data = response.object(forKey: "token") as? NSString {
                    let res_string = "\(data)"
                    print(res_string)
                    vc.getData(res_string)
                }
                if let status = response.object(forKey: "status") as? NSString {
                    let res_status = "\(status)"
                    print(res_status)
                    vc.getStatus(res_status)
                }
//                if let dataMess = response.object(forKey: "message") as? NSString {
//                    let res = "\(dataMess)"
//                    print(res)
//                    self.delegate_register?.getData(res)
//                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                //let priceText = "0.0"
                //self.delegate?.updateBalance(priceText)
            }
        }
    }
    
    func login(email: String, password: String) {
        let params: Parameters = ["username": email, "password": password]
        print(params)
        Alamofire.request("http://176.37.12.50:8364/auth/login", method: .post, parameters: params).responseJSON {
            (response) in
            print(response.result.value)
            switch response.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                var vc = ViewController()
                let response = JSON as! NSDictionary
                if let data = response.object(forKey: "token") as? NSString {
                    let res_string = "\(data)"
                    print(res_string)
                    vc.getTks(res_string)
                    //print(self.delegate_login?.getTks(res_string))
                    //self.delegate_login?.getTks(res_string)
                    //self.delegate?.getToken(res_string)
                }
                if let status = response.object(forKey: "status") as? NSString {
                    let res_status = "\(status)"
                    print(res_status)
                    vc.getStatus(res_status)
                    //self.delegate_login?.getStatus(res_status)
                }
//                if let dataMess = response.object(forKey: "message") as? NSString {
//                    let res = "\(dataMess)"
//                    print(res)
//                    self.delegate_login?.getToks(res)
//                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                //let priceText = "0.0"
                //self.delegate?.updateBalance(priceText)
            }
        }
    }
    
    func createAddress(token: String) {
        let params: HTTPHeaders = ["x-access-token": token]
        Alamofire.request("http://176.37.12.50:8364/wallet/createAddress", method:.get, parameters: nil, headers: params).responseJSON { (request) in
            print(request.result.value)
            switch request.result {
            case .success(let js):
                print("Success with JSON: \(js)")
                
                let response = js as! NSDictionary
                if let data = response.object(forKey: "address") as? NSString {
                    let res_string = "\(data)"
                    print(res_string)
                    self.delegate?.getAddress(res_string)
                }
                if let status = response.object(forKey: "status") as? NSString {
                    let res_status = "\(status)"
                    print(res_status)
                    //self.delegate_login?.getStatus(res_status)
                }
                if let dataMess = response.object(forKey: "message") as? NSString {
                    let res = "\(dataMess)"
                    print(res)
                    //self.delegate_login?.getData(res)
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                //let priceText = "0.0"
                //self.delegate?.updateBalance(priceText)
            }
        }
    }
    
    func getBalance(token: String) {
        let params: HTTPHeaders = ["x-access-token": token]
        Alamofire.request("http://176.37.12.50:8364/wallet/getBalance", method:.get, parameters: nil, headers: params).responseJSON { (request) in
            print(request.result.value)
            switch request.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                if let data = response.object(forKey: "balance") as? NSNumber {
                    let res_string = "\(data)"
                    print(res_string)
                    self.delegate?.updateBalance(res_string)
                }
                if let dataMess = response.object(forKey: "message") as? NSString {
                    let res = "\(dataMess)"
                    print(res)
                    self.delegate?.updateBalance(res)
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                let priceText = "0.0"
                self.delegate?.updateBalance(priceText)
            }
        }
    }
    
    func sendTransaction(token: String, address: String, amount: String, comment: String) {
        //
        let params: HTTPHeaders = ["x-access-token": token, "address": address, "amount": amount, "comment": comment]
        Alamofire.request("http://176.37.12.50:8364/wallet/sendTransaction", method:.get, parameters: nil, headers: params).responseJSON {
            (request) in
            print(request.result.value)
            switch request.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                
                if let txid = response.object(forKey: "txid") as? NSString {
                    let res_string = "\(txid)"
                    print(res_string)
                }
                
                if let status = response.object(forKey: "success") as? NSString {
                    let res_stat = "\(status)"
                    print(res_stat)
                    var vc = SendViewController()
                    vc.get_status(res_stat)
                }
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func getRates(token: String) {
        let params: HTTPHeaders = ["x-access-token": token]
        Alamofire.request("http://176.37.12.50:8364/rates/btcusd", method:.get, parameters: nil, headers: params).responseJSON {
            (request) in
            print(request.result.value)
            switch request.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                if let data = response.object(forKey: "price") as? NSNumber {
                    let res_string = "\(data)"
                    print(res_string)
                    self.delegate?.updateOneBTCPrice(res_string)
                }
                
                if let change24h = response.object(forKey: "change24h") as? NSNumber {
                    let res_chnage = "\(change24h)"
                    print(res_chnage)
                    self.delegate?.updateChange24H(res_chnage)
                }
                
                if let dataMess = response.object(forKey: "message") as? NSString {
                    let res = "\(dataMess)"
                    print(res)
                    self.delegate?.updateOneBTCPrice(res)
                }
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                let priceText = "0.0"
                self.delegate?.updateOneBTCPrice(priceText)
            }
        }
    }
}
