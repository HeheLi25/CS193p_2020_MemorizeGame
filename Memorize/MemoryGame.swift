//
//  MemoryGame.swift
//  Memorize
//
//  Created by lyrisli on 2020/11/17.
//  Model

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    mutating func choose(card: Card) { //(label: type) //这里获得的只是一个copy，所以不能直接修改isFaceUp
        print("card chosen: \(card)" + "!")
        let chosenIndex: Int = cards.firstIndex(matching: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>() //初始化cards变量
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2)) //在数组增加新元素
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{ //MemoryGame.Card
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent // 泛型类型
        var id: Int  //Identifiable需要一个唯一的id
    }
}
