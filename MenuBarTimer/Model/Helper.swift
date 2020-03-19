//
//  Helper.swift
//  MenuBarTimer
//
//  Created by Gonzalo Rodríguez on 3/18/20.
//  Copyright © 2020 Gonzalo Rodríguez. All rights reserved.
//

import Foundation

class Helper {
    static func formatInterval(for elapsedTime: TimeInterval) -> String{
        
        let elapsedHours = floor(elapsedTime / 3600)
        let elapsedMinutes = floor((elapsedTime - (elapsedHours * 3600)) / 60)
        let elapsedSeconds = elapsedTime - (elapsedHours * 3600 + elapsedMinutes * 60)
        
        let hoursDisplay = String(format: "%02d", Int(elapsedHours))
        let minutesDisplay = String(format: "%02d", Int(elapsedMinutes))
        let secondsDisplay = String(format: "%02d", Int(elapsedSeconds))
        
        return "\(hoursDisplay):\(minutesDisplay):\(secondsDisplay)"
    }
}
