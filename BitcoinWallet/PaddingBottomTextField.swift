//
//  PaddingBottomTextField.swift
//  BitcoinWallet
//
//  Created by Lado on 26/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField
import TKFormTextField

extension SkyFloatingLabelTextField {
    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


extension TKFormTextField {
    func setPaddings() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setBottomBorders() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
