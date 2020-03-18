//
//  Preferences.swift
//  MenuBarTimer
//
//  Created by Gonzalo Rodríguez on 3/18/20.
//  Copyright © 2020 Gonzalo Rodríguez. All rights reserved.
//

import Foundation

protocol PreferencesProtocol {
    func updatePath(path: String);
}

class Preferences {
    var delegate: PreferencesProtocol?
    var currentPath: String {
        get {
            guard let savedPath = UserDefaults.standard.string(forKey: "selectedPath") else {
                return FileManager.default.homeDirectoryForCurrentUser.path
            }
            return savedPath
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedPath")
        }
    }
    
    func setToDefault() {
        print(currentPath)
        let defaultPath = FileManager.default.homeDirectoryForCurrentUser.path
        UserDefaults.standard.set(defaultPath, forKey: "selectedPath")
    }
}
