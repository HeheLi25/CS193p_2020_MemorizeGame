//
//  Grid.swift
//  Memorize
//
//  Created by lyrisli on 2020/11/25.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    // 这个Grid作为一个容器，里面存着一些元素（泛型），以及一个viewForItem方法负责为每个元素生成view组件
    
    init(items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    // 闭包逃逸：viewForItem这个参数没有立刻被使用，而是被赋给了Grid中的属性
    // 也就是说，当init方法结束时，它依然存在
    // 因此要把它标记为@escaping，即，它逃出了这个闭包函数
    
    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }

    }
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout) // 用ForEach为每个元素获取view组件
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = self.items.firstIndex(matching: item)!
        return viewForItem(item)  // 调用viewForItem来获取一个item的view
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))


    }
}





