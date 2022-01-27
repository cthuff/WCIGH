//
//  TempusApp.swift
//  WatchApp WatchKit Extension
//
//  Created by Craig on 1/26/22.
//

import SwiftUI

@main
struct TempusApp: App {
    static let shift = Shift()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView().environmentObject(TempusApp.shift)
            }
        }
    }
}
