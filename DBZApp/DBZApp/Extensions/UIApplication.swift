//
//  UIApplication.swift
//  DBZApp
//
//  Created by Uri on 6/9/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    // dismiss keyboard
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
