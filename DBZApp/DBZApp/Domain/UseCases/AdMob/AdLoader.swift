//
//  AdLoader.swift
//  DBZApp
//
//  Created by Uri on 14/4/25.
//

import Foundation
import GoogleMobileAds

protocol AdLoading {
    func loadAd() async
    func showAd(completion: @escaping () -> Void)
}

class AdLoader: NSObject, AdLoading, FullScreenContentDelegate {
    private var interstitialAd: InterstitialAd?
    private var adCompletion: (() -> Void)?     // Property to store ad's completion
    private var lastAdShown: Date?
    private let adInterval: TimeInterval = 60
    
    func loadAd() async {
        do {
            interstitialAd = try await InterstitialAd.load(
                with: "ca-app-pub-3940256099942544/4411468910", request: Request())
            interstitialAd?.fullScreenContentDelegate = self
        } catch {
            debugPrint("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
    }
    
    func showAd(completion: @escaping () -> Void = {}) {
        if let lastAdShown = lastAdShown, Date().timeIntervalSince(lastAdShown) < adInterval {
            debugPrint("Ad skipped due to frequency limit.")
            completion()
            return
        }
        
        guard let interstitialAd = interstitialAd else {
            debugPrint("Ad wasn't ready.")
            completion()    // calls completion if there's no ad
            return
        }
        
        self.adCompletion = completion  // Store completion
        interstitialAd.present(from: nil)
    }
}

extension AdLoader {
    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
        debugPrint("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
        debugPrint("\(#function) called")
    }
    
    // Ad fails
    func ad(
        _ ad: FullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        debugPrint("\(#function) called")
        adCompletion?()
        adCompletion = nil
        interstitialAd = nil
        Task {
            await loadAd()
        }
    }
    
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        debugPrint("\(#function) called")
    }
    
    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        debugPrint("\(#function) called")
    }
    
    // Ad closes full screen
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        debugPrint("\(#function) called")
        adCompletion?()
        adCompletion = nil      // Clean completion
        interstitialAd = nil    // Clean interstitialAd
        Task {
            await loadAd()
        }
    }
}

// AdMob id for ads
// plist: ca-app-pub-6759758856409922~5632152930
// interstitial: ca-app-pub-6759758856409922/8351246237
// test: ca-app-pub-3940256099942544/4411468910



