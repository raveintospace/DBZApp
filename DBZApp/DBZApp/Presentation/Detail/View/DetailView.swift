//
//  DetailView.swift
//  DBZApp
//
//  Created by Uri on 28/9/24.
//

import SwiftUI
import SwiftfulRouting

struct DetailView: View {
    
    @Environment(\.router) var router
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var character: Character = Character.mock
    
    var body: some View {
        ZStack {
            detailWallpaper
            
            VStack(spacing: 0) {
                headerButtons
                ScrollView(.vertical) {
                    DetailHeaderImageCell(height: 250, imageName: character.image)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    DetailView()
}

extension DetailView {
    
    private var detailWallpaper: some View {
        Image("kingkaiWallpaper")
            .resizable()
            .ignoresSafeArea()
            .opacity(0.15)
    }
    
    private var headerButtons: some View {
        DetailHeaderButtons(
            onBackButtonPressed: router.dismissScreen
        )
        .padding()
    }
}
