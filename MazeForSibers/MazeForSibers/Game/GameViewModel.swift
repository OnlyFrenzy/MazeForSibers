//
//  GameViewModel.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 15.10.2021.
//

import Foundation
import UIKit

class GameViewModel {
    
    private var maze: [[Room]]
    private var player: Player
    private var finish: Finish
    private var selectedItem: Item?
    weak var delegate: GameViewControllerDelegate?
    private var youLoseCallBack: (() -> Void)?
    private var coordinateGenerator: CoordinateGenerator?
    
    internal init(maze: [[Room]], player: Player, finish: Finish) {
        self.maze = maze
        self.player = player
        self.finish = finish
        self.coordinateGenerator = CoordinateGenerator()
    }
    
    
    func playerItems() -> [Item] {
        return player.items
    }
    
    func itemsInRoom() -> [Item] {
        return maze[player.verticalCoordinate][player.horizontalCoordinate].items
    }
    
    func useButtonDidTap() {
        guard let selectedItem = selectedItem else { return }
        
        if selectedItem is Chees {
            player.changeHitPoints(variationHitPoints: .randomHitPoints)
            player.removeItem(item: selectedItem)
            delegate?.changeHitPointValue()
            delegate?.refreshInventory()
        }
    }
    
    func dropButtonDidTap() {
        guard var item = selectedItem else { return }
        let room = maze[player.verticalCoordinate][player.horizontalCoordinate]
        
        player.removeItem(item: item)
        item.isInInventory = false
        
        if room.items.count < .defaultItemsSlotsValue {
            guard let coordinate = coordinateGenerator?.emptyCoordinateInRoom(room: room) else { return }
            item.coordinate = coordinate
            room.appendItem(item: item)
        }
        
        delegate?.refresh()
    }
    
    func discardButtonDidTap() {
        guard let item = selectedItem else { return }
        player.removeItem(item: item)
        delegate?.refreshInventory()
    }
    
    func openButtonDidTap() {
        if player.items.contains(where: { $0 is Key }) {
            let endGameViewModel = WinViewModel()
            pushEndScreen(endViewModel: endGameViewModel)
        } else {
            delegate?.pushAlert(title: .haventKeyTitle,
                                               errorMessage: .haventKeyErrorMessage,
                                               actionTitle: .haventKeyActionTitle)
        }
    }
    
    func directionButtonDidTap(direction: Direction) {
        switch direction {
            
        case .top:
            player.changeVerticalCoordinate(verticalCoordinate: -1)
            
        case .right:
            player.changeHorizontalCoordinate(horizontalCoordinate: 1)
            
        case .bottom:
            player.changeVerticalCoordinate(verticalCoordinate: 1)
            
        case .left:
            player.changeHorizontalCoordinate(horizontalCoordinate: -1)
        }
        
        player.changeHitPoints(variationHitPoints: -1)
        
        delegate?.reloadGameView()
        
        if player.hitPoints <= 0 {
            let endGameViewModel = LoseViewModel()
            pushEndScreen(endViewModel: endGameViewModel)
        }
    }
    
    func backButtonDidTap() {
        delegate?.dismissViewController()
    }
    
    private func pushEndScreen(endViewModel: EndViewModel) {
        delegate?.pushNextScreen(endViewModel: endViewModel)
    }
    
    private func isChest(item: Item) -> Bool {
        return item is Chest
    }
    
    private func isInventoryFull() -> Bool {
        return player.items.count >= .defaultItemsSlotsInventory
    }
    
    private func roomWithPlayer() -> Room {
        return maze[player.verticalCoordinate][player.horizontalCoordinate]
    }
    
    private func playerHitPointsValue() -> String {
        return String(player.hitPoints)
    }
    
    func lifeLabelTextAlignment() -> NSTextAlignment {
        return .lifeLabelTextAlignment
    }
    
