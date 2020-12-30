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
        VStack {
        Grid (items: viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    viewModel.choose(card: card)
                }
            } // .aspectRatio(2/3, contentMode: .fit)
            .padding(5)
        }
            .padding()
            .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut){
                    self.viewModel.resetGame()
                }
            }, label: {
                Text("新游戏")
            })
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size) //传入父view给的最大空间大小
        }
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    @ViewBuilder //标记这个使得内容可以是一组view，或者是一个空view（不需要额外return）
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90))
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90))
                    }
                }.padding(5).opacity(0.4)
                .transition(.identity)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
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
