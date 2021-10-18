//
//  Chees.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import UIKit

struct Chees: Item {
    var coordinate: (row: Int, column: Int)
    var description: String = "Chees: You can restore hit points by using it"
    var image: UIImage? = UIImage(named: "chees.png")
    var name: String = "Chees"
    var isUsefull: Bool = true
    var isInInventory: Bool = false
    
    init(row: Int, column: Int) {
        self.coordinate = (row, column)
    }
}
