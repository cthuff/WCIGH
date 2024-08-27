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
//    #if os(macOS)
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    #endif
    var body: some Scene {
        #if os(macOS)
        MenuBarExtra("UtilityApp", systemImage: "clock.badge.checkmark") {
            ContentView().environmentObject(TempusApp.shift)
               }.menuBarExtraStyle(.window)
        #else
        WindowGroup {
            ContentView().environmentObject(TempusApp.shift)
        }
        #endif
    }

}
//#if os(macOS)
////This allows the application to run as a macOS Menu Bar App
////Handles everything to load the view 
//class AppDelegate: NSObject, NSApplicationDelegate {
//    
//    var statusItem: NSStatusItem?
//    var popOver = NSPopover()
//    var shift = Shift()
//    func applicationDidFinishLaunching(_ notification: Notification) {
//        
//        if let window = NSApplication.shared.windows.first {
//                    window.close()
//                }
//        
//        let contentView = ContentView().environmentObject(shift)
//        
//        popOver.behavior = .transient
//        popOver.animates = true
//        popOver.contentViewController = NSViewController()
//        popOver.contentViewController?.view = NSHostingView(rootView: contentView)
//        
//        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        
//        if let MenuButton = statusItem?.button{
//            MenuButton.image =  NSImage(systemSymbolName: "clock.badge.checkmark", accessibilityDescription: nil)
//            MenuButton.action = #selector(MenuButtonToggle)
//        }
//    }
//    @objc func MenuButtonToggle(){
//        if let menuButton = statusItem?.button{
//            
//            self.popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.minY)
//        }
//    }
//}
//#endif
