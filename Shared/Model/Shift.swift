//
//  Shift.swift
//  Tempus
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

final class Shift: ObservableObject {
    
    @Published var start = Calendar.current.date(from: DateComponents(hour: 8))!
    @AppStorage("startTime", store: UserDefaults(suiteName: "group.com.sports.Tempus")) var startTime = 28800
    @AppStorage("lunchLength", store: UserDefaults(suiteName: "group.com.sports.Tempus")) var lunchLength = ""
    @AppStorage("workLength", store: UserDefaults(suiteName: "group.com.sports.Tempus")) var workLength = ""
    
    var endTime = Date()
    var timeRemaining = 3600

    //Calculates the time to end the shift by adding the lunch and shift length to the start time
    func clockOut() -> Date {
        
        let lunchTime = (Double(lunchLength) ?? 30) * 60
        let shiftTime = (Double(workLength) ?? 8) * 3600
        
        endTime = start.advanced(by: lunchTime + shiftTime)
        return endTime
    }
    
    //Returns the amount of seconds that are remaining when Current time is subtracted from the end of the shift
    //This return a variable so it can be called in and .onChange function in ContentView
    func remaining() -> Int {

        let time = Calendar.current.dateComponents([.hour, .minute, .second], from: endTime)
        let today = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now)

        let hours   = (time.hour ?? 0) - (today.hour ?? 0)
        let minutes = (time.minute ?? 0) - (today.minute ?? 0)
        let seconds = (time.second ?? 0) - (today.second ?? 0)

        timeRemaining = hours * 3600 + minutes * 60 + seconds
        return timeRemaining
    }

    //Does the math that is contained in shift.ClockOut and shift.Remaining, but uses local variables to allow for updaing when the data changes
    //Used for the Widget and the Watch App
    //The Math is the same as above but necessary since the views on the widget and the watch app don't change
    func timeString() -> Date {
        let lunchTime = (Double(lunchLength) ?? 30) * 60
        let shiftTime = (Double(workLength) ?? 8) * 3600
        let endTime = Calendar.current.date(from: DateComponents(hour: 0, minute: 0, second: 0))!.advanced(by: lunchTime + shiftTime + Double(startTime))
        
        let time = Calendar.current.dateComponents([.hour, .minute, .second], from: endTime)
        let today = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now)

        let hours   = (time.hour ?? 0) - (today.hour ?? 0)
        let minutes = (time.minute ?? 0) - (today.minute ?? 0)
        let seconds = (time.second ?? 0) - (today.second ?? 0)

        let tempTime = (hours * 3600 + minutes * 60 + seconds)
        
        return Date().advanced(by: Double(tempTime))
    }
    
}

