//
//  ViewController.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 12.10.2021.
//

import UIKit

protocol StartViewControllerDelegate: AnyObject {
    func pushAlert(title: String, errorMessage: String, actionTitle: String)
    func pushNextScreen(gameViewModel: GameViewModel)
}

class StartViewController: UIViewController {
    
    private var viewModel: StartViewModel?
    
    @IBOutlet private weak var mazeWidthLabel: UILabel!
    @IBOutlet private weak var mazeHeightLabel: UILabel!
    @IBOutlet private weak var mazeWidthTextField: UITextField!
    @IBOutlet private weak var mazeHeightTextField: UITextField!
    @IBOutlet private weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = StartViewModel()
        viewModel?.delegate = self
        
        configureMainView()
        configureLabels()
        configureTextFields()
        configureButtons()
    }
    
    @IBAction private func startButtonDidTap(_ sender: Any) {
        
        let mazeHeightText = mazeHeightTextField.text ?? ""
        let mazeHeight = Int(mazeHeightText)
        let mazeWidthText = mazeWidthTextField.text ?? ""
        let mazeWidth = Int(mazeWidthText)
        
        viewModel?.startButtonDidTap(withMazeHeight: mazeHeight,
                                   withMazeWidth: mazeWidth)
    }
    
    private func configureMainView() {
        view.backgroundColor = viewModel?.mainViewBackground()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainViewDidTap)))
    }
    
    @objc
    private func mainViewDidTap() {
        view.endEditing(true)
    }
    
    private func configureLabels() {
        guard let viewModel = viewModel else { return }
        
        mazeWidthLabel.text = viewModel.mazeWidthLabelText()
        mazeHeightLabel.text = viewModel.mazeHeightLabelText()
        mazeWidthLabel.textColor = viewModel.mazeWidthLabelTextColor()
        mazeHeightLabel.textColor = viewModel.mazeHeightLabelTextColor()
        mazeWidthLabel.font = viewModel.mazeWidthLabelFont(font: mazeWidthLabel.font)
        mazeHeightLabel.font = viewModel.mazeHeightLabelFont(font: mazeHeightLabel.font)
        mazeWidthLabel.textAlignment = viewModel.mazeWidthLabelTextAlignment()
        mazeHeightLabel.textAlignment = viewModel.mazeHeightLabelTextAlignment()
    }
    
    private func configureTextFields() {
        guard let viewModel = viewModel else { return }
        
        mazeWidthTextField.keyboardType = viewModel.mazeWidthTextFieldKeyboardType()
        mazeHeightTextField.keyboardType = viewModel.mazeHeightTextFieldKeyboardType()
        mazeWidthTextField.textColor = viewModel.mazeWidthTextFieldTextColor()
        mazeHeightTextField.textColor = viewModel.mazeHeightTextFieldTextColor()
        mazeWidthTextField.attributedPlaceholder = viewModel.mazeWidthTextFieldPlaceholder()
        mazeHeightTextField.attributedPlaceholder = viewModel.mazeHeightTextFieldPlaceholder()
        mazeWidthTextField.font = viewModel.mazeWidthTextFieldFont(font: mazeWidthTextField.font)
        mazeHeightTextField.font = viewModel.mazeHeightTextFieldFont(font: mazeHeightTextField.font)
    }
    
    private func configureButtons() {
        guard let viewModel = viewModel else { return }
        
        startButton.backgroundColor = viewModel.startButtonBackgroundColor()
        startButton.layer.cornerRadius = viewModel.startButtonCornerRadius()
        startButton.layer.borderWidth = viewModel.startButtonBorderWidth()
        startButton.layer.borderColor = viewModel.startButtonBorderColor()
        startButton.setTitle(viewModel.startButtonTitle(), for: .normal)
        startButton.setTitleColor(viewModel.startButtonTitleColor(), for: .normal)
    }
}

extension StartViewController: StartViewControllerDelegate {
    
    func pushNextScreen(gameViewModel: GameViewModel) {
        let storyBoard = UIStoryboard(name: GameViewController.className, bundle: nil)
        
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: GameViewController.className) as? GameViewController else { return }
        
        viewController.viewModel = gameViewModel
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}
