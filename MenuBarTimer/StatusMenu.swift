//
//  StatusMenu.swift
//  MenuBarTimer
//
//  Created by Gonzalo Rodríguez on 3/14/20.
//  Copyright © 2020 Gonzalo Rodríguez. All rights reserved.
//

import Cocoa

class StatusMenu: NSMenu {
    @IBOutlet weak var timerItem: NSMenuItem!
    

    let timer = MenuTimer()

    @IBAction func onStartTimer(_ sender: Any) {
        if timer.delegate == nil {
            timer.delegate = self
        }
        
        timer.startTimer()
    }
    
    private func textToDisplay(for elapsedTime: TimeInterval) -> String {
        let elapsedMinutes = (elapsedTime / 60).rounded()
        let elapsedSeconds = (elapsedTime - (elapsedMinutes * 60)).rounded()
        
        let minutesDisplay = String(format: "%02d", Int(elapsedMinutes))
        let secondsDisplay = String(format: "%02d", Int(elapsedSeconds))
        
        return "\(minutesDisplay):\(secondsDisplay)"
    }
    

    @IBAction func onQuit(_ sender: Any) {
        NSApp.terminate(sender)
    }
}

extension StatusMenu: MenuTimerProtocol {
    func elapsedTimeOnTimer(_ timer: MenuTimer, elapsedTime: TimeInterval) {
        updateDisplay(for: elapsedTime)
        print(elapsedTime)
    }
}

extension StatusMenu {
    func updateDisplay(for elapsedTime: TimeInterval) {
        timerItem.title = textToDisplay(for: elapsedTime)
    }
}
