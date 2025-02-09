//
//  UIFont+FontStyles.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/7/24.
//

import UIKit

extension UIFont {
    struct FontStyles {
        private let fontName: String
        
        init(name: String) {
            self.fontName = name
        }
        
        func withSize(_ size: CGFloat) -> UIFont? {
            UIFont(name: fontName, size: size)
        }
    }
    
    static let rooneySansRegular: FontStyles = FontStyles(name: "RooneySans-Regular")
    static let rooneySansBold: FontStyles = FontStyles(name: "RooneySans-Bold")
}
