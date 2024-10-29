//
//  InfoHeaderBar.swift
//  DBZApp
//
//  Created by Uri on 29/10/24.
//

import SwiftUI

struct InfoHeaderBar: View {
    
    var headerTitle: String = "App info"
    var onBackButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    
    var body: some View {
        HStack(spacing: 0) {
            ImageBlueCircle(imageName: "arrowshape.down.fill")
                .sensoryFeedback(.impact, trigger: trigger)
                .withTrigger(trigger: $trigger) {
                    onBackButtonPressed?()
                }
                .frame(alignment: .leading)
                .padding(.trailing, 10)
                .background(.red)
            
            Text(headerTitle.uppercased())
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.blue)
            
            ImageBlueCircle(imageName: "arrowshape.down.fill")
                .hidden()
                .frame(alignment: .trailing)
                .background(.red)
        }
    }
}

#Preview {
    InfoHeaderBar()
}
