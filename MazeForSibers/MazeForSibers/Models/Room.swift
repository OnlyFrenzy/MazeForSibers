//
//  Room.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import Foundation

class Room: NSObject {
    
    private(set) var isLeftWall: Bool
    private(set) var isTopWall: Bool
    private(set) var isRightWall: Bool
    private(set) var isBottomWall: Bool
    private(set) var variety: Int
    private(set) var items = [Item]()
    
    internal init(isLeftWall: Bool = false,
                  isTopWall: Bool = false,
                  isRightWall: Bool = false,
                  isBottomWall: Bool = false,
                  variety: Int = 0) {
        
        self.isLeftWall = isLeftWall
        self.isTopWall = isTopWall
        self.isRightWall = isRightWall
        self.isBottomWall = isBottomWall
        self.variety = variety
    }
    
    func changeLeftWallState(isLeftWall: Bool) {
        self.isLeftWall = isLeftWall
    }
    
    func changeTopWallState(isTopWall: Bool) {
        self.isTopWall = isTopWall
    }
    
    func changeRightWallState(isRightWall: Bool) {
        self.isRightWall = isRightWall
    }
    
    func changeBottomWallState(isBottomWall: Bool) {
        self.isBottomWall = isBottomWall
    }
    
    func changeVariety(variety: Int) {
        self.variety = variety
    }
    
    func appendItem(item: Item) {
        self.items.append(item)
    }
    
    func removeItem(item: Item) {
        guard let searchedItem = self.items.enumerated().first(where: { $0.element.coordinate == item.coordinate }) else { return }
        self.items.remove(at: searchedItem.offset)
    }
}

extension Room: NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        
        let copy = Room(isLeftWall: self.isLeftWall,
                        isTopWall: self.isTopWall,
                        isRightWall: self.isRightWall,
                        isBottomWall: self.isBottomWall,
                        variety: self.variety)
        return copy
    }
}
