//
//  ContentView.swift
//  Memorize
//
//  Created by lyrisli on 2020/11/17.
//  View

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
        }
            .foregroundColor(Color.orange)
            .padding()
            .font(Font.largeTitle)
       
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        return ZStack {
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                Text(card.content)
            } else{
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
