//
//  DBZAppApp.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import SwiftUI
import SwiftfulRouting
import GoogleMobileAds
import AppTrackingTransparency

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // AdMob
        MobileAds.shared.start(completionHandler: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.requestTrackingAuthorization()
        }
        
        return true
    }
    
    // ATT
    private func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    debugPrint("Tracking granted")
                case .denied:
                    debugPrint("Tracking denied")
                case .notDetermined:
                    debugPrint("Tracking not set")
                case .restricted:
                    debugPrint("Tracking restricted")
                @unknown default:
                    debugPrint("Unknown status")
                }
            }
        }
    }
}

@main
struct DBZApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var vm = DatabaseViewModel(
        getLocalCharactersUseCase: GetLocalCharactersUseCaseImpl(
            repository: CharacterRepositoryImpl(
                localDataSource: LocalCharacterDataSource(),
                networkDataSource: NetworkCharacterDataSource()
            )
        ),
        fetchCharactersFromAPIUseCase: FetchCharactersFromAPIUseCaseImpl(
            repository: CharacterRepositoryImpl(
                localDataSource: LocalCharacterDataSource(),
                networkDataSource: NetworkCharacterDataSource()
            )
        ),
        getFiltersUseCase: GetFiltersUseCaseImpl(repository: FilterRepositoryImpl()),
        sortCharactersUseCase: SortCharactersUseCaseImpl(),
        favoritesUseCase: FavoritesUseCaseImpl(
            repository: FavoritesRepositoryImpl(
                dataSource: FavoritesDataSource()
            )
        )
    )
    
    @State private var showSplashView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                RouterView { _ in
                    LandingView()
                }
                .environmentObject(vm) // -> Available for the whole app
                
                SplashView(showSplashView: $showSplashView)
                    .opacity(showSplashView ? 1.0 : 0.0)
            }
        }
    }
}
