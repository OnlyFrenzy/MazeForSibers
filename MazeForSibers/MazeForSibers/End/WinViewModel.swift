//
//  WinViewModel.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 19.10.2021.
//

import UIKit

class WinViewModel: EndViewModel {
    
    weak var delegate: EndViewControllerDelegate?
    
    func endGameLabelTextColor() -> UIColor {
        return .endGameLabelTextColor
    }
    
    func endGameLabelTitle() -> String {
        return .endGameLabelTitle
    }
}

fileprivate extension UIColor {
    static let endGameLabelTextColor: UIColor = .green
}

fileprivate extension String {
    static let endGameLabelTitle = "You open chest! \n You Win! \n Try again if you wont."
}
