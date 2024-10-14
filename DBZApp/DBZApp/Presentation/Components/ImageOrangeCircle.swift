//
//  ImageOrangeCircleButton.swift
//  DBZApp
//
//  Created by Uri on 17/9/24.
//

import SwiftUI

struct ImageOrangeCircle: View {
    
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
        ImageBlueCircle(imageName: "heart.fill")
        ImageBlueCircle(imageName: "slider.vertical.3")
        ImageOrangeCircle(imageName: "heart.fill")
        ImageOrangeCircle(imageName: "slider.vertical.3")
        ImageOrangeCircle(imageName: "star.fill", frameSize: 26, fontSize: 13)
    }
}
