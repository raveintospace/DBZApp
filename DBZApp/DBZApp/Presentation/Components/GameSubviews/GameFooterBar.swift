//
//  GameFooterBar.swift
//  DBZApp
//
//  Created by Uri on 12/11/24.
//

import SwiftUI

struct GameFooterBar: View {
    
    var mainButtonText: String = "Total points"
    var mainButtonFigures: String = ""
    
    var leftButtonText: String = "Game"
    var leftButtonFigures: String = ""
    
    var centerButtonText: String = "Set"
    var centerButtonFigures: String = ""
    
    var rightButtonText: String = "Discard"
    var rightButtonFigures: String = ""
    
    var body: some View {
        VStack {
            HStack {
                pointsRectangle
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            HStack(spacing: 0) {
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
        mainButtonFigures: "150.000.000.000",
        leftButtonFigures: "1 / 3",
        centerButtonFigures: "R-1 / P-1",
        rightButtonFigures: "0 / 3"
    )
        .padding()
}

extension GameFooterBar {
    private var pointsRectangle: some View {
        GameInfoRectangle(upperText: mainButtonText, lowerText: mainButtonFigures)
    }
    
    private var gamesRectangle: some View {
        GameInfoRectangle(upperText: leftButtonText, lowerText: leftButtonFigures)
    }
    
    private var setGameRectangle: some View {
        GameInfoRectangle(upperText: centerButtonText, lowerText: centerButtonFigures)
    }
    
    private var discardsRectangle: some View {
        GameInfoRectangle(upperText: rightButtonText, lowerText: rightButtonFigures)
    }
}

// MARK: - To-Do
/* Extract game rectangle to its own view
 Add a font size for center rectangle figure
 
 */
