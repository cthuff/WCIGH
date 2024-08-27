//
//  SessionDelegator.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/15/21.
//

import Combine
import WatchConnectivity

class SessionDelegater: NSObject, WCSessionDelegate {
    
    let countSubject: PassthroughSubject<Int, Never>
    
    init(countSubject: PassthroughSubject<Int, Never>) {
        self.countSubject = countSubject
        super.init()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Protocol comformance only
        // Not needed for this demo
    }
    
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async(execute: {
            if let info = applicationContext["sharedShift"] as? Int {
                UserDefaults(suiteName:"group.com.sports-warehouse.Tempus")!.set(applicationContext["workLength"] as! String, forKey: "workLength")
                UserDefaults(suiteName:"group.com.sports-warehouse.Tempus")!.set(applicationContext["lunchLength"] as! String, forKey: "lunchLength")
                UserDefaults(suiteName:"group.com.sports-warehouse.Tempus")!.set(applicationContext["startTime"] as! Int, forKey: "startTime")
                self.countSubject.send(info)
            } else {
                print("There was an error")
            }})
    
    }
    
    // iOS Protocol comformance
    // Not needed for this demo otherwise
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif
    
}
