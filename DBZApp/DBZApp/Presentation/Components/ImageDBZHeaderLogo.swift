//
//  ImageHeaderLogo.swift
//  DBZApp
//
//  Created by Uri on 26/10/24.
//

import SwiftUI

struct ImageDBZHeaderLogo: View {
    var body: some View {
        Image("headerLogo")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    ImageDBZHeaderLogo()
}
