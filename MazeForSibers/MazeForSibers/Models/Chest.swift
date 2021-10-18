//
//  Chest.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import UIKit

struct Chest: Item {
    
    var coordinate: (row: Int, column: Int)
    var description: String = "Chest: Need key for open"
    var image: UIImage? = UIImage(named: "chest.png")
    var name: String = "Chest"
    var isUsefull: Bool = false
    var isInInventory: Bool = false
    
    init(row: Int, column: Int) {
        self.coordinate = (row, column)
    }
}
