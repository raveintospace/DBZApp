//
//  DetailView.swift
//  DBZApp
//
//  Created by Uri on 28/9/24.
//

import SwiftUI
import SwiftfulRouting
import ConfettiSwiftUI

struct DetailLoadingView: View {
    
    @Binding var character: Character?
    
    var body: some View {
        ZStack {
            if let character = character {
                DetailView(character: character)
            }
        }
    }
}

struct DetailView: View {
    
    @Environment(\.router) var router
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @StateObject private var viewModel: DetailViewModel
    
    init(character: Character) {
        _viewModel = StateObject(
            wrappedValue: DetailViewModel(
                character: character,
                fetchDetailCharacterUseCase: FetchDetailCharacterUseCaseImpl(
                    repository: DetailCharacterRepositoryImpl(
                        dataSource: NetworkDetailCharacterDataSource()
                    )
                )
            )
        )
    }
      
    @State private var showHeader: Bool = true
    @State private var offset: CGFloat = 0
    
    @State private var confettiCounter: Int = 0
    
    var body: some View {
        ZStack {
            detailWallpaper
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    DetailImageTopCell(height: 250, imageName: viewModel.character.image)
                        .readingFrame { frame in
                            showHeader = frame.maxY < 100
                        }
                    
                    if viewModel.isLoading {
                        ProgressColorBarsView()
                            .padding(.top, 60)
                    } else if let error = viewModel.error {
                        Text(error.errorDescription)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        detailCharacterInfo
                        bottomButtons
                    }
                }
            }
            .scrollIndicators(.hidden)
            .task {
                debugPrint("character id: \(viewModel.character.id)")
                await viewModel.fetchCharacterDetails(id: viewModel.character.id)
                if let detailedCharacter = viewModel.detailedCharacter {
                    debugPrint(detailedCharacter.originPlanet.translatedPlanetName)
                    debugPrint(detailedCharacter.transformations.count)
                    debugPrint(viewModel.hasTransformations())
                }
            }
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    RouterView { _ in
        DetailView(character: .mock)
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
            headerTitle: viewModel.character.name,
            showHeaderTitle: showHeader,
            isFavorite: homeViewModel.isFavorited(character: viewModel.character),
            onBackButtonPressed: {
                router.dismissScreen()
            },
            onFavButtonPressed: {
                homeViewModel.updateFavorites(character: viewModel.character)
                if homeViewModel.isFavorited(character: viewModel.character) {
                    confettiCounter += 1
                }
            }
        )
        .padding()
        .padding(.top, -10)
        .background(showHeader ? Color.own.opacity(0.95) : Color.background.opacity(0.001))
        .foregroundStyle(.accent)
        .animation(.smooth(duration: 0.2), value: showHeader)
        .confettiCannon(
            counter: $confettiCounter,
            num: 7,
            confettis: [.text("⭐️")],
            confettiSize: 50,
            radius: 3
        )
    }
    
    private var detailCharacterInfo: some View {
        DetailInfoSection(
            name: viewModel.character.name,
            gender: viewModel.character.genderToDisplay,
            kiPoints: viewModel.character.kiToDisplay,
            maxKi: viewModel.character.maxKiToDisplay,
            affiliation: viewModel.character.affiliation,
            race: viewModel.character.race,
            description: viewModel.character.description
        )
        .padding()
    }
    
    private var bottomButtons: some View {
        DetailBottomButtons(showTransformationsButton: viewModel.hasTransformations())
    }
}
