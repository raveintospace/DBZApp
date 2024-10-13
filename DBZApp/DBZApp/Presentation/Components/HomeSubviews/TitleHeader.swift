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
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircle(imageName: "house.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onHomeButtonPressed?()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("headerLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ImageBlueCircle(imageName: isStarFilled ? "star.fill" : "star")
                .sensoryFeedback(.impact, trigger: trigger)
                .rotationEffect(Angle(degrees: isStarFilled ? -72 : 0))
                .withTrigger(trigger: $trigger) {
                    onFavButtonPressed?()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    TitleHeader()
}
