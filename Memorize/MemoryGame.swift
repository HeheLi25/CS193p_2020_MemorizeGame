//
//  MemoryGame.swift
//  Memorize
//
//  Created by lyrisli on 2020/11/17.
//  Model

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
    var cards: Array<Card>
    
    // 用一个计算属性来确定那个被翻开的牌的index，或者将特定的一张牌翻开
    var indexOfTheOneFaceUpCard: Int? {
        get {
            var faceUpCardIndices = [Int]() // Array<Int>()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index) // 把所有朝上的牌放到一个数组中
                }
            }
            if faceUpCardIndices.count == 1 { // 如果有一张牌朝上
                return faceUpCardIndices.first // 返回这个朝上的牌（Optional）
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    
    mutating func choose(card: Card) { //(label: type) //这里获得的只是一个copy，所以不能直接修改isFaceUp
        print("card chosen: \(card)" + "!")
        // 如果chosenIndex得到了nil则不执行
        // 如果已经翻开或者已经匹配了则不执行
        if let chosenIndex = cards.firstIndex(matching: card) , !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneFaceUpCard { // 获取一下看看现在有没有翻开的卡？
                if cards[chosenIndex].content == cards[potentialMatchIndex].content { // 新翻开的和已经翻开的是否相同？
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true;
            } else {
                indexOfTheOneFaceUpCard = chosenIndex // 之前还没有翻开的卡，把当前翻的这张记下来
            }
        }
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // 泛型类型
        var id: Int  //Identifiable需要一个唯一的id
    }
}
