//
//  FinishGenerator.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import Foundation

class FinishGenerator {
    
    var finish: Finish
    var player: Player
    var mazeHeigth: Int
    var mazeWidth: Int
    
    internal init(finish: Finish = Finish(), player: Player, mazeHeigth: Int, mazeWidth: Int) {
        self.finish = finish
        self.player = player
        self.mazeHeigth = mazeHeigth
        self.mazeWidth = mazeWidth
    }
    
    func generateFinish() -> Finish {
        generateCoordinates()
        
        return finish
    }
    
    private func generateCoordinates() {
        
        let randomVerticalCoordinate = Int.random(in: 0..<mazeHeigth)
        let randomHorizontalCoordinate = Int.random(in: 0..<mazeWidth)
        
        finish.changeHorizontalCoordinate(horizontalCoordinate: randomHorizontalCoordinate)
        finish.changeVerticalCoordinate(verticalCoordinate: randomVerticalCoordinate)
        
        if finish.verticalCoordinate == player.verticalCoordinate &&
            finish.horizontalCoordinate == player.horizontalCoordinate {
            generateCoordinates()
        }
    }
}
