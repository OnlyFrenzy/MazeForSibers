//
//  PlayerGenerator.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import Foundation

class PlayerGenerator {
    
    var player: Player
    var mazeHeigth: Int
    var mazeWidth: Int
    
    internal init(player: Player = Player(), mazeHeigth: Int, mazeWidth: Int) {
        self.player = player
        self.mazeHeigth = mazeHeigth
        self.mazeWidth = mazeWidth
    }
    
    func generatePlayer() -> Player {
        generateVerticalCoordinate()
        generateHorizontalCoordinate()
        generateHitPoints()
        
        return player
    }
    
    private func generateVerticalCoordinate() {
        player.changeVerticalCoordinate(verticalCoordinate: Int.random(in: 0..<mazeHeigth))
    }
    
    private func generateHorizontalCoordinate() {
        player.changeHorizontalCoordinate(horizontalCoordinate: Int.random(in: 0..<mazeWidth))
    }
    
    private func generateHitPoints() {
        let minHitPoints = mazeWidth * mazeHeigth / 2
        let maxHitPoints = mazeWidth * mazeHeigth
        player.changeHitPoints(variationHitPoints: Int.random(in: minHitPoints...maxHitPoints))
    }
}
