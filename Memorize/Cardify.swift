//
//  Cardify.swift
//  Memorize
//
//  Created by lyrisli on 2020/12/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    var isFaceUp: Bool
    
    func body(content: Content) -> some View { // Content就是这个modifier的caller（在这里是ZStack）
        ZStack {
            if isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                content
            } else{
                    RoundedRectangle(cornerRadius: cornerRadius).fill() // 不显示已经匹配的卡
            }
        }

    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
