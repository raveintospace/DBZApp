//
//  DetailHeaderButtons.swift
//  DBZApp
//
//  Created by Uri on 28/9/24.
//

import SwiftUI

struct DetailHeaderButtons: View {
    
    @State private var isStarFilled: Bool = false
    var onBackButtonPressed: (() -> Void)? = nil
    var onFavPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    var triggerDelay: Double = 0.3
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircleButton(imageName: "arrowshape.down")
                .sensoryFeedback(.impact, trigger: trigger)
                .asButton(.press) {
                    trigger = true
                    onBackButtonPressed?()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ImageBlueCircleButton(imageName: isStarFilled ? "star.fill" : "star")
                .sensoryFeedback(.impact, trigger: trigger)
                .asButton(.press) {
                    trigger = true
                    withAnimation {
                        isStarFilled.toggle()
                    }
                    
                    onFavPressed?()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    ZStack {
        Color.red
        DetailHeaderButtons()
    }
    
}
