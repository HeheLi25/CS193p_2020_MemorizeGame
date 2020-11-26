//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by 李宜嵘 on 2020/11/26.
//

import Foundation

// 为元素类型为Identifiable的数组定义一个extension，为它增加一个找到一个特定id的元素的方法
extension Array where Element : Identifiable {
    func firstIndex(matching: Element) -> Int {
        for index in 0..<self.count {
            if(self[index].id == matching.id) {
                return index
            }
        }
        return 0  // TODO: bogus!
    }
}
