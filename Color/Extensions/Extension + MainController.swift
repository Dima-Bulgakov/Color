//
//  Extension + MainController.swift
//  Color
//
//  Created by Dima on 03.06.2023.
//

import UIKit

// MARK: - Methods to convert colors
extension MainController {
    
    func hexToUIColor(_ hex: String) -> UIColor? {
        var hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        if hexString.count != 6 {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func colorToHex(_ color: UIColor) -> String? {
        guard let components = color.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        let hexString = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255))
        )
        return hexString
    }
}
