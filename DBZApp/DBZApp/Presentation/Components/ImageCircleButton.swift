//
//  ImageCircleButton.swift
//  DBZApp
//
//  Created by Uri on 16/9/24.
//

import SwiftUI

struct ImageCircleButton: View {
    
    var imageName: String = ""
    
    var body: some View {
        Image(systemName: imageName)
            .padding(8)
            .background(
                Circle()
                    .stroke(lineWidth: 1))
            .foregroundStyle(.dbzBlue)
    }
}

#Preview {
    ImageCircleButton(imageName: "heart.fill")
}
