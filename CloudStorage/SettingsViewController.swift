//
//  SettingsViewController.swift
//  CloudStorage
//
//  Created by Lado on 14/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var DarkMode: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func DarkModeAction(_ sender: Any) {
        if DarkMode.isOn == true {
            self.view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
            
        } else {
            self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
