//
//  NSObject+Extensions.swift
//  MazeForSibers
//
//  Created by OnlyFrenzy on 15.10.2021.
//

import Foundation

extension NSObject {
    static var className: String {
        String(describing: Self.self)
    }
}
