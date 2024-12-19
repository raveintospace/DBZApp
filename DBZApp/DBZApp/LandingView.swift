//
//  LandingView.swift
//  DBZApp
//
//  Created by Uri on 25/10/24.
//

import SwiftUI
import SwiftfulRouting

struct LandingView: View {
    
    @Environment(\.router) private var router
    @EnvironmentObject private var databaseViewModel: DatabaseViewModel
    
    var body: some View {
        ZStack {
            landingWallpaper
            
            VStack(spacing: 20) {
                ButtonAnimatedGlow(text: "Database", onButtonPressed: {
                    router.showScreen(.fullScreenCover) { _ in
                        DatabaseView()
                    }
                })
                
                ButtonAnimatedGlow(text: "Game", onButtonPressed: {
                    router.showScreen(.fullScreenCover) { _ in
                        GameView(databaseViewModel: databaseViewModel)
                    }
                })
                
                ButtonAnimatedGlow(text: " App info ", onButtonPressed: {
                    router.showScreen(.fullScreenCover) { _ in
                        InfoView()
                    }
                })
            }
            
            headerWithLogo
        }
    }
}

#Preview {
    RouterView { _ in
        LandingView()
    }
    .environmentObject(DeveloperPreview.instance.databaseViewModel)
}

extension LandingView {
    
    private var landingWallpaper: some View {
        Image("landingWallpaper")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .opacity(0.15)
    }
    
    private var headerWithLogo: some View {
        ImageDBZHeaderLogo()
            .frame(width: 300)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 10)
    }
}

