//
//  ImageCircleButton.swift
//  DBZApp
//
//  Created by Uri on 16/9/24.
//

import SwiftUI

struct ImageBlueCircleButton: View {
    
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
        ImageBlueCircleButton(imageName: "heart.fill")
        ImageBlueCircleButton(imageName: "slider.vertical.3")
        
        Circle()
            .fill(.dbzOrange)
            .overlay(
                Image(systemName: "xmark")
                    .offset(y: 1)
            )
            .frame(width: 40, height: 40)
            .foregroundStyle(.dbzBlue)
            .font(.title2)
            .fontWeight(.bold)
    }
}
