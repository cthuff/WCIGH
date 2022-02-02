//
//  Counter.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/18/21.
//

//import Foundation
//import Combine
//import WatchConnectivity
//
//final class Counter: ObservableObject {
//    var session: WCSession
//    let delegate: WCSessionDelegate
//    let subject = PassthroughSubject<Int, Never>()
//    
//    @Published private(set) var sharedShift = 0
//    
//    init(session: WCSession = .default) {
//        self.delegate = SessionDelegater(countSubject: subject)
//        self.session = session
//        self.session.delegate = self.delegate
//        self.session.activate()
//        
//        subject
//            .receive(on: DispatchQueue.main)
//            .assign(to: &$sharedShift)
//    }
//    
//    func sendToWatch(updatedValue: [String : Int]) {
//        do {
//            try self.session.updateApplicationContext(updatedValue)
//            print(session.applicationContext)
//        } catch {
//            print("whoops")
//        }
//    }
//}
