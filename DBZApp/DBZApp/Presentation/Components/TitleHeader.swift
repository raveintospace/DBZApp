//
//  TitleHeader.swift
//  DBZApp
//
//  Created by Uri on 16/9/24.
//

import SwiftUI
import SwiftfulUI

struct TitleHeader: View {
    
    @State private var isStarFilled: Bool = false
    var onHomePressed: (() -> Void)? = nil
    var onFavPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    var triggerDelay: Double = 0.3
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircleButton(imageName: "house")
                .sensoryFeedback(.impact, trigger: trigger)
                .asButton(.press) {
                    trigger = true
                    onHomePressed?()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + triggerDelay) {
                        trigger = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("headerLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .center)
            
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
    TitleHeader()
}
