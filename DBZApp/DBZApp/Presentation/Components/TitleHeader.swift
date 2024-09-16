//
//  TitleHeader.swift
//  DBZApp
//
//  Created by Uri on 16/9/24.
//

import SwiftUI

struct TitleHeader: View {
    var body: some View {
        HStack(spacing: 0) {
            ImageCircleButton(imageName: "house.fill")
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.red)
                .background(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ImageCircleButton(imageName: "heart")
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
    }
}

#Preview {
    TitleHeader()
}
