//
//  Array+Only.swift
//  Memorize
//
//  Created by lyrisli on 2020/11/30.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
