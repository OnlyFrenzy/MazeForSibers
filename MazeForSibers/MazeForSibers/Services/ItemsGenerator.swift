//
//  ItemsGenerator.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import Foundation

class ItemsGenerator {
    
    var maze: [[Room]]
    var finish: Finish
    var coordinateGenerator: CoordinateGenerator?
    
    internal init(maze: [[Room]], finish: Finish) {
        self.maze = maze
        self.finish = finish
        self.coordinateGenerator = CoordinateGenerator()
    }
    
    func generateItems() -> [[Room]] {
        
        maze.forEach({ $0.forEach { room in
            
            generateItemsInRoom(room: room)
        }})
        
        generateChest()
        generateKey()
        return maze
    }
    
    private func generateChest() {
        let room = maze[finish.verticalCoordinate][finish.horizontalCoordinate]
        
        guard let coordinate = coordinateGenerator?.emptyCoordinateInRoom(room: room) else { return }
        
        maze[finish.verticalCoordinate][finish.horizontalCoordinate].appendItem(item: Chest(row: coordinate.0, column: coordinate.1))
    }
    
    private func generateKey() {
        let randomVerticalKeyCoordinate = Int.random(in: 0..<maze.count)
        let randomHorizontalKeyCoordinate = Int.random(in: 0..<maze[0].count)
        let room = maze[randomVerticalKeyCoordinate][randomHorizontalKeyCoordinate]
        
        guard let coordinate = coordinateGenerator?.emptyCoordinateInRoom(room: room) else { return }
        
        maze[randomVerticalKeyCoordinate][randomHorizontalKeyCoordinate].appendItem(item: Key(row: coordinate.0, column: coordinate.1))
    }
    
    private func generateItemsInRoom(room: Room) {
        for _ in 0...Int.random(in: 0...(.defaultMaxItemsInRoomValue)) {
            
            guard let coordinate = coordinateGenerator?.emptyCoordinateInRoom(room: room) else { return }
            
            guard let item = generateItem(row: coordinate.0, column: coordinate.1) else { return }
            
            room.appendItem(item: item)
        }
    }
    
    private func generateItem(row: Int, column: Int) -> Item? {
        let randomInt = Int.random(in: 1...4)
        let itemId = Items(rawValue: randomInt)
        
        switch itemId {
            
        case .stone:
            return Stone(row: row, column: column)
            
        case .mashroom:
            return Mushroom(row: row, column: column)
            
        case .bone:
            return Bone(row: row, column: column)
            
        case .chees:
            return Chees(row: row, column: column)
            
        default:
            return nil
        }
    }
}
