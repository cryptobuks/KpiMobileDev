//
//  MainMenuViewController.swift
//  BitcoinWallet
//
//  Created by Lado on 18/3/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    var addr = ""
    
    var token_ = ""
    
    @IBOutlet weak var labelTitle: UILabel!
    
    var connect = AlamofireConnection()
    var settings = SettingsViewController()
    
    var backColor = BackGroundColor()
    
    @IBOutlet weak var imageUpDown: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var OneBTCPriceLabel: UILabel!
    
    @IBOutlet weak var FirstNumberBalance: UILabel!
    
    @IBOutlet weak var LastNumberBalance: UILabel!
    
    @IBOutlet weak var changeBTCrate: UILabel!
    
    @IBOutlet weak var receivingBtn: UIButton!
    @IBAction func receiving(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "receive") as! QRCodeGenerateViewController
        vc.addr = addr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var sendingBtn: UIButton!
    @IBAction func sending(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "sendingss") as! SendViewController
        vc._token = token_
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var transactionsBtn: UIButton!
    @IBAction func tranasctions(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "transactionss") as! TansactionListViewController
        vc.get_token = token_
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBOutlet weak var settingsBtn: UIButton!
    @IBAction func settings(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "settingss")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        receivingBtn.layer.cornerRadius = 6.0

        sendingBtn.layer.cornerRadius = 6.0

        transactionsBtn.layer.cornerRadius = 6.0

        settingsBtn.layer.cornerRadius = 6.0
        
        connect.delegate = self
        
        if let labelname = UserDefaults.standard.value(forKey: "labelname") as? String {
            labelTitle.text = labelname
        }
        
        print("RTBSVK")
        if let toks = UserDefaults.standard.value(forKey: "tokens") as? String {
            token_ = toks
        }
        print(token_)
        connect.createAddress(token: token_)
        connect.getRates(token: token_)
        connect.getBalance(token: token_)
        updatePrice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //change color of status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func updatePrice() {
        //let res = (OneBTCPriceLabel.text as! NSString).floatValue * (FirstNumberBalance.text as! NSString).floatValue
        if let balance = UserDefaults.standard.value(forKey: "balance") as? String {
            if let onebtcprice = UserDefaults.standard.value(forKey: "onebtcprice") as? String {
                var res = (balance as! NSString).floatValue * (onebtcprice as! NSString).floatValue
                print(res)
                priceLabel.text = "$" + String(format: "%.2f", res)
            }
        }
        //print(res)
        //priceLabel.text = "$\(res)"
        //priceLabel.text = "$691.64"
    }
    
    //нижнее подчеркиание нужно что бы не прописывать имя параметра
    func getAddress(_ data: String) {
        print("QQQQQQ")
        print(data)
        addr = data
    }
    
    func updateBalance(_ data: String) {
        if data == "No token provided." {
            let alertController = UIAlertController(title: "Error", message: data, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let res = (data as! NSString).floatValue
            let res_str = String(format: "%.3f", res)
            let res_new_str = String(format: "%.5f", res)
            UserDefaults.standard.setValue(res_new_str, forKey: "balance")
            UserDefaults.standard.synchronize()
            FirstNumberBalance.text = res_str
            let (wholePart, fractPart) = modf(res)
            let firstTwoDecimalPlaces = Int(fractPart * 1000)
            LastNumberBalance.text = String(firstTwoDecimalPlaces)
        }
    }
    
    func updateOneBTCPrice(_ data: String) {
        if data == "Failed to authenticate token." {
            let alertController = UIAlertController(title: "Error", message: data, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            UserDefaults.standard.setValue(data, forKey: "onebtcprice")
            UserDefaults.standard.synchronize()
            OneBTCPriceLabel.text = "$" + data
        }
    }
    
    func updateChange24H(_ data: String) {
        let res = (data as! NSString).floatValue
        let res_str = String(format: "%.3f", res)
        if res_str.contains("-") {
            var image: UIImage = UIImage(named: "down")!
            imageUpDown.image = image
            changeBTCrate.textColor = backColor.hexStringToUIColor(hex: "#D37377")
            changeBTCrate.text = res_str + "%"
        } else {
            var image: UIImage = UIImage(named: "up")!
            imageUpDown.image = image
            changeBTCrate.textColor = backColor.hexStringToUIColor(hex: "#97C961")
            changeBTCrate.text = res_str + "%"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
