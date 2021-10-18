//
//  Finish.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import Foundation

struct Finish {
    
    private(set) var verticalCoordinate = 0
    private(set) var horizontalCoordinate = 0
    
    mutating func changeVerticalCoordinate(verticalCoordinate: Int) {
        self.verticalCoordinate = verticalCoordinate
    }
    
    mutating func changeHorizontalCoordinate(horizontalCoordinate: Int) {
        self.horizontalCoordinate = horizontalCoordinate
    }
}
