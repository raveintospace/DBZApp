//
//  HomeView.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }
    
    var body: some View {
        List(viewModel.characters) { character in
            VStack(alignment: .leading) {
                Text(character.name)
                Text(character.race)
                Text(character.affiliation)
            }
                .foregroundStyle(.accent)
        }
        .task {
            await viewModel.loadLocalCharacters()
        }
    }
}

#Preview {
    HomeView(viewModel: DeveloperPreview.instance.homeViewModel)
}
