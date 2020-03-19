//
//  StatusMenu.swift
//  MenuBarTimer
//
//  Created by Gonzalo Rodríguez on 3/14/20.
//  Copyright © 2020 Gonzalo Rodríguez. All rights reserved.
//

import Cocoa
import CSV

class MenuViewController: NSMenu {
    @IBOutlet weak var timerItem: NSMenuItem!
    @IBOutlet weak var startItem: NSMenuItem!
    @IBOutlet weak var pauseItem: NSMenuItem!
    @IBOutlet weak var stopItem: NSMenuItem!
    
    let timer = MenuTimer()
    let preferences = Preferences()
    
    @IBAction func onStartItem(_ sender: Any) {
        if (timer.delegate == nil) {
            timer.delegate = self
        }
        
        timer.startTimer()
        RunLoop.current.add(timer.timer!, forMode: RunLoop.Mode.common)
    }
    
    @IBAction func onPauseItem(_ sender: Any) {
        if !timer.isPaused {
            timer.pauseTimer()
        } else {
            timer.resumeTimer()
            RunLoop.current.add(timer.timer!, forMode: RunLoop.Mode.common)
        }
    }
    
    @IBAction func onStopItem(_ sender: Any) {
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.critical
        let fileUrl = URL(fileURLWithPath: preferences.currentPath)
        
        do {
            try Data.writeCSV(startDate: timer.startTime!, endDate: Date(), totalTime: timer.elapsedTime, fileUrl: fileUrl)
            
        } catch DataError.notWrite {
            alert.messageText = "Could not write file"
            alert.runModal()
        } catch DataError.notInitialize {
            alert.messageText = "Could not initialize file"
            alert.runModal()
        } catch {
            alert.messageText = "Unexpected error"
            alert.runModal()
        }
        
        timer.stopTimer()
    }
    
    private func textToDisplay(for elapsedTime: TimeInterval) -> String {
        return Helper.formatInterval(for: elapsedTime)
    }
    
    @IBAction func onQuitTimer(_ sender: Any) {
        NSApp.terminate(sender)
    }
    
    func updateButtons() {
        if timer.isStopped {
            startItem.isHidden = false
            pauseItem.isHidden = true
            stopItem.isHidden = true
        } else if timer.isPaused {
            startItem.isHidden = true
            pauseItem.title = "Resume"
            pauseItem.isHidden = false
            stopItem.isHidden = false
        } else if timer.isRunning {
            startItem.isHidden = true
            pauseItem.title = "Pause"
            pauseItem.isHidden = false
            stopItem.isHidden = false
        }
    }
}

extension MenuViewController: MenuTimerProtocol {
    func elapsedTimeOnTimer(_ timer: MenuTimer, elapsedTime: TimeInterval) {
        updateDisplay(for: elapsedTime)
        updateButtons()
    }
}

extension MenuViewController {
    func updateDisplay(for elapsedTime: TimeInterval) {
        timerItem.title = textToDisplay(for: elapsedTime)
    }
}

