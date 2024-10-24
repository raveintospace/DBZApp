//
//  TransformationHeaderBar.swift
//  DBZApp
//
//  Created by Uri on 24/10/24.
//

import SwiftUI

struct TransformationHeaderButton: View {
    
    var onBackButtonPressed: (() -> Void)? = nil
    
    @State private var trigger = false
    
    var body: some View {
        ImageBlueCircle(imageName: "arrowshape.down.fill")
            .sensoryFeedback(.impact, trigger: trigger)
            .withTrigger(trigger: $trigger) {
                onBackButtonPressed?()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TransformationHeaderButton()
}
