//
//  GameInfoRectangle.swift
//  DBZApp
//
//  Created by Uri on 14/11/24.
//

import SwiftUI

struct GameInfoRectangle: View {
    
    var cornerRadius: CGFloat = 15
    var linewidth: CGFloat = 4
    var width: CGFloat = 100
    var height: CGFloat = 60
    var upperText: String = "Some text"
    var lowerText: String = "123456"
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.dbzBlue)
            .stroke(.dbzOrange, lineWidth: linewidth)
            .frame(width: width, height: height)
            .overlay {
                VStack {
                    Text(upperText)
                    Text(lowerText)
                }
                .foregroundStyle(.dbzYellow)
                .bold()
                .lineLimit(1)
            }
    }
}

#Preview {
    VStack {
        GameInfoRectangle()
        GameInfoRectangle(width: 200)
    }
}
