//
//  ImageOrangeCircleButton.swift
//  DBZApp
//
//  Created by Uri on 17/9/24.
//

import SwiftUI

struct ImageOrangeCircleButton: View {
    
    var imageName: String = ""
    var frameSize: CGFloat = 50
    var fontSize: CGFloat = 25
    
    var body: some View {
        Circle()
            .fill(.dbzOrange)
            .overlay(
                Image(systemName: imageName)
            )
            .frame(width: frameSize, height: frameSize)
            .foregroundStyle(.dbzBlue)
            .font(.system(size: fontSize))
            .fontWeight(.bold)
    }
}

#Preview {
    HStack {
        ImageBlueCircleButton(imageName: "heart.fill")
        ImageBlueCircleButton(imageName: "slider.vertical.3")
        ImageOrangeCircleButton(imageName: "heart.fill")
        ImageOrangeCircleButton(imageName: "slider.vertical.3")
        ImageOrangeCircleButton(imageName: "star.fill", frameSize: 26, fontSize: 13)
    }
}
