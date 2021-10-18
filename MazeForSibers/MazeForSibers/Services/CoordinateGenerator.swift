//
//  CoordinateGenerator.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 18.10.2021.
//

import Foundation

class CoordinateGenerator {
    
    func emptyCoordinateInRoom(room: Room) -> (Int, Int) {
        let emptySlots = .defaultItemsSlotsValue - room.items.count
        var numberSlot = Int.random(in: 1...emptySlots)
        var coordinate = generateCoordinateFromNumber(number: numberSlot)
        
        while room.items.first(where: { $0.coordinate == coordinate }) != nil {
            numberSlot += 1
            coordinate = generateCoordinateFromNumber(number: numberSlot)
        }
        
        return coordinate
    }
    
    private func generateCoordinateFromNumber(number: Int) -> (Int, Int) {
        let row = (number - 1) / .defaultItemsSlotsHeight + 1
        let column = number % .defaultItemsSlotsWidth
        return (row, column)
    }
}
