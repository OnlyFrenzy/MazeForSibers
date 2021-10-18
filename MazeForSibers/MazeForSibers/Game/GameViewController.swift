//
//  GameViewController.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 15.10.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func pushAlert(title: String, errorMessage: String, actionTitle: String)
    func reloadGameView()
    func changeHitPointValue()
    func pushNextScreen(endViewModel: EndViewModel)
    func dismissViewController()
    func refreshInventory()
    func refresh()
    func itemIsChest(description: String)
    func updateInventoryView(description: String,
                             isUseButtonHidden: Bool,
                             isDropButtonHidden: Bool,
                             isDiscardButtonHidden: Bool,
                             isOpenButtonHidden: Bool)
}

class GameViewController: UIViewController {

    var viewModel: GameViewModel?
    private var selectedItem: Item?
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var lifeLabel: UILabel!
    
    @IBOutlet private weak var gameView: UIView!
    @IBOutlet private weak var roomItemsView: UIView!
    
    @IBOutlet private weak var inventoryView: UIView!
    @IBOutlet private weak var inventoryLabel: UILabel!
    @IBOutlet private weak var itemsStackView: UIStackView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var useButton: UIButton!
    @IBOutlet private weak var dropButton: UIButton!
    @IBOutlet private weak var discardButton: UIButton!
    @IBOutlet private weak var openButton: UIButton!
    @IBOutlet private weak var itemStackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var itemStackViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topMoveImageView: UIImageView!
    @IBOutlet weak var rightMoveImageView: UIImageView!
    @IBOutlet weak var bottomMoveImageView: UIImageView!
    @IBOutlet weak var leftMoveImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.delegate = self
        
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        reloadGameView()
    }
    
    private func configure() {
        configureBackButton()
        configureLifeLabel()
        configureInventory()
        configureItemsStackView()
        configureInventoryButtons()
        configureDescriptionLabel()
        configureItemStackViewConstraints()
        configureMoveButtons()
    }
    
    private func configureLifeLabel() {
        guard let viewModel = viewModel else { return }
        
        lifeLabel.textAlignment = viewModel.lifeLabelTextAlignment()
        lifeLabel.font = viewModel.lifeLabelFont(font: lifeLabel.font)
        changeHitPointsLabelTitle()
    }
    
    private func configureBackButton() {
        guard let viewModel = viewModel else { return }
        
        backButton.titleLabel?.font = viewModel.backButtonTitleLabelFont(font: backButton.titleLabel?.font)
        backButton.setTitleColor(viewModel.backButtonTitleColor(), for: .normal)
        backButton.backgroundColor = viewModel.backButtonBackgroundColor()
        backButton.setTitle(viewModel.backButtonTitle(), for: .normal)
        
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private func configureInventory() {
        guard let viewModel = viewModel else { return }
        
        inventoryView.backgroundColor = viewModel.inventoryViewBackgroundColor()
        inventoryLabel.textAlignment = viewModel.inventoryLabelTextAlignment()
        inventoryLabel.font = viewModel.inventoryLabelFont(font: inventoryLabel.font)
        inventoryLabel.text = viewModel.inventoryLabelTitle()
    }
    
    private func configureItemsStackView() {
        guard let viewModel = viewModel else { return }
        
        let inventoryCopacity = viewModel.inventoryCopacity()
        
        let heightItem = (inventoryView.frame.width - itemsStackView.spacing * inventoryCopacity - 1) / inventoryCopacity
        itemsStackView.alignment = viewModel.itemsStackViewAlignment()
        itemsStackView.distribution = .fillEqually
        
        itemsStackView.subviews.forEach({ $0.removeFromSuperview() })
        viewModel.playerItems().forEach({ item in
            let itemView = ItemView(frame: CGRect(x: 0, y: 0, width: heightItem, height: heightItem))
            itemView.createItem(item: item, delegate: self)
            itemsStackView.addArrangedSubview(itemView)
        })
        
        itemsStackView.setNeedsLayout()
        itemsStackView.layoutIfNeeded()
    }
    
    private func configureItemStackViewConstraints() {
        guard let viewModel = viewModel else { return }
        
        itemStackViewHeightConstraint.constant = (inventoryView.frame.width - itemsStackView.spacing * (viewModel.inventoryCopacity() - 1)) / viewModel.inventoryCopacity()
        
        let playersItemsCount = CGFloat(viewModel.playerItems().count)
        if playersItemsCount > 0 {
            itemStackViewWidthConstraint.constant = itemStackViewHeightConstraint.constant * playersItemsCount + itemsStackView.spacing * (playersItemsCount - 1)
        } else {
            itemStackViewWidthConstraint.constant = 0
        }
    }
    
    private func configureDescriptionLabel() {
        guard let viewModel = viewModel else { return }
        
        descriptionLabel.textAlignment = viewModel.descriptionLabelTextAlignment()
        descriptionLabel.font = viewModel.descriptionLabelFont(font: descriptionLabel.font)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = viewModel.descriptionLabelMinimumScaleFactor()
        cleanDescriptionLabel()
    }
    
    private func configureInventoryButtons() {
        guard let viewModel = viewModel else { return }
        
        useButton.titleLabel?.font = viewModel.inventoryButtonsFont(font: useButton.titleLabel?.font)
        useButton.setTitleColor(viewModel.inventoryButtonTitleColor(), for: .normal)
        useButton.backgroundColor = viewModel.inventoryButtonBackgroundColor()
        useButton.setTitle(viewModel.useButtonTitle(), for: .normal)
        useButton.addTarget(self, action: #selector(useButtonDidTap), for: .touchUpInside)
        
        dropButton.titleLabel?.font = viewModel.inventoryButtonsFont(font: dropButton.titleLabel?.font)
        dropButton.setTitleColor(viewModel.inventoryButtonTitleColor(), for: .normal)
        dropButton.backgroundColor = viewModel.inventoryButtonBackgroundColor()
        dropButton.setTitle(viewModel.dropButtonTitle(), for: .normal)
        dropButton.addTarget(self, action: #selector(dropButtonDidTap), for: .touchUpInside)
        
        discardButton.titleLabel?.font = viewModel.inventoryButtonsFont(font: discardButton.titleLabel?.font)
        discardButton.setTitleColor(viewModel.inventoryButtonTitleColor(), for: .normal)
        discardButton.backgroundColor = viewModel.inventoryButtonBackgroundColor()
        discardButton.setTitle(viewModel.discardButtonTitle(), for: .normal)
        discardButton.addTarget(self, action: #selector(discardButtonDidTap), for: .touchUpInside)
        
        openButton.titleLabel?.font = viewModel.inventoryButtonsFont(font: openButton.titleLabel?.font)
        openButton.setTitleColor(viewModel.inventoryButtonTitleColor(), for: .normal)
        openButton.backgroundColor = viewModel.inventoryButtonBackgroundColor()
        openButton.setTitle(viewModel.openButtonTitle(), for: .normal)
        openButton.addTarget(self, action: #selector(openButtonDidTap), for: .touchUpInside)
        
        hideAllInventoryButtons()
    }
    
    private func hideAllInventoryButtons() {
        useButton.isHidden = true
        dropButton.isHidden = true
        discardButton.isHidden = true
        openButton.isHidden = true
    }
    
    private func configureMoveButtons() {
        guard let viewModel = viewModel else { return }

        topMoveImageView.image = viewModel.topMoveImage()
        topMoveImageView.isUserInteractionEnabled = true
        topMoveImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topMoveImageViewDidTap)))
        
        rightMoveImageView.image = viewModel.rightMoveImage()
        rightMoveImageView.isUserInteractionEnabled = true
        rightMoveImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightMoveImageViewDidTap)))
        
        bottomMoveImageView.image = viewModel.bottomMoveImage()
        bottomMoveImageView.isUserInteractionEnabled = true
        bottomMoveImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bottomMoveImageViewDidTap)))
        
        leftMoveImageView.image = viewModel.leftMoveImage()
        leftMoveImageView.isUserInteractionEnabled = true
        leftMoveImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftMoveImageViewDidTap)))
    }
    
    @objc
    private func topMoveImageViewDidTap() {
        viewModel?.directionButtonDidTap(direction: .top)
    }
    
    @objc
    private func rightMoveImageViewDidTap() {
        viewModel?.directionButtonDidTap(direction: .right)
    }
    
    @objc
    private func bottomMoveImageViewDidTap() {
        viewModel?.directionButtonDidTap(direction: .bottom)
    }
    
    @objc
    private func leftMoveImageViewDidTap() {
        viewModel?.directionButtonDidTap(direction: .left)
    }
    
    @objc
    private func backButtonDidTap() {
        viewModel?.backButtonDidTap()
    }
    
    @objc
    private func useButtonDidTap() {
        viewModel?.useButtonDidTap()
    }
    
    @objc
    private func dropButtonDidTap() {
        viewModel?.dropButtonDidTap()
    }
    
    @objc
    private func discardButtonDidTap() {
        viewModel?.discardButtonDidTap()
    }
    
    @objc
    private func openButtonDidTap() {
        viewModel?.openButtonDidTap()
    }
    
    private func changeMoveDirectionState() {
        guard let viewModel = viewModel else { return }
        
        topMoveImageView.isHidden = viewModel.isTopWall()
        rightMoveImageView.isHidden = viewModel.isRightWall()
        bottomMoveImageView.isHidden = viewModel.isBottomWall()
        leftMoveImageView.isHidden = viewModel.isLeftWall()
    }
    
    private func changeHitPointsLabelTitle() {
        guard let viewModel = viewModel else { return }
        lifeLabel.text = viewModel.lifeLabelTitle()
    }
    
    private func refreshItemsInRoom() {
        
        roomItemsView.subviews.forEach({ $0.removeFromSuperview() })
        
        roomItemsView.setNeedsLayout()
        roomItemsView.layoutIfNeeded()
        gameView.setNeedsLayout()
        gameView.layoutIfNeeded()
        
        let items = viewModel?.itemsInRoom()
        let itemSide = (roomItemsView.frame.size.width - .itemsSpacingInRoomItemsView * 2) / CGFloat(Int.defaultItemsSlotsWidth)
        
        items?.forEach({ item in
            let xCoordinate = itemSide * (CGFloat(item.coordinate.0) - 1) + CGFloat.itemsSpacingInRoomItemsView * (CGFloat(item.coordinate.0) - 1)
            let yCoordinate = itemSide * CGFloat(item.coordinate.1) + CGFloat.itemsSpacingInRoomItemsView * CGFloat(item.coordinate.1)
            let itemView = ItemView()
            itemView.createItem(item: item, delegate: self)
            itemView.frame = CGRect(x: xCoordinate, y: yCoordinate, width: itemSide, height: itemSide)
            roomItemsView.addSubview(itemView)
            
        })
    }
    
    private func cleanDescriptionLabel() {
        descriptionLabel.text = ""
    }
}

