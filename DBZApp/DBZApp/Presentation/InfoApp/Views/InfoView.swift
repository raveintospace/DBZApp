//
//  InfoView.swift
//  DBZApp
//
//  Created by Uri on 29/10/24.
//

import SwiftUI
import SwiftfulRouting

struct InfoView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        ZStack {
            Color.dbzYellow.ignoresSafeArea()
            // set a wallpaper
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    RouterView { _ in
        InfoView()
    }
}

extension InfoView {
    
    private var header: some View {
        InfoHeaderBar(onBackButtonPressed: {
            router.dismissScreen()
        })
        .padding()
        .padding(.top, -10)
    }
}
