//
//  Stone.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import UIKit

struct Stone: Item {
    
    var description: String = "Stone: Useless item"
    var image: UIImage? = UIImage(named: "stone.png")
    var name: String = "Stone"
    var isUsefull: Bool = false
    var isInInventory: Bool = false
    var coordinate: (row: Int, column: Int)
    
    init(row: Int, column: Int) {
        self.coordinate = (row, column)
    }
}
