//
//  PaddingBottomTextField.swift
//  BitcoinWallet
//
//  Created by Lado on 26/2/19.
//  Copyright © 2019 Lado. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
