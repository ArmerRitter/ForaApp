//
//  Box.swift
//  Fora
//
//  Created by Yuriy Balabin on 04.09.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


class Box<T> {
    typealias Listener = (T) -> ()
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}
