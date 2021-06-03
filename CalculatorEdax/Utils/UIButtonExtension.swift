//
//  ExtensionButton.swift
//  CalculatorEdax
//
//  Created by Miguel Ledezma on 02/06/21.
//

import UIKit

extension UIButton {
    
    //Borde redondeado
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    //Brilla
    func shine() {
        UIView.animate(withDuration: 0.05, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.05, animations: {
                self.alpha = 1
            })
        }
    }
    
    
}

