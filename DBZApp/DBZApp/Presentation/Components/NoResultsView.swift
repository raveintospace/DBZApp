//
//  NoResultsView.swift
//  DBZApp
//
//  Created by Uri on 14/9/24.
//

import SwiftUI

struct NoResultsView: View {
    
    var imageName: String = "circle.slash"
    var mainText: String = "No Results"
    var subText: String = "Invite the user to do something"
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: imageName)
                .font(.system(size: 50))
                .foregroundStyle(.dbzOrange)
                .background(
                    Circle()
                        .stroke(lineWidth: 3)
                        .foregroundStyle(.dbzOrange)
                        .frame(width: 100, height: 100))
                .padding(.bottom, 10)
            
            Text(mainText)
                .font(.system(size: 40))
                .bold()
            
            Text(subText)
                .font(.callout)
        }
        .foregroundColor(.accent)
        .multilineTextAlignment(.center)
        .padding(50)
    }
}

#Preview {
    NoResultsView(
        imageName: "person.slash",
        mainText: "No characters",
        subText: "There are no characters that match your search. Try with other filters or keywords."
    )
}
