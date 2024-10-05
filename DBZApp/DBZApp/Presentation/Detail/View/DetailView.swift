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
    
    @State private var showHeader: Bool = true
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            detailWallpaper
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    DetailImageTopCell(height: 250, imageName: character.image)
                        .readingFrame { frame in
                            showHeader = frame.maxY < 100
                        }
                    
                    detailCharacterInfo
                }
            }
            .scrollIndicators(.hidden)
            
            header
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
    
    private var header: some View {
        DetailHeaderBar(
            headerTitle: character.name,
            showHeaderTitle: showHeader,
            
     //       isFavorite: homeViewModel.isFavorited(character: character),
            onBackButtonPressed: {
                router.dismissScreen()
            },
            onFavButtonPressed: {
   //             homeViewModel.updateFavorites(character: character)
            }
        )
        .padding()
        .padding(.top, -10)
        .background(showHeader ? Color.own.opacity(0.95) : Color.background.opacity(0.001))
        .foregroundStyle(.accent)
        .animation(.smooth(duration: 0.2), value: showHeader)
    }
    
    private var detailCharacterInfo: some View {
        DetailInfoSection(
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
