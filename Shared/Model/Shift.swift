//
//  Shift.swift
//  Tempus
//
//  Created by Craig on 1/13/22.
//

import Foundation
import Combine
#if !os(macOS)
import WatchConnectivity
#endif
import SwiftUI

final class Shift: ObservableObject {
    
    @Published var start = Calendar.current.date(from: DateComponents(hour: 8))!
    @AppStorage("startTime", store: UserDefaults(suiteName: "group.com.sports.Tempus")) var startTime = 28800
    @AppStorage("lunchLength", store: UserDefaults(suiteName: "group.com.sports.Tempus")) var lunchLength = ""
    @AppStorage("workLength", store: UserDefaults(suiteName: "group.com.sports.Tempus")) var workLength = ""
    
    var endTime = Date()
    var timeRemaining = 3600

#if !os(macOS)
    var session: WCSession
    let delegate: WCSessionDelegate
    let subject = PassthroughSubject<Int, Never>()
    
    @Published private(set) var sharedShift = 30600
    
    //Inits the session between the phone and the watch
    //Could possible look to limit this if a device doesn't have a paired watch
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(countSubject: subject)
        self.session = session
        self.session.delegate = self.delegate
        self.session.activate()
        
        subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$sharedShift)
    }
#endif
    
    //MARK: Shared
    
    func lunchInMinutes(lunch: String) -> Double{
        return (Double(lunch) ?? 30) * 60
    }
    
    func workLengthInMinutes(work: String) -> Double{
        return (Double(work) ?? 8) * 3600
    }
    
    
    //Calculates the time to end the shift by adding the lunch and shift length to the start time
    func clockOut() -> Date {
        
        let lunchTime = lunchInMinutes(lunch: lunchLength)
        let shiftTime = workLengthInMinutes(work: workLength)
        
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

    //MARK: Widget
    //Does the math that is contained in shift.ClockOut and shift.Remaining, but uses local variables to allow for updaing when the data changes
    //Used for the Widget and the Watch App
    //The Math is the same as above but necessary since the views on the widget and the watch app don't change
    func timeString() -> Date {
        let lunchTime = lunchInMinutes(lunch: lunchLength)
        let shiftTime = workLengthInMinutes(work: workLength)
        let endTime = Calendar.current.date(from: DateComponents(hour: 0, minute: 0, second: 0))!.advanced(by: lunchTime + shiftTime + Double(startTime))
        
        let time = Calendar.current.dateComponents([.hour, .minute, .second], from: endTime)
        let today = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now)

        let hours   = (time.hour ?? 0) - (today.hour ?? 0)
        let minutes = (time.minute ?? 0) - (today.minute ?? 0)
        let seconds = (time.second ?? 0) - (today.second ?? 0)

        let tempTime = (hours * 3600 + minutes * 60 + seconds)
        
        return Date().advanced(by: Double(tempTime))
    }
    
    //MARK: Apple Watch
    
    //Handles sending the updated data to the watch when the start time, lunch length, or work length change
    //This way all of the data is handled by the shift class and we don't need hella environment variables
//    func sendToWatch(updatedValue: [String : Int]) {
#if !os(macOS)
    func sendToWatch() {
        sharedShift = Int(workLengthInMinutes(work: workLength) + lunchInMinutes(lunch: lunchLength))
        do {
            try self.session.updateApplicationContext(["sharedShift" : sharedShift, "lunchLength" : self.lunchLength, "workLength" : self.workLength, "startTime" : self.startTime])
        } catch {
            print("whoops")
        }
    }
#endif
    
}

