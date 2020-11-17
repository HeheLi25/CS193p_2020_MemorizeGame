//
//  EmojiMemoryGame.swift
//  Memorize
//  
//  Created by lyrisli on 2020/11/17.
//  ViewModel

import Foundation


class EmojiMemoryGame {
    //private(set)：玻璃门，只有这个类可以修改，但别人都可以看
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    static func createMemoryGame() -> MemoryGame<String>{
        let emojis: Array<String> = ["🍐","🍎","🍒"]
        return MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
}
