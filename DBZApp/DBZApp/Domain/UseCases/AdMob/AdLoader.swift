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
    func showAd()
}

class AdLoader: NSObject, AdLoading, FullScreenContentDelegate {
    private var interstitialAd: InterstitialAd?
    
    func loadAd() async {
        do {
            interstitialAd = try await InterstitialAd.load(
                with: "ca-app-pub-3940256099942544/4411468910", request: Request())
            interstitialAd?.fullScreenContentDelegate = self
        } catch {
            print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
    }
    
    func showAd() {
        guard let interstitialAd = interstitialAd else {
            return print("Ad wasn't ready.")
        }
        
        interstitialAd.present(from: nil)
    }
}

extension AdLoader {
    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func ad(
        _ ad: FullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        print("\(#function) called")
    }
    
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
        // Clear the interstitial ad.
        interstitialAd = nil
        Task {
            await loadAd()
        }
    }
}

// AdMob id for ads
// plist: ca-app-pub-6759758856409922~5632152930
// interstitial: ca-app-pub-6759758856409922/8351246237
// test: ca-app-pub-3940256099942544/4411468910



