//
//  GameInfoRectangle.swift
//  DBZApp
//
//  Created by Uri on 14/11/24.
//

import SwiftUI

struct GameInfoRectangle: View {
    
    var cornerRadius: CGFloat = 15
    var linewidth: CGFloat = 3
    var height: CGFloat = 50
    var upperText: String = "Some text"
    var lowerText: String = "123456"
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.dbzBlue)
            .stroke(.dbzOrange, lineWidth: linewidth)
            .frame(height: height)
            .overlay {
                VStack {
                    Text(upperText)
                        .bold()
                    Text(lowerText)
                }
                .foregroundStyle(.dbzYellow)
                .lineLimit(1)
            }
    }
}

#Preview {
    GeometryReader { geometry in
        VStack {
            GameInfoRectangle(lowerText: "15 Septillion")
                .frame(width: geometry.size.width)
            GameInfoRectangle()
                .frame(width: geometry.size.width / 3)
        }
    }
    .padding()
}
