//
//  LandingView.swift
//  DBZApp
//
//  Created by Uri on 25/10/24.
//

import SwiftUI
import SwiftfulRouting

struct LandingView: View {
    
    @Environment(\.router) var router
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            landingWallpaper
            
            VStack(spacing: 20) {
                ButtonBorderColorAnimated(text: "Home", onButtonPressed: {
                    router.showScreen(.fullScreenCover) { _ in
                        HomeView()
                    }
                })
                
                ButtonBorderColorAnimated(text: "Game", onButtonPressed: {
                    router.showScreen(.fullScreenCover) { _ in
                        HomeView()
                        // game
                    }
                })
                
                ButtonBorderColorAnimated(text: "App info", onButtonPressed: {
                    router.showScreen(.fullScreenCover) { _ in
                        HomeView()
                        // app info
                    }
                })
            }
            
            ImageDBZHeaderLogo()
                .frame(width: 300)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 10)
        }
    }
}

#Preview {
    RouterView { _ in
        LandingView()
    }
    .environmentObject(DeveloperPreview.instance.homeViewModel)
}

extension LandingView {
    
    private var landingWallpaper: some View {
        Image("landingWallpaper")
            .resizable()
            .scaledToFill()
            .offset(x: -25)
            .ignoresSafeArea()
            .opacity(0.15)
    }
}

/*
 Wallpaper all characters + mask amb dbzblue
 3 buttons
 SaiyanSans
 */

/*
 Text("Home")
     .font(Font.custom("SaiyanSans", size: 50))
     .kerning(5)
 Text("Game")
     .font(Font.custom("SaiyanSans", size: 50))
     .kerning(5)
 Text("App info")
     .font(Font.custom("SaiyanSans", size: 50))
     .kerning(5)
 */

