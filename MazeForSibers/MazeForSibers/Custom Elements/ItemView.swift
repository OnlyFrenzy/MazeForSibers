//
//  ItemView.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 15.10.2021.
//

import UIKit

protocol ItemViewDelegate {
    func itemDidTap(item: Item)
}

class ItemView: UIImageView {
    
    private var item: Item?
    private var delegate: ItemViewDelegate?
    
    func createItem(item: Item, delegate: ItemViewDelegate) {
        self.item = item
        self.delegate = delegate
        self.image = self.item?.image
        self.isUserInteractionEnabled = true
        self.contentMode = .scaleAspectFit
        self.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(itemViewDidTap)))
    }
    
    @objc
    private func itemViewDidTap() {
        guard let item = self.item else { return }
        self.delegate?.itemDidTap(item: item)
    }
}
