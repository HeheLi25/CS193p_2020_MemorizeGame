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
    
    @ViewBuilder //标记这个使得内容可以是一组view，或者是一个空view（不需要额外return）
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90))
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                // 根据父view给的最大长宽空间来决定字体（emoji）的大小
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: - Drawing Constants 常量
    // 把一些常量单独定义出来，不要直接把数值作为参数
    
 
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[2])
        return EmojiMemoryGameView(viewModel: game)
    }
}
