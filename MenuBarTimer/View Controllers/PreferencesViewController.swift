//
//  Preferences.swift
//  MenuBarTimer
//
//  Created by Gonzalo Rodríguez on 3/17/20.
//  Copyright © 2020 Gonzalo Rodríguez. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {
    @IBOutlet weak var pathLabel: NSTextField!
    var preferences = Preferences()

    @IBAction func choosePath(_ sender: Any) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        
        if panel.runModal() == NSApplication.ModalResponse.OK {
            preferences.currentPath = panel.urls[0].path
            updateDisplay()
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    @IBAction func onOK(_ sender: Any) {
        self.view.window?.windowController?.close()
    }
    
    @IBAction func setToDefault(_ sender: Any) {
        preferences.setToDefault()
        updateDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPrefs()
    }
    
}

extension PreferencesViewController {
    func setupPrefs() {
        pathLabel.stringValue = preferences.currentPath
    }
    
    func updateDisplay() {
        pathLabel.stringValue = preferences.currentPath
    }
}
