//
//  EndViewController.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 17.10.2021.
//

import UIKit

protocol EndViewControllerDelegate: AnyObject {
    func pushNextScreen()
}

class EndViewController: UIViewController {

    var viewModel: EndViewModel?
    
    @IBOutlet private weak var endGameLabel: UILabel!
    @IBOutlet private weak var startNewGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self

        configure()
    }
    
    private func configure() {
        configureEndLabel()
        configureStartNewGameButton()
    }
    
    private func configureEndLabel() {
        guard let viewModel = viewModel else { return }
        
        endGameLabel.textAlignment = viewModel.endGameLabelTextAlignment()
        endGameLabel.font = viewModel.endGameLabelFont(font: endGameLabel.font)
        endGameLabel.textColor = viewModel.endGameLabelTextColor()
        endGameLabel.text = viewModel.endGameLabelTitle()
    }
    
    private func configureStartNewGameButton() {
        guard let viewModel = viewModel else { return }
        
        startNewGameButton.titleLabel?.font = viewModel.startNewGameButtonFont(font: startNewGameButton.titleLabel?.font)
        startNewGameButton.setTitleColor(viewModel.startNewGameButtonTitleColor(), for: .normal)
        startNewGameButton.backgroundColor = viewModel.startNewGameButtonBackgroundColor()
        startNewGameButton.layer.cornerRadius = viewModel.startNewGameButtonCornerRadius()
        startNewGameButton.layer.borderWidth = viewModel.startNewGameButtonBorderWidth()
        startNewGameButton.layer.borderColor = viewModel.startNewGameButtonBorderColor()
        startNewGameButton.setTitle(viewModel.startNewGameButtonTitle(), for: .normal)
        
        self.startNewGameButton.addTarget(self, action: #selector(startNewGameButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func startNewGameButtonDidTap() {
        
        viewModel?.startNewGameButtonDidTap()
    }
}

extension EndViewController: EndViewControllerDelegate {
    func pushNextScreen() {
        let storyBoard = UIStoryboard(name: StartViewController.className, bundle: nil)
        
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: StartViewController.className) as? StartViewController else { return }

        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