extension GameViewController: GameViewControllerDelegate {
    
    func updateInventoryView(description: String,
                             isUseButtonHidden: Bool,
                             isDropButtonHidden: Bool,
                             isDiscardButtonHidden: Bool,
                             isOpenButtonHidden: Bool) {
        descriptionLabel.text = description
        useButton.isHidden = isUseButtonHidden
        dropButton.isHidden = isDropButtonHidden
        discardButton.isHidden = isDiscardButtonHidden
        openButton.isHidden = isOpenButtonHidden
    }
    
    func itemIsChest(description: String) {
        descriptionLabel.text = description
        useButton.isHidden = true
        dropButton.isHidden = true
        discardButton.isHidden = true
        openButton.isHidden = false
    }
    
    func refreshInventory() {
        configureItemsStackView()
        configureItemStackViewConstraints()
        hideAllInventoryButtons()
        cleanDescriptionLabel()
    }
    
    func refresh() {
        refreshInventory()
        refreshItemsInRoom()
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func pushNextScreen(endViewModel: EndViewModel) {
        
        let storyBoard = UIStoryboard(name: EndViewController.className, bundle: nil)
        
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: EndViewController.className) as? EndViewController else { return }
        
        viewController.viewModel = endViewModel
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true, completion: nil)
    }
    
    func changeHitPointValue() {
        changeHitPointsLabelTitle()
    }
    
    func reloadGameView() {
        changeMoveDirectionState()
        changeHitPointsLabelTitle()
        refreshItemsInRoom()
    }
}

extension GameViewController: ItemViewDelegate {
    
    func itemDidTap(item: Item) {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.itemDidTap(item: item)
    }
}

fileprivate extension CGFloat {
    static let itemsSpacingInRoomItemsView: CGFloat = 16
}
