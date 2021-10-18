//
//  LoseViewMocel.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 19.10.2021.
//

import UIKit

class LoseViewModel: EndViewModel {
    weak var delegate: EndViewControllerDelegate?
    
    func endGameLabelTextColor() -> UIColor {
        return .endGameLabelTextColor
    }
    
    func endGameLabelTitle() -> String {
        return .endGameLabelTitle
    }
}

fileprivate extension UIColor {
    static let endGameLabelTextColor: UIColor = .red
}

fileprivate extension String {
    static let endGameLabelTitle = "Your heal is over! \n You Lose \n Try again if you wont."
}
