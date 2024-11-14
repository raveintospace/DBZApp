//
//  GameFooterBar.swift
//  DBZApp
//
//  Created by Uri on 12/11/24.
//

import SwiftUI

struct GameFooterBar: View {
    
    var mainRectangleText: String = "Total points"
    var mainRectangleFigures: String = ""
    
    var leftRectangleText: String = "Game"
    var leftRectangleFigures: String = ""
    
    var centerRectangleText: String = "Set"
    var centerRectangleFigures: String = ""
    
    var rightRectangleText: String = "Discard"
    var rightRectangleFigures: String = ""
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                pointsRectangle
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            HStack(spacing: 6) {
                gamesRectangle
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                setGameRectangle
                    .frame(maxWidth: .infinity, alignment: .center)
                
                discardsRectangle
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

#Preview {
    GameFooterBar(
        mainRectangleFigures: "150.000.000.000",
        leftRectangleFigures: "1 / 3",
        centerRectangleFigures: "R-1 / P-1",
        rightRectangleFigures: "0 / 3"
    )
        .padding()
}

extension GameFooterBar {
    private var pointsRectangle: some View {
        GameInfoRectangle(upperText: mainRectangleText, lowerText: mainRectangleFigures)
    }
    
    private var gamesRectangle: some View {
        GameInfoRectangle(upperText: leftRectangleText, lowerText: leftRectangleFigures)
    }
    
    private var setGameRectangle: some View {
        GameInfoRectangle(upperText: centerRectangleText, lowerText: centerRectangleFigures)
    }
    
    private var discardsRectangle: some View {
        GameInfoRectangle(upperText: rightRectangleText, lowerText: rightRectangleFigures)
    }
}
