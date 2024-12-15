//
//  DBZDivider.swift
//  DBZApp
//
//  Created by Uri on 15/12/24.
//

import SwiftUI

struct DBZDivider: View {
    
    var overlayColor: Color = .dbzYellow
    var negativePadding: CGFloat = -25
    
    var body: some View {
        Divider()
            .overlay(overlayColor)
            .padding(.horizontal, negativePadding)
    }
}

#Preview {
    ZStack {
        Color.dbzBlue.ignoresSafeArea()
        DBZDivider()
    }
}
