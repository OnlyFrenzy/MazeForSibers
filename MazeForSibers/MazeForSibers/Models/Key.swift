//
//  Key.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import UIKit

struct Key: Item {
    
    var coordinate: (row: Int, column: Int)
    var description: String = "Key: You can open chest"
    var image: UIImage? = UIImage(named: "key.png")
    var name: String = "Key"
    var isUsefull: Bool = false
    var isInInventory: Bool = false
    
    init(row: Int, column: Int) {
        self.coordinate = (row, column)
    }
}
