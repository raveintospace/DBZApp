//
//  DetailBottomButtons.swift
//  DBZApp
//
//  Created by Uri on 5/10/24.
//

import SwiftUI

struct DetailBottomButtons: View {
    
    var showTransformationsButton: Bool = false
    
    var body: some View {
        VStack {
            ButtonBorderColorAnimated(buttonText: "Planet")
            ButtonBorderColorAnimated(buttonText: "Transformations")
                .opacity(showTransformationsButton ? 1 : 0)
        }
    }
}

#Preview {
    DetailBottomButtons(showTransformationsButton: true)
}
