//
//  EmojiMemoryGame.swift
//  Memorize
//  
//  Created by lyrisli on 2020/11/17.
//  ViewModel

import Foundation


class EmojiMemoryGame: ObservableObject {
    
    //var objectWillChange: ObservableObjectPublisher
    //ObservableObject协议自带，不用自己写，这是一个publisher发布者，可以在对象发生变化时进行发布
    //@Published是一个property wrapper，表示每次model改变，都会调用objectWillChange.send()
    //objectWillChange.send()则是发布一个发生改变的消息
    //private(set)像一个玻璃门，只有这个类可以修改，但别人都可以看
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
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
