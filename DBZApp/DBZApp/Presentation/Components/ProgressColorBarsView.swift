//
//  ProgressColorBarsView.swift
//  DBZApp
//
//  Created by Uri on 12/10/24.
//

import SwiftUI

struct ProgressColorBarsView: View {
    
    @State private var currentIndex: Int = 0
    let colors: [Color] = [.dbzYellow, .dbzOrange, .dbzBlue]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<3) { index in
                RoundedRectangle(cornerRadius: 20)
                    .fill(colors[index])
                    .frame(width: 10, height: currentIndex == index ? 200 : 30)
                    .animation(.spring(duration: 0.9), value: currentIndex)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
}

#Preview {
    ProgressColorBarsView()
}

extension ProgressColorBarsView {
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.30, repeats: true) { timer in
            currentIndex = (currentIndex + 1) % colors.count
        }
    }
}
