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
            .font(.title2)
            .padding(8)
            .background(
                Circle()
                    .stroke(lineWidth: 1))
            .foregroundStyle(.dbzBlue)
    }
}

#Preview {
    HStack {
        ImageCircleButton(imageName: "heart.fill")
        ImageCircleButton(imageName: "slider.vertical.3")
    }
}
