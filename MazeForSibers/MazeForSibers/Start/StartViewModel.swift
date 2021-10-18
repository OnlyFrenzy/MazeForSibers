//
//  StartViewModel.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 15.10.2021.
//

import UIKit

class StartViewModel {

    private var maze: [[Room]]?
    private var player: Player?
    private var finish: Finish?
    weak var delegate: StartViewControllerDelegate?
    
    func startButtonDidTap(withMazeHeight mazeHeigth: Int?, withMazeWidth mazeWidth: Int?) {
        
        let nonOptionalMazeHeight: Int = mazeHeigth ?? .defaultMazeHeight
        let nonOptionalMazeWidth: Int = mazeWidth ?? .defaultMazeWidth
        
        if let maze = MazeGenerator(mazeHeigth: nonOptionalMazeHeight,
                                    mazeWidth: nonOptionalMazeWidth).generateMaze() {
            let player = PlayerGenerator(mazeHeigth: nonOptionalMazeHeight,
                                         mazeWidth: nonOptionalMazeWidth).generatePlayer()
            let finish = FinishGenerator(player: player,
                                         mazeHeigth: nonOptionalMazeHeight,
                                         mazeWidth: nonOptionalMazeWidth).generateFinish()
            let mazeWithItems = ItemsGenerator(maze: maze, finish: finish).generateItems()

            let gameViewModel = GameViewModel(maze: mazeWithItems, player: player, finish: finish)
            delegate?.pushNextScreen(gameViewModel: gameViewModel)
            return
        }
        
        delegate?.pushAlert(title: .veryShortMazeTitle,
                                  errorMessage: .veryShortMazeErrorMessage,
                                  actionTitle: .veryShortMazeActionTitle)
    }
    
    func mainViewBackground() -> UIColor {
        return .defaultAppColor
    }
    
    func mazeWidthLabelText() -> String {
        return .mazeWidth
    }
    
    func mazeHeightLabelText() -> String {
        return .mazeHeight
    }
    
    func mazeWidthLabelTextColor() -> UIColor {
        return .defaultLabelTextColor
    }
    
    func mazeHeightLabelTextColor() -> UIColor {
        return .defaultLabelTextColor
    }
    
    func mazeWidthLabelFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.labelFontSize)
    }
    
    func mazeHeightLabelFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.labelFontSize)
    }
    
    func mazeWidthLabelTextAlignment() -> NSTextAlignment {
        return .defaultLabelTextAlignment
    }
    
    func mazeHeightLabelTextAlignment() -> NSTextAlignment {
        return .defaultLabelTextAlignment
    }
    
    func mazeWidthTextFieldKeyboardType() -> UIKeyboardType {
        return .defaultTextFieldKeyboardType
    }
    
    func mazeHeightTextFieldKeyboardType() -> UIKeyboardType {
        return .defaultTextFieldKeyboardType
    }
    
    func mazeWidthTextFieldTextColor() -> UIColor {
        return .defaultTextFieldTextColor
    }
    
    func mazeHeightTextFieldTextColor() -> UIColor {
        return .defaultTextFieldTextColor
    }
    
    func mazeWidthTextFieldPlaceholder() -> NSAttributedString {
        NSAttributedString(
            string: String(Int.defaultMazeWidth),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
    
    func mazeHeightTextFieldPlaceholder() -> NSAttributedString {
        NSAttributedString(
            string: String(Int.defaultMazeHeight),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
    
    func mazeWidthTextFieldFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.textFieldFontSize)
    }
    
    func mazeHeightTextFieldFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.textFieldFontSize)
    }
    
    func startButtonBackgroundColor() -> UIColor {
        return .defaultStartButtonBackgroundColor
    }
    
    func startButtonCornerRadius() -> CGFloat {
        return .defaultButtonCornerRadius
    }
    
    func startButtonBorderWidth() -> CGFloat {
        return .defaultButtonBorderWidth
    }
    
    func startButtonBorderColor() -> CGColor {
        return UIColor.defaultBorderColor.cgColor
    }
    
    func startButtonTitle() -> String {
        return .start
    }
    
    func startButtonTitleColor() -> UIColor {
        return .defaultButtonTitleColor
    }
}

fileprivate extension UIColor {
    static let defaultStartButtonBackgroundColor: UIColor = .green
}

fileprivate extension String {
    static let veryShortMazeTitle = "Very easy maze"
    static let veryShortMazeErrorMessage = "Maze is very easy. Please change value and try again!"
    static let veryShortMazeActionTitle = "OK"
    
    static let mazeHeight = "Edit maze height"
    static let mazeWidth = "Edit maze width"
    static let start = "Start game"
}

fileprivate extension CGFloat {
    static let labelFontSize: CGFloat = 24
    static let textFieldFontSize: CGFloat = 18
}

fileprivate extension NSTextAlignment {
    static let defaultLabelTextAlignment: NSTextAlignment = .center
}

fileprivate extension UIKeyboardType {
    static let defaultTextFieldKeyboardType: UIKeyboardType = .numberPad
}
