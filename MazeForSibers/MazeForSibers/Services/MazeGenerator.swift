//
//  MazeGenerator.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 14.10.2021.
//

import Foundation

class MazeGenerator {
    
    var mazeHeigth: Int
    var mazeWidth: Int
    var maze = [[Room]]()
    
    internal init(mazeHeigth: Int, mazeWidth: Int) {
        self.mazeHeigth = mazeHeigth
        self.mazeWidth = mazeWidth
        
        var newMaze : [[Room]] = []
        for i in 0..<mazeHeigth {
            newMaze.append([])
            for _ in 0..<mazeWidth{
                newMaze[i].append(Room())
            }
        }
        self.maze = newMaze
    }
    
    func generateMaze() -> [[Room]]? {
        
        if mazeHeigth < 2 ||
            mazeWidth < 2 {
            return nil
        }
        
        fillFirstLine()
        createRightWalls(line: 0)
        createBottomWalls(line: 0)
        
        for i in 1..<mazeHeigth {
            copyLine(line: i)
            deleteRightWalls(line: i)
            deleteVarietyWithBottomWall(line: i)
            deleteBottomWalls(line: i)
            fillLine(line: i)
            createRightWalls(line: i)
            createBottomWalls(line: i)
        }
        
        fillLastLine()
        
        printMaze()
        return maze
    }
    
    private func fillFirstLine() {
        var varietyCounter = 1
        
        maze[0][0].changeLeftWallState(isLeftWall: true)
        
        for i in 0..<mazeWidth {
            maze[0][i].changeTopWallState(isTopWall: true)
            maze[0][i].changeVariety(variety: varietyCounter)
            varietyCounter += 1
        }
        
        maze[0][mazeWidth-1].changeRightWallState(isRightWall: true)
    }
    
    private func fillLine(line: Int) {
        var varietyCounter = (line+1)*mazeWidth
        
        for i in 0..<mazeWidth{
            if maze[line][i].variety == 0 {
                maze[line][i].changeVariety(variety: varietyCounter)
                varietyCounter += 1
            }
        }
    }
    
    func fillLastLine() {
        for i in 0..<mazeWidth-1{
            maze[mazeHeigth-1][i].changeBottomWallState(isBottomWall: true)
            
            if maze[mazeHeigth-1][i].variety != maze[mazeHeigth-1][i+1].variety{
                maze[mazeHeigth-1][i].changeRightWallState(isRightWall: false)
                maze[mazeHeigth-1][i+1].changeLeftWallState(isLeftWall: false)
            }
            
            if maze[mazeHeigth-2][i].isBottomWall {
                maze[mazeHeigth-1][i].changeTopWallState(isTopWall: true)
            }
        }
        
        if maze[mazeHeigth-2][mazeWidth-1].isBottomWall {
            maze[mazeHeigth-1][mazeWidth-1].changeTopWallState(isTopWall: true)
        }
        
        maze[mazeHeigth-1][mazeWidth-1].changeBottomWallState(isBottomWall: true)
    }
    
    private func createRightWalls(line: Int) {
        
        for i in 0..<(mazeWidth-1) {
            
            if maze[line][i].variety == maze[line][i+1].variety {
                maze[line][i].changeRightWallState(isRightWall: true)
                maze[line][i+1].changeLeftWallState(isLeftWall: true)
            }
            
            let randomInt = Int.random(in: 0...10)
            
            if randomInt < 7 {
                maze[line][i+1].changeVariety(variety: maze[line][i].variety)
            } else {
                maze[line][i].changeRightWallState(isRightWall: true)
                maze[line][i+1].changeLeftWallState(isLeftWall: true)
            }
        }
    }
    
    private func createBottomWalls(line: Int) {
        for i in 0..<mazeWidth {
            let randomInt = Int.random(in: 0...10)
            if randomInt < 7 {
                maze[line][i].changeBottomWallState(isBottomWall: true)
            }
        }
        
        fixIsolatedAreas(line: line)
    }
    
