//
//  FailViewController.swift
//  BitcoinWallet
//
//  Created by Lado on 9/4/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import Lottie

class FailViewController: UIViewController {

    @IBOutlet weak var failLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var animationView: LOTAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        okButton.layer.cornerRadius = 6.0
        okButton.clipsToBounds = true
        failLabel.isHidden = true
        startAnimation()
    }
    
    //launch loading
    func startAnimation() {
        animationView.setAnimation(named: "4903-failed")
        animationView.loopAnimation = true
        animationView.play()
        
        let dispatchTime = DispatchTime.now() + 1.25
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.failLabel.isHidden = false
            self.animationView.stop()
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
