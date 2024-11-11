//
//  InfoView.swift
//  DBZApp
//
//  Created by Uri on 29/10/24.
//

import SwiftUI
import SwiftfulRouting

struct InfoView: View {
    
    @Environment(\.router) private var router
    
    var body: some View {
        ZStack {
            infoWallpaper
            
            VStack(spacing: 0) {
                header
                InfoBody()
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    RouterView { _ in
        InfoView()
    }
}

extension InfoView {
    
    private var infoWallpaper: some View {
        Image("infoWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)
    }
    
    private var header: some View {
        InfoHeaderBar(onBackButtonPressed: {
            router.dismissScreen()
        })
        .padding()
        .padding(.top, -10)
    }
}
