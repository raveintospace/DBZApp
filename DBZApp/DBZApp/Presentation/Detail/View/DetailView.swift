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
    
    var character: Character? = nil
    
    var body: some View {
        Text("This is DV")
    }
}

#Preview {
    DetailView()
}