    func lifeLabelFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.defaultFontSize)
    }
    
    func backButtonTitleLabelFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.defaultFontSize)
    }
    
    func backButtonTitleColor() -> UIColor {
        return .defaultButtonTitleColor
    }
    
    func backButtonBackgroundColor() -> UIColor {
        return .backButtonBackgroundColor
    }
    
    func backButtonTitle() -> String {
        return .backButtonTitle
    }
    
    func inventoryViewBackgroundColor() -> UIColor {
        return .inventoryViewBackgroundColor
    }
    
    func inventoryLabelTextAlignment() -> NSTextAlignment {
        return .defaultLabelTextAlignment
    }
    
    func inventoryLabelFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.defaultFontSize)
    }
    
    func inventoryLabelTitle() -> String {
        return .inventoryLabelTitle
    }
    
    func inventoryCopacity() -> CGFloat {
        return CGFloat(Int.defaultItemsSlotsInventory)
    }
    
    func itemsStackViewAlignment() -> UIStackView.Alignment {
        return .inventoryStackViewAlignment
    }
    
    func descriptionLabelTextAlignment() -> NSTextAlignment {
        return .defaultLabelTextAlignment
    }
    
    func descriptionLabelFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.defaultFontSize)
    }
    
    func descriptionLabelMinimumScaleFactor() -> CGFloat {
        return .defaultScaleFactor
    }
    
    func inventoryButtonsFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.defaultFontSize)
    }
    
    func inventoryButtonTitleColor() -> UIColor {
        return .defaultButtonTitleColor
    }
    
    func inventoryButtonBackgroundColor() -> UIColor {
        return .inventoryButtonBackgroundColor
    }
    
    func useButtonTitle() -> String {
        return .useButtonTitle
    }
    
    func dropButtonTitle() -> String {
        return .dropButtonTitle
    }
    
    func discardButtonTitle() -> String {
        return .discardButtonTitle
    }
    
    func openButtonTitle() -> String {
        return.openButtonTitle
    }
    
    func topMoveImage() -> UIImage? {
        return UIImage(named: .topMoveImageName)?.withTintColor(.black)
    }
    
    func rightMoveImage() -> UIImage? {
        return UIImage(named: .rightMoveImageName)?.withTintColor(.black)
    }
    
    func bottomMoveImage() -> UIImage? {
        return UIImage(named: .bottomMoveImageName)?.withTintColor(.black)
    }
    
    func leftMoveImage() -> UIImage? {
        return UIImage(named: .leftMoveImageName)?.withTintColor(.black)
    }
    
    func isTopWall() -> Bool {
        return roomWithPlayer().isTopWall
    }
    
    func isRightWall() -> Bool {
        return roomWithPlayer().isRightWall
    }
    
    func isBottomWall() -> Bool {
        return roomWithPlayer().isBottomWall
    }
    
    func isLeftWall() -> Bool {
        return roomWithPlayer().isLeftWall
    }
    
    func lifeLabelTitle() -> String {
        return (.lifeLabelTitle + playerHitPointsValue())
    }
    
    func itemDidTap(item: Item) {
        
        if item is Chest {
            delegate?.itemIsChest(description: item.description)
            return
        }
        
        if selectItem(item: item) {
            delegate?.updateInventoryView(description: item.description,
                                          isUseButtonHidden: !item.isUsefull,
                                          isDropButtonHidden: false,
                                          isDiscardButtonHidden: false,
                                          isOpenButtonHidden: true)
            return
        }
        
        delegate?.refresh()
    }
    
    func selectItem(item: Item) -> Bool {
        if item.isInInventory {
            selectedItem = item
            return true
        }
        
        if isInventoryFull() {
            delegate?.pushAlert(title: .inventoryIsFullTitle,
                                errorMessage: .inventoryIsFullErrorMessage,
                                actionTitle: .inventoryIsFullActionTitle)
            return false
        }
        
        var mutableItem = item
        mutableItem.isInInventory = true
        player.appendItem(item: mutableItem)
        maze[player.verticalCoordinate][player.horizontalCoordinate].removeItem(item: item)
        return false
    }
}

fileprivate extension Int {
    static let randomHitPoints = Int.random(in: 10...20)
}

fileprivate extension NSTextAlignment {
    static let lifeLabelTextAlignment: NSTextAlignment = .left
    static let defaultLabelTextAlignment: NSTextAlignment = .center
}

fileprivate extension UIStackView.Alignment {
    static let inventoryStackViewAlignment: UIStackView.Alignment = .leading
}

fileprivate extension CGFloat {
    static let defaultFontSize: CGFloat = 16
    static let defaultScaleFactor: CGFloat = 0.2
}

fileprivate extension UIColor {
    static let backButtonBackgroundColor: UIColor = .red.withAlphaComponent(0.5)
    static let inventoryViewBackgroundColor: UIColor = .brown
    static let inventoryButtonBackgroundColor: UIColor = .white.withAlphaComponent(0.5)
}

fileprivate extension String {
    static let backButtonTitle = "Back"
    static let lifeLabelTitle = "Hit points left: "
    static let inventoryLabelTitle = "Inventory"
    static let useButtonTitle = "Use"
    static let dropButtonTitle = "Drop"
    static let discardButtonTitle = "Discard"
    static let openButtonTitle = "Open"
    
    static let inventoryIsFullTitle = "Inventory is full"
    static let inventoryIsFullErrorMessage = "Inventory is full. You can drop unwanted items"
    static let inventoryIsFullActionTitle = "OK"
    
    static let haventKeyTitle = "You haven't key!"
    static let haventKeyErrorMessage = "For open chest you must have key."
    static let haventKeyActionTitle = "OK"
    
    static let topMoveImageName = "upArrow.png"
    static let rightMoveImageName = "rightArrow.png"
    static let bottomMoveImageName = "downArrow.png"
    static let leftMoveImageName = "leftArrow.png"
}
