//
//  Player.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import Foundation

struct Player {
    
    private(set) var items = [Item]()
    private(set) var hitPoints = 0
    private(set) var verticalCoordinate = 0
    private(set) var horizontalCoordinate = 0
    
    mutating func changeVerticalCoordinate(verticalCoordinate: Int) {
        self.verticalCoordinate += verticalCoordinate
    }
    
    mutating func changeHorizontalCoordinate(horizontalCoordinate: Int) {
        self.horizontalCoordinate += horizontalCoordinate
    }
    
    mutating func changeHitPoints(variationHitPoints: Int) {
        self.hitPoints += variationHitPoints
    }
    
    mutating func appendItem(item: Item) {
        self.items.append(item)
    }
    
    mutating func removeItem(item: Item) {
        guard let searchedItem = self.items.enumerated().first(where: { $0.element.name == item.name }) else { return }
        self.items.remove(at: searchedItem.offset)
    }
}
