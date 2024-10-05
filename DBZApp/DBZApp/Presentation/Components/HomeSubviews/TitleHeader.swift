//
//  TitleHeader.swift
//  DBZApp
//
//  Created by Uri on 16/9/24.
//

import SwiftUI
import SwiftfulUI

struct TitleHeader: View {
    
    var isStarFilled: Bool = false
    var onHomeButtonPressed: (() -> Void)? = nil
    var onFavButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    var triggerDelay: Double = 0.3
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircle(imageName: "house.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .asButton(.press) {
                    trigger = true
                    onHomeButtonPressed?()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("headerLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ImageBlueCircle(imageName: isStarFilled ? "star.fill" : "star")
                .sensoryFeedback(.impact, trigger: trigger)
                .rotationEffect(Angle(degrees: isStarFilled ? -72 : 0))
                .asButton(.press) {
                    trigger = true
                    withAnimation {
                        onFavButtonPressed?()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    TitleHeader()
}
