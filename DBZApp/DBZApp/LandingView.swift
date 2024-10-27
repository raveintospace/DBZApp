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
        List {
            Button("Home") {
                router.showScreen(.fullScreenCover) { _ in
                    HomeView()
                }
            }
            // Game
            // App info
        }
    }
}

#Preview {
    RouterView { _ in
        LandingView()
    }
    .environmentObject(DeveloperPreview.instance.homeViewModel)
}

/*
 Wallpaper all characters + mask amb dbzblue
 3 buttons
 */

