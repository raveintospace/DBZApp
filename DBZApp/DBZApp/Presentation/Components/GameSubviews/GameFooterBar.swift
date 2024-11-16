//
//  GameFooterBar.swift
//  DBZApp
//
//  Created by Uri on 12/11/24.
//

import SwiftUI

struct GameFooterBar: View {
    
    var rivalRectangleText: String = "Rival Ki points"
    var rivalRectangleFigures: String = ""
    
    var playerRectangleText: String = "Player Ki points"
    var playerRectangleFigures: String = ""
    
    var leftRectangleText: String = "Game"
    var leftRectangleFigures: String = ""
    
    var centerRectangleText: String = "Set"
    var centerRectangleFigures: String = ""
    
    var rightRectangleText: String = "Discard"
    var rightRectangleFigures: String = ""
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                rivalRectangle
                    .frame(maxWidth: .infinity, alignment: .leading)
                playerRectangle
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            HStack(spacing: 8) {
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
        rivalRectangleFigures: "150.000.000.000",
        playerRectangleFigures: "15 Septillion",
        leftRectangleFigures: "R-0 / P-1",
        centerRectangleFigures: "R-1 / P-1",
        rightRectangleFigures: "0 / 3"
    )
        .padding()
}

extension GameFooterBar {
    private var rivalRectangle: some View {
        GameInfoRectangle(upperText: rivalRectangleText, lowerText: rivalRectangleFigures)
    }
    private var playerRectangle: some View {
        GameInfoRectangle(upperText: playerRectangleText, lowerText: playerRectangleFigures)
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
