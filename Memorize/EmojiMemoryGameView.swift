//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by lyrisli on 2020/11/17.
//  View

import SwiftUI

struct EmojiMemoryGameView: View {
    //ObervedObject，意思是这是一个ObservableObject，每次改变都redraw，才能实现翻牌
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid (items: viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            } // .aspectRatio(2/3, contentMode: .fit)
            .padding(5)
        }
            .padding()
            .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size) //传入父view给的最大空间大小
        }
    }
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                Text(card.content)
            } else{
                if(!card.isMatched){
                    RoundedRectangle(cornerRadius: cornerRadius).fill() // 不显示已经匹配的卡
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        // 根据父view给的最大长宽空间来决定字体（emoji）的大小
    }
    
    // MARK: - Drawing Constants 常量
    // 把一些常量单独定义出来，不要直接把数值作为参数
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
    }
}
