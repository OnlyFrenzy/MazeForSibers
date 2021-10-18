//
//  Mashroom.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import UIKit

struct Mushroom: Item {
    var coordinate: (row: Int, column: Int)
    var description: String = "Mushroom: Useless Item"
    var image: UIImage? = UIImage(named: "mushroom.png")
    var name: String = "Mashroom"
    var isUsefull: Bool = false
    var isInInventory: Bool = false
    
    init(row: Int, column: Int) {
        self.coordinate = (row, column)
    }
}
