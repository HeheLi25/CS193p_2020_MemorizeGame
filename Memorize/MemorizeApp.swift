//
//  MemorizeApp.swift
//  Memorize
//
//  Created by lyrisli on 2020/11/17.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
