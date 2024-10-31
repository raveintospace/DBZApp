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
                .listRowBackground(Color.background)
            dragonBallApiSection
                .listRowBackground(Color.background)
            developerSection
                .listRowBackground(Color.background)
            appSection
                .listRowBackground(Color.background)
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
                Text("""
                    With this app I want to show my skills as an iOS developer. I have practiced some learnings from previous programs, but I have also acquired a lot of knowledge, facing challenges, a few dead end situations and refactor sessions.

                    It uses MVVM architechture, Combine & CoreData.
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
                Image("ods")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom, 10)
                Text("""
                The Airbnb data used in this app comes from a free Opendatasoft's API. JSON content may vary or come incomplete.
                
                Some dummy data has been added, as the app was created with a json response that is completely different from the current one offered by Opendatasoft.
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
                    This is Uri, a junior iOS developer trying to get my first iOS job.

                    I have learned autonomously and by taking courses from some of the most renowned iOS developers, such as Paul Hudson, Swiftful Thinking or SwiftBeta.
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
