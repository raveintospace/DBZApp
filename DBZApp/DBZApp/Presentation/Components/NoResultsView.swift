//
//  NoResultsView.swift
//  DBZApp
//
//  Created by Uri on 14/9/24.
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "person.slash")
                .font(.system(size: 50))
                .foregroundStyle(.orange.opacity(0.5))
                .background(
                    Circle()
                        .stroke(lineWidth: 3)
                        .foregroundStyle(.orange.opacity(0.5))
                        .frame(width: 100, height: 100))
                .padding(.bottom, 10)
            
            Text("No characters")
                .font(.system(size: 40))
                .bold()
            
            Text("There are no characters that match your search. Try with other filters or keywords.")
                .font(.callout)
        }
        .foregroundColor(.accent)
        .multilineTextAlignment(.center)
        .padding(50)
    }
}

#Preview {
    NoResultsView()
}
