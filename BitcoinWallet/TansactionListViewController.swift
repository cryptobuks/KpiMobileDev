//
//  TansactionListViewController.swift
//  BitcoinWallet
//
//  Created by Lado on 4/4/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TansactionListViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblJSON: UITableView!
    
    var hexColor = BackGroundColor()
    
    var connect = AlamofireConnection()
    
    var back = BackGroundColor()
    
    var arrRes = [[String:AnyObject]]()
    
    var currentElement = 0
    
    var get_token = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Transactions"
        self.navigationController?.navigationBar.barTintColor = hexColor.hexStringToUIColor(hex: "#1E1F23")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barStyle = .black
        
        tblJSON.delegate = self
        tblJSON.dataSource = self
        getTransaction(token: get_token)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell", for: indexPath as IndexPath)
        
        var dict = arrRes[indexPath.row]
        
        let unixTimeStamp = dict["time"]
        let date = Date(timeIntervalSince1970: unixTimeStamp as! TimeInterval)
        let hour = Calendar.current.component(.hour, from: date)
        
        cell.textLabel?.textColor = back.hexStringToUIColor(hex: "#FFFFFF")
        cell.textLabel?.text = String(hour) + " hours ago"
        cell.detailTextLabel?.textColor = back.hexStringToUIColor(hex: "#919499")
        cell.detailTextLabel?.text = dict["address"] as? String

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 69, height: 30))
        var frame: CGRect = label.frame
        frame.origin.x = 0
        frame.origin.y = 85
        label.frame = frame
        
        //maybe this will work|
        //maybe it helps me   V
        //label.frame.origin = CGPoint(x: 0, y: 85)
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = back.hexStringToUIColor(hex: "#97C961")
        
        let amount = dict["amount"] as? NSNumber
        let res_str = String(format: "%.3f", (amount?.floatValue)!)
        
        label.text = res_str + " BTC"
        cell.accessoryView = label
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "infoTransact", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TransactionDetailViewController {
            
            if currentElement < arrRes.count {
                var dict = arrRes[currentElement]
                destination.txid = dict["txid"] as! String
                destination.addr = dict["address"] as! String
                destination.categoryies = dict["category"] as! String
                let amount = dict["amount"] as? NSNumber
                let res_str = String(format: "%.3f", (amount?.floatValue)!)
                destination.amounts = res_str
                let confrms = dict["confirmations"] as? NSNumber
                let str = confrms?.stringValue
                destination.confirms = str
                let unixTimeStamp = dict["time"]
                let date = Date(timeIntervalSince1970: unixTimeStamp as! TimeInterval)
                let hour = Calendar.current.component(.hour, from: date)
                destination.clock = String(hour) + " hour"
                currentElement += 1
            }
        }
    }
    
    //change color of status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getTransaction(token: String) {
        let params: HTTPHeaders = ["x-access-token": token]
        Alamofire.request("http://176.37.12.50:8364/wallet/getTransactions", method: .get, parameters: nil, headers: params).responseJSON {
            (request) in
            switch request.result {
            case .success(let json):
                let swiftyjson = JSON(json)
                if let adr = swiftyjson["txs"].arrayObject {
                    self.arrRes = adr as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }

}
