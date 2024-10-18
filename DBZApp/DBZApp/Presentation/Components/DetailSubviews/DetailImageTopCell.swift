//
//  DetailHeaderCell.swift
//  DBZApp
//
//  Created by Uri on 28/9/24.
//

import SwiftUI
import SwiftfulUI

struct DetailImageTopCell: View {
    
    var height: CGFloat = 300
    var imageName: String = Character.mockTwo.image
    
    var body: some View {
        ImageLoaderView(url: imageName)
            .padding(.top, 60)
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ScrollView {
        DetailImageTopCell()
    }
    .ignoresSafeArea()
}
