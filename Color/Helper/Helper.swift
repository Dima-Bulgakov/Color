//
//  Helper.swift
//  Color
//
//  Created by Dima on 03.06.2023.
//

import UIKit

enum Helper {
    
    enum Image {
        static let backgroundImage = UIImage(named: "back1")
    }
    
    enum Color {
        static let addButton = #colorLiteral(red: 0.192312386, green: 0.1262226701, blue: 0.1454250515, alpha: 1)
        static let mainWhite = UIColor.systemBackground
    }
    
    enum Text {
        static let addButtonTitle = "Add Color"
        static let redLabel = "Red"
        static let greenLabel = "Green"
        static let blueLabel = "Blue"
        static let cellIdentifier = "cell"
    }
}

