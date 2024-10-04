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
    
    var character: Character = .mock
    
    var body: some View {
        ZStack {
            detailWallpaper
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    DetailHeaderImageCell(height: 250, imageName: character.image)
                    detailCharacterInfo
                }
            }
            .scrollIndicators(.hidden)
            
            headerButtons
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    RouterView { _ in
        DetailView()
            .environmentObject(DeveloperPreview.instance.homeViewModel)
    }
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
     //       isFavorite: homeViewModel.isFavorited(character: character),
            onBackButtonPressed: {
                router.dismissScreen()
            },
            onFavButtonPressed: {
   //             homeViewModel.updateFavorites(character: character)
            }
        )
        .padding()
    }
    
    private var detailCharacterInfo: some View {
        DetailInfoBlock(
            name: character.name,
            gender: character.genderToDisplay,
            kiPoints: character.kiToDisplay,
            maxKi: character.maxKiToDisplay,
            affiliation: character.affiliation,
            race: character.race,
            description: character.description
        )
        .padding()
    }
}
