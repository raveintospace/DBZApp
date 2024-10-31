//
//  InfoBody.swift
//  DBZApp
//
//  Created by Uri on 31/10/24.
//

import SwiftUI

struct InfoBody: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let dragonBallApiURL = URL(string: "https://web.dragonball-api.com/")!
    let linkedinURL = URL(string: "https://www.linkedin.com/in/uri46/")!
    let gitHubURL = URL(string: "https://github.com/raveintospace")!
    
    var body: some View {
        List {
            appPurposeSection
                .listRowBackground(Color.own)
            dragonBallApiSection
                .listRowBackground(Color.own)
            developerSection
                .listRowBackground(Color.own)
            appSection
                .listRowBackground(Color.own)
        }
        .font(.headline)
        .tint(.dbzBlue)
        .listStyle(GroupedListStyle())
    }
}

#Preview {
    InfoBody()
}

extension InfoBody {
    
    private var appPurposeSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("dbzAppLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom, 10)
                Text("""
                    This is my most ambitious app to date. Through this project, I aim to showcase my recent learnings in clean code, asynchronous programming, reusable views, and appealing animations, to name a few.

                    The app leverages the MVVM architecture, Async/Await, and Core Data. The game section benefits from insights gained through my enrollment in Stanford University’s CS193p course (2023 lectures).
                    """)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.accent)
            }
            .padding(.vertical)
        } header: {
            Text("App purpose")
        }
    }
    
    private var dragonBallApiSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("dbzApiLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom, 10)
                Text("""
                The Dragon Ball data in this app is sourced from The Dragon Ball API.

                To make the information more coherent and also accessible in English, I’ve added some local data, as the API data is originally in Spanish.
                """)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.accent)
            }
            .padding(.vertical)
            Link("Visit The Dragon Ball API 🖥️", destination: dragonBallApiURL)
        } header: {
            Text("The Dragon Ball API")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("LinkPic")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom, 10)
                Text("""
                    Hi, I’m Uri, a junior iOS developer actively pursuing my first role in iOS development.

                    I’ve been learning independently and through courses from some of the most renowned iOS developers, including Paul Hudson, Swiftful Thinking and SwiftBeta.
                    """)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.accent)
            }
            .padding(.vertical)
            Link("Visit my Linkedin 👨🏻‍💻", destination: linkedinURL)
            Link("Visit my GitHub 🚀", destination: gitHubURL)
        } header: {
            Text("Developer")
        }
    }
    
    private var appSection: some View {
        Section {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        } header: {
            Text("Application")
        }
    }
}