    private func fixIsolatedAreas(line: Int) {
        var startIndexOfVariety = 0
        var endIndexOfVariety = 0
        var cursor = 0
        var randomInt : Int
        var check : Bool
        
        while cursor < mazeWidth-1 {
            check = false
            
            while maze[line][cursor].variety == maze[line][cursor+1].variety {
                cursor += 1
                endIndexOfVariety = cursor
                if cursor >= mazeWidth - 1 {
                    break
                }
            }
            
            check = searchIsolationInIdexes(startIndexOfVariety: startIndexOfVariety,
                                                 endIndexOfVariety: endIndexOfVariety,
                                                 line: line)
            
            if !check {
                randomInt = Int.random(in: startIndexOfVariety...endIndexOfVariety)
                maze[line][randomInt].changeBottomWallState(isBottomWall: false)
            }
            
            cursor += 1
            startIndexOfVariety = cursor
            endIndexOfVariety = cursor
        }
        
        checkLastRoomBottomWall(line: line)
    }
    
    private func searchIsolationInIdexes(startIndexOfVariety: Int, endIndexOfVariety: Int, line: Int) -> Bool {
        
        for i in startIndexOfVariety...endIndexOfVariety {
            if maze[line][i].isBottomWall == false {
                return true
            }
        }
        
        return false
    }
    
    private func checkLastRoomBottomWall(line: Int)  {
        if maze[line][mazeWidth-2] != maze[line][mazeWidth-1] {
            if maze[line][mazeWidth-1].isBottomWall {
                maze[line][mazeWidth-1].changeBottomWallState(isBottomWall: false)
            }
        }
    }
    
    private func copyLine(line: Int) {
        
        for i in 0..<mazeWidth {
            guard let newRoom = maze[line-1][i].copy() as? Room else { return }
            maze[line][i] = newRoom
        }
        
        for i in 0..<mazeWidth {
            if !maze[line-1][i].isBottomWall {
                maze[line][i].changeTopWallState(isTopWall: false)
            }
        }
    }
    
    private func deleteRightWalls(line: Int) {
        for i in 0..<mazeWidth-1 {
            maze[line][i].changeRightWallState(isRightWall: false)
            maze[line][i+1].changeLeftWallState(isLeftWall: false)
        }
    }
    
    private func deleteBottomWalls(line: Int) {
        for i in 0..<mazeWidth {
            maze[line][i].changeBottomWallState(isBottomWall: false)
        }
    }
    
    private func deleteVarietyWithBottomWall(line: Int) {
        for i in 0..<mazeWidth {
            if maze[line][i].isBottomWall {
                maze[line][i].changeVariety(variety: 0)
            }
        }
    }
    
    private func printMaze() {
        var stringMaze : [[String]] = []
        
        for i in 0..<mazeHeigth*3 {
            stringMaze.append([])
            for _ in 0..<mazeWidth*3 {
                stringMaze[i].append(" ")
            }
        }
        for i in 0..<mazeHeigth {
            for j in 0..<mazeWidth {
                if maze[i][j].isBottomWall {
                    stringMaze[i*3+2][j*3] = "#"
                    stringMaze[i*3+2][j*3+1] = "#"
                    stringMaze[i*3+2][j*3+2] = "#"
                }
                if maze[i][j].isTopWall {
                    stringMaze[i*3][j*3] = "#"
                    stringMaze[i*3][j*3+1] = "#"
                    stringMaze[i*3][j*3+2] = "#"
                }
                if maze[i][j].isRightWall {
                    stringMaze[i*3][j*3+2] = "#"
                    stringMaze[i*3+1][j*3+2] = "#"
                    stringMaze[i*3+2][j*3+2] = "#"
                }
                if maze[i][j].isLeftWall {
                    stringMaze[i*3][j*3] = "#"
                    stringMaze[i*3+1][j*3] = "#"
                    stringMaze[i*3+2][j*3] = "#"
                }
            }
        }
        for i in 0..<mazeHeigth*3 {
            for j in 0..<mazeWidth*3 {
                print(stringMaze[i][j], terminator:"")
            }
            print()
        }
    }
}
