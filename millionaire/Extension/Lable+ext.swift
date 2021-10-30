//
//  Label+ext.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import UIKit

extension UILabel {
    func animate(newText: String) {
        UIView.transition(with: self,
        duration: 0.75,
        options: .transitionCrossDissolve,
        animations: { self.text = newText })
    }
}
