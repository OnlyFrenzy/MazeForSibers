//
//  Bone.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import UIKit

struct Bone: Item {
    var coordinate: (row: Int, column: Int)
    var description: String = "Bone: Useless item"
    var image: UIImage? = UIImage(named: "bone.png")
    var name: String = "Bone"
    var isUsefull: Bool = false
    var isInInventory: Bool = false
    
    init(row: Int, column: Int) {
        self.coordinate = (row, column)
    }
}
