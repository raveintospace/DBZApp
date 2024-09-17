//
//  ImageOrangeCircleButton.swift
//  DBZApp
//
//  Created by Uri on 17/9/24.
//

import SwiftUI

struct ImageOrangeCircleButton: View {
    
    var imageName: String = ""
    
    var body: some View {
        Circle()
            .fill(.dbzOrange)
            .overlay(
                Image(systemName: imageName)
                    .offset(y: 1)
            )
            .frame(width: 50, height: 50)
            .foregroundStyle(.dbzBlue)
            .font(.title2)
            .fontWeight(.bold)
    }
}

#Preview {
    HStack {
        ImageBlueCircleButton(imageName: "heart.fill")
        ImageBlueCircleButton(imageName: "slider.vertical.3")
        ImageOrangeCircleButton(imageName: "heart.fill")
        ImageOrangeCircleButton(imageName: "slider.vertical.3")
    }
}
