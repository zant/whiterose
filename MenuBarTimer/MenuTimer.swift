//
//  Timer.swift
//  MenuBarTimer
//
//  Created by Gonzalo Rodríguez on 3/14/20.
//  Copyright © 2020 Gonzalo Rodríguez. All rights reserved.
//

import Foundation

protocol MenuTimerProtocol {
    func elapsedTimeOnTimer(_ timer: MenuTimer, elapsedTime: TimeInterval)
}

class MenuTimer {
    var timer: Timer? = nil
    var startTime: Date?
    var elapsedTime: TimeInterval = 0
    var delegate: MenuTimerProtocol?

    init() {}
    
    @objc dynamic func timerAction() {
        guard let startTime = startTime else {
            return
        }
        
        elapsedTime = -startTime.timeIntervalSinceNow
        
        delegate?.elapsedTimeOnTimer(self, elapsedTime: elapsedTime)
    }
    
     func startTimer() {
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)

        timerAction()
    }
}
