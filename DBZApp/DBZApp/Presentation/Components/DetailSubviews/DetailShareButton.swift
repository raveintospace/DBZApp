//
//  DetailShareButton.swift
//  DBZApp
//
//  Created by Uri on 23/12/24.
//

import SwiftUI

struct DetailShareButton: View {
    
    var url: String = "https://www.apple.com"
    
    @State private var trigger: Bool = false
    
    var body: some View {
        if let url = URL(string: url) {
            ShareLink(item: url) {
                ImageBlueCircle(imageName: "paperplane.fill")
            }
        }
    }
}

#Preview {
    DetailShareButton()
}
