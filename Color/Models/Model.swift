//
//  ColorModel.swift
//  Color
//
//  Created by Dima on 01.06.2023.
//

import UIKit

final class ColorModel {
    private var red: CGFloat
    private var green: CGFloat
    private var blue: CGFloat
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = CGFloat(red)
        self.green = CGFloat(green)
        self.blue = CGFloat(blue)
    }
    
    func setRed(red: Float) {
        self.red = CGFloat(red)
    }
    
    func setGreen(green: Float) {
        self.green = CGFloat(green)
    }
    
    func setBlue(blue: Float) {
        self.blue = CGFloat(blue)
    }
    
    func getColor() -> UIColor {
        let color = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
        return color
    }
}
