//
//  ExpandableText.swift
//  DBZApp
//  https://adityagi02.medium.com/expanding-textview-in-swiftui-a-step-by-step-guide-8646696f2fc9
//  Created by Uri on 5/10/24.
//

import SwiftUI
import Foundation

public struct ExpandableText: View {
    var text : String
    
    var font: Font = .body
    var lineLimit: Int = 3
    var foregroundColor: Color = .primary
    
    var expandButton: TextSet = TextSet(text: "Read more", font: .callout, fontWeight: .bold, color: .blue)
    var collapseButton: TextSet? = TextSet(text: "Show less", font: .callout, fontWeight: .bold, color: .blue)
    
    var animation: Animation? = .none
    
    @State private var expand : Bool = false
    @State private var truncated : Bool = false
    @State private var fullSize: CGFloat = 0
    
    public init(text: String) {
        self.text = text
    }
    public var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Group {
                Text(text)
            }
            .font(font)
            .foregroundColor(foregroundColor)
            .lineLimit(expand == true ? nil : lineLimit)
            .animation(animation, value: expand)
            
            if truncated {
                if let collapseButton = collapseButton {
                    Button(action: {
                        self.expand.toggle()
                    }, label: {
                        Text(expand == false ? expandButton.text : collapseButton.text)
                            .font(expand == false ? expandButton.font : collapseButton.font)
                            .fontWeight(expandButton.fontWeight)
                            .foregroundColor(expand == false ? expandButton.color : collapseButton.color)
                    })
                }
                else if !expand {
                    Button(action: {
                        self.expand = true
                    }, label: {
                        Text(expandButton.text)
                            .font(expandButton.font)
                            .fontWeight(expandButton.fontWeight)
                            .foregroundColor(expandButton.color)
                    })
                }
            }
        }
        .background(
            ZStack{
                if !truncated {
                    if fullSize != 0 {
                        Text(text)
                            .font(font)
                            .lineLimit(lineLimit)
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            if fullSize > geo.size.height {
                                                self.truncated = true
                                            }
                                        }
                                }
                            )
                    }
                    
                    Text(text)
                        .font(font)
                        .lineLimit(999)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(GeometryReader { geo in
                            Color.clear
                                .onAppear() {
                                    self.fullSize = geo.size.height
                                }
                        })
                }
            }
                .hidden()
        )
    }
}

#Preview {
    ExpandableText(text: Character.mock.description)
        .padding()
}

// MARK: - ExpandableText Extension

extension ExpandableText {
    // Modify font
    public func font(_ font: Font) -> Self {
        var result = self
        result.font = font
        return result
    }
    
    // Modify line limit
    public func lineLimit(_ lineLimit: Int) -> Self {
        var result = self
        result.lineLimit = lineLimit
        return result
    }
    
    // Modify foreground color
    public func foregroundColor(_ color: Color) -> Self {
        var result = self
        result.foregroundColor = color
        return result
    }
    
    // Modify expand button
    public func expandButton(_ expandButton: TextSet) -> Self {
        var result = self
        result.expandButton = expandButton
        return result
    }
    
    // Modify collapse button
    public func collapseButton(_ collapseButton: TextSet) -> Self {
        var result = self
        result.collapseButton = collapseButton
        return result
    }
    
    // Modify expand animation
    public func expandAnimation(_ animation: Animation?) -> Self {
        var result = self
        result.animation = animation
        return result
    }
}

// MARK: - String Extension

extension String {
    // Measure height of string
    func height(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes).height
    }
    
    // Measure width of string
    func width(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes).width
    }
}

// MARK: - TextSet Struct

public struct TextSet {
    var text: String
    var font: Font
    var fontWeight: Font.Weight
    var color: Color

    public init(text: String, font: Font, fontWeight: Font.Weight, color: Color) {
        self.text = text
        self.font = font
        self.fontWeight = fontWeight
        self.color = color
    }
}

// MARK: - Font Conversion Function

func fontToUIFont(font: Font) -> UIFont {
    switch font {
    case .largeTitle: return .preferredFont(forTextStyle: .largeTitle)
    case .title: return .preferredFont(forTextStyle: .title1)
    case .title2, .title3: return .preferredFont(forTextStyle: .title2)
    case .headline: return .preferredFont(forTextStyle: .headline)
    case .subheadline: return .preferredFont(forTextStyle: .subheadline)
    case .callout: return .preferredFont(forTextStyle: .callout)
    case .caption: return .preferredFont(forTextStyle: .caption1)
    case .caption2, .footnote, .body: return .preferredFont(forTextStyle: .caption2)
    default: return .preferredFont(forTextStyle: .caption2)
    }
}
