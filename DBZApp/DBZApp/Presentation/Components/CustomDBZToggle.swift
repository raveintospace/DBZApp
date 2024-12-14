//
//  CustomDBZToggle.swift
//  DBZApp
//
//  Created by Uri on 14/12/24.
//

import SwiftUI

struct CustomDBZToggle: ToggleStyle {
    var onColor: Color = .dbzOrange
    var offColor: Color = .dbzYellow.opacity(0.5)
    var knobColor: Color = .dbzBlue

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(knobColor)
                        .padding(3)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

#Preview {
    Toggle("Sound FX", isOn: .constant(false))
            .font(.title2)
            .bold()
            .foregroundStyle(.dbzYellow)
            .toggleStyle(CustomDBZToggle())
            .padding()
}
