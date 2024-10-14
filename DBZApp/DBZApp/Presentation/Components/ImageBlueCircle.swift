//
//  ImageCircleButton.swift
//  DBZApp
//
//  Created by Uri on 16/9/24.
//

import SwiftUI

struct ImageBlueCircle: View {
    
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
        ImageBlueCircle(imageName: "heart.fill")
        ImageBlueCircle(imageName: "slider.vertical.3")
        ImageOrangeCircle(imageName: "heart.fill")
        ImageOrangeCircle(imageName: "slider.vertical.3")
    }
}
