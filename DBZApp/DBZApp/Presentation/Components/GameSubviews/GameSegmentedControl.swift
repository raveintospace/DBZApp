//
//  GameSegmentedControl.swift
//  DBZApp
//
//  Created by Uri on 12/12/24.
//

import SwiftUI

struct GameSegmentedControl: View {
    
    var options: [Int] = [2, 3, 5]
    @Binding var selection: Int
    @Namespace private var segmentedControl
    
    var body: some View {
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
                                    .fill(.dbzBlue)
                                    .matchedGeometryEffect(id: "selection", in: segmentedControl)
                            }
                        }
                    )
                    .foregroundColor(selection == option ? .dbzOrange : .dbzYellow)
                    .onTapGesture {
                        selection = option
                    }
            }
            .frame(maxWidth: .infinity)
            .animation(.smooth, value: selection)
        }
        .background(
            Capsule()
                .fill(.dbzBlue.opacity(0.5))
        )
    }
}

fileprivate struct GameSegmentedControlPreview: View {
    
    var options: [Int] = [2, 3, 5]
    @State private var selection = 2
    
    var body: some View {
        GameSegmentedControl(options: options, selection: $selection)
        .padding()
    }
    
}

#Preview {
    GameSegmentedControlPreview()
}

/*
 Text("\(option)")
     .frame(maxWidth: .infinity)
     .font(.headline)
     .fontWeight(.medium)
     .background(
         ZStack {
             if selection == option {
                 Capsule()
                     .fill(.dbzBlue)
                     .matchedGeometryEffect(id: "selection", in: segmentedControl)
             }
         }
     )
     .foregroundColor(selection == option ? .dbzYellow : .dbzOrange)
     .onTapGesture {
         selection = option
     }
}
.frame(maxWidth: .infinity)
.animation(.smooth, value: selection)
 */


