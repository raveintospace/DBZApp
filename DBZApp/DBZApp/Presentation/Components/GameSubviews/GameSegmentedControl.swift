//
//  GameSegmentedControl.swift
//  DBZApp
//
//  Created by Uri on 12/12/24.
//

import SwiftUI

struct GameSegmentedControl: View {
    
    var segmentedTitle: String = "Some title"
    var options: [Int] = [2, 3, 5]
    var isEnabled: Bool = true
    var disabledAction: (() -> Void)? = nil
    @Binding var selection: Int
    @Namespace private var segmentedControl
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            title
            selector
        }
    }
}

fileprivate struct GameSegmentedControlPreview: View {
    
    var segmentedTitle: String = "Number of sets"
    var options: [Int] = [2, 3, 5]
    @State private var selection = 2
    
    var body: some View {
        VStack(spacing: 20) {
            GameSegmentedControl(segmentedTitle: segmentedTitle, options: options, isEnabled: false, selection: $selection)
            GameSegmentedControl(segmentedTitle: segmentedTitle, options: options, isEnabled: true, selection: $selection)
        }
        .padding()
    }
    
}

#Preview {
    ZStack {
        Color.dbzBlue
        GameSegmentedControlPreview()
    }
}

extension GameSegmentedControl {
    
    private var title: some View {
        Text(segmentedTitle)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.dbzYellow)
    }
    
    private var selector: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                Text("\(option)")
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .bold()
                    .background(
                        ZStack {
                            if selection == option {
                                Capsule()
                                    .fill(isEnabled ? .dbzOrange : .dbzOrange.opacity(0.5))
                                    .matchedGeometryEffect(id: "selection", in: segmentedControl)
                            }
                        }
                    )
                    .foregroundStyle(selection == option ? .dbzBlue : .dbzBlue)
                    .onTapGesture {
                        isEnabled ? selection = option : disabledAction?()
                    }
            }
            .frame(maxWidth: .infinity)
            .animation(.smooth, value: selection)
        }
        .background(
            Capsule()
                .fill(isEnabled ? .dbzYellow : .dbzYellow.opacity(0.2))
        )
    }
}

