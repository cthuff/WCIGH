//
//  Shift.swift
//  Tempus
//
//  Created by Craig on 1/13/22.
//

import Foundation

import SwiftUI

final class Shift: ObservableObject {
    
    @Published var start = Calendar.current.date(from: DateComponents(hour: 8))!
    @AppStorage("lunchLength", store: UserDefaults(suiteName: "group.com.craighuff.Tempus")) var lunchLength = ""
    @AppStorage("workLength", store: UserDefaults(suiteName: "group.com.craighuff.Tempus")) var workLength = ""
    
    var endTime = Date()
    var timeRemaining = 3600

    func clockOut() -> Date {
        
        let lunchTime = (Double(lunchLength) ?? 30) * 60
        let shiftTime = (Double(workLength) ?? 8) * 60 * 60
        
        endTime = start.advanced(by: lunchTime + shiftTime)
        return endTime
    }
    
    func remaining() -> String {

        let time = Calendar.current.dateComponents([.hour, .minute, .second], from: endTime)
        let today = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now)

        let hours   = (time.hour ?? 0) - (today.hour ?? 0)
        let minutes = (time.minute ?? 0) - (today.minute ?? 0)
        let seconds = (time.second ?? 0) - (today.second ?? 0)

        timeRemaining = hours * 3600 + minutes * 60 + seconds
        
        return String(format:"%02i:%02i:%02i", hours, minutes >= 0 ? minutes - 1: minutes + 59, seconds > 0 ? seconds : seconds + 60)
    }

}

