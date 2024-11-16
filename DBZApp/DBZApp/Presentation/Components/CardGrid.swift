//
//  CardGrid.swift
//  DBZApp
//
//  Created by Uri on 16/11/24.
//

import SwiftUI

struct CardGrid<Item: Identifiable, ItemView: View>: View {
    
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat = 1, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .frame(width: cardWidth(in: geometry.size), height: cardHeight(in: geometry.size))
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func cardWidth(in size: CGSize) -> CGFloat {
        min(size.width / CGFloat(items.count), size.height * aspectRatio)
    }
    
    private func cardHeight(in size: CGSize) -> CGFloat {
        cardWidth(in: size) / aspectRatio
    }
}
