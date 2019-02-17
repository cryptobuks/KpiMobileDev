//
//  SplashScreenViewController.swift
//  CloudStorage
//
//  Created by Lado on 16/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {

    @IBOutlet private var animationView: LOTAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        startAnimation()
    }
    
    //launch loading
    func startAnimation() {
        animationView.setAnimation(named: "4170-curves-lines")
        animationView.loopAnimation = true
        animationView.play()
        
        let dispatchTime = DispatchTime.now() + 6.0
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextScreen()
        }
    }
    
    //go to login/signUp
    func nextScreen(){
        self.performSegue(withIdentifier: "goLogin", sender: self)
    }
    
    //rotation
    override open var shouldAutorotate: Bool {
        return false
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
