//
//  AppDelegate.swift
//  MenuBarTimer
//
//  Created by Gonzalo Rodríguez on 3/14/20.
//  Copyright © 2020 Gonzalo Rodríguez. All rights reserved.
//

import Cocoa
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let startTimer = Name("startTimer")
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let menu = MenuViewController()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("MenuIcon"))
        }
        statusItem.menu = menu
        KeyboardShortcuts.onKeyUp(for: .startTimer) {
            if (self.menu.timer.isStopped) {
                self.menu.startTimer()
            } else {
                self.menu.pauseTimer()
            }
//            self.menu.popUp(positioning: self.menu.startItem, at: NSMakePoint(0, 0), in: nil)
//            print("toggle!")
        }
        
    }
        
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

