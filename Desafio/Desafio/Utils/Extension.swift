//
//  Extension.swift
//  Desafio
//
//  Created by leonardo fernandes farias on 27/11/2017.
//  Copyright © 2017 Tiago. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UILabel {
    func ajustFontWidth() {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.2
    }
}


extension UINavigationController {
    func showHUB() {
        let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
        hub.mode = .indeterminate
        hub.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        hub.graceTime = 1.0
        hub.minShowTime = 1.0
    }
    
    func hideHUB() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
}
