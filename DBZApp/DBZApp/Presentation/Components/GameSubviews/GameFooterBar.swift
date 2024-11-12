//
//  GameFooterBar.swift
//  DBZApp
//
//  Created by Uri on 12/11/24.
//

import SwiftUI

struct GameFooterBar: View {
    
    var leftButtonText: String = ""
    var leftButtonFigures: String = ""
    
    var centerButtonText: String = ""
    var centerButtonFigures: String = ""
    
    var rightButtonText: String = ""
    var rightbuttonFigures: String = ""
    
    var body: some View {
        HStack(spacing: 8) {
            roundsRectangle
                .frame(maxWidth: .infinity, alignment: .leading)
            
            pointsRectangle
                .frame(maxWidth: .infinity, alignment: .center)
            
            currentGameRectangle
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    GameFooterBar(
        leftButtonText: "Round:",
        leftButtonFigures: "1 / 3",
        centerButtonText: "Total points:",
        centerButtonFigures: "150.000.000.000",
        rightButtonText: "Score:",
        rightbuttonFigures: "R-1 / P-1"
    )
        .padding()
}

extension GameFooterBar {
    private var roundsRectangle: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.dbzBlue)
            .stroke(.dbzOrange, lineWidth: 4)
            .frame(width: 100, height: 70)
            .overlay {
                VStack {
                    Text(leftButtonText)
                    Text(leftButtonFigures)
                }
                .foregroundStyle(.dbzYellow)
                .bold()
            }
    }
    
    private var pointsRectangle: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.dbzBlue)
            .stroke(.dbzOrange, lineWidth: 4)
            .frame(width: 150, height: 70)
            .overlay {
                VStack {
                    Text(centerButtonText)
                    Text(centerButtonFigures)
                        .font(.caption)
                }
                .foregroundStyle(.dbzYellow)
                .bold()
            }
    }
    
    private var currentGameRectangle: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.dbzBlue)
            .stroke(.dbzOrange, lineWidth: 4)
            .frame(width: 100, height: 70)
            .overlay {
                VStack {
                    Text(rightButtonText)
                    Text(rightbuttonFigures)
                }
                .foregroundStyle(.dbzYellow)
                .bold()
            }
    }
}

// MARK: - To-Do
/* Extract game rectangle to its own view
 Add a font size for center rectangle figure
 
 */
