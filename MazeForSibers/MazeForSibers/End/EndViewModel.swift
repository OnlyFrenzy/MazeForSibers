//
//  EndViewModel.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 18.10.2021.
//

import UIKit

protocol EndViewModel {
    var delegate: EndViewControllerDelegate? { get set }
    func endGameLabelTextAlignment() -> NSTextAlignment
    func endGameLabelFont(font: UIFont?) -> UIFont?
    func endGameLabelTextColor() -> UIColor
    func endGameLabelTitle() -> String
    func startNewGameButtonDidTap()
    func startNewGameButtonFont(font: UIFont?) -> UIFont?
    func startNewGameButtonTitleColor() -> UIColor
    func startNewGameButtonBackgroundColor() -> UIColor
    func startNewGameButtonCornerRadius() -> CGFloat
    func startNewGameButtonBorderWidth() -> CGFloat
    func startNewGameButtonBorderColor() -> CGColor
    func startNewGameButtonTitle() -> String
}

extension EndViewModel {
    func endGameLabelTextAlignment() -> NSTextAlignment {
        return .endGameLabelTextAlignment
    }
    
    func endGameLabelFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.endGameLabelFontSize)
    }
    
    func startNewGameButtonDidTap() {
        delegate?.pushNextScreen()
    }
    
    func startNewGameButtonFont(font: UIFont?) -> UIFont? {
        return font?.withSize(.startNewGameButtonFontSize)
    }
    
    func startNewGameButtonTitleColor() -> UIColor {
        return .defaultButtonTitleColor
    }
    
    func startNewGameButtonBackgroundColor() -> UIColor {
        return .startNewGameButtonBackgroundColor
    }
    
    func startNewGameButtonCornerRadius() -> CGFloat {
        return .defaultButtonCornerRadius
    }
    
    func startNewGameButtonBorderWidth() -> CGFloat {
        return .defaultButtonBorderWidth
    }
    
    func startNewGameButtonBorderColor() -> CGColor {
        return UIColor.defaultBorderColor.cgColor
    }
    
    func startNewGameButtonTitle() -> String {
        return .startNewGameButtonTitle
    }
}

fileprivate extension UIColor {
    static let startNewGameButtonBackgroundColor: UIColor = .green
}

fileprivate extension NSTextAlignment {
    static let endGameLabelTextAlignment: NSTextAlignment = .center
}

fileprivate extension CGFloat {
    static let endGameLabelFontSize: CGFloat = 24
    static let startNewGameButtonFontSize: CGFloat = 24
}

fileprivate extension String {
    static let startNewGameButtonTitle = "Start new game"
}
