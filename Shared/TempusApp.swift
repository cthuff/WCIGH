//
//  TempusApp.swift
//  Shared
//
//  Created by Craig on 1/12/22.
//

import SwiftUI

@main
struct TempusApp: App {
    static let shift = Shift()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(TempusApp.shift)
        }
    }
}
