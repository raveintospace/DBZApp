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
            ImageBlueCircleButton(imageName: "house")
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("DBZApp")
                .font(.title)
                .foregroundStyle(.red)
                .background(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ImageBlueCircleButton(imageName: "star")
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    TitleHeader()
}
