//
//  Item.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import Foundation
import UIKit

protocol Item {
    var name: String { get }
    var description: String { get }
    var image: UIImage? { get }
    var isUsefull: Bool { get }
    var isInInventory: Bool { set get }
    var coordinate: (row: Int, column: Int) { set get }
}
