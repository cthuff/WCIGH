//
//  GoHomeButton.swift
//  Tempus
//
//  Created by Craig on 3/10/22.
//

import SwiftUI
import UserNotifications

struct GoHomeButton: View {
    @EnvironmentObject var shift: Shift
    @State var goHome = false
    @State var stayHere = false
    
    var body: some View {
        VStack{
            Button(action: {
                //iOS will present an alert inside the application
//                #if os(iOS)
                if (shift.timeRemaining <= 0 ) {
                    goHome.toggle()
                } else {
                    stayHere.toggle()
                }
                //Since macOS app runs in menu bar, alert doesn't work -- Use Notification center
//                #elseif os(macOS)
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        let content = UNMutableNotificationContent()
//                        if (shift.timeRemaining <= 0 ) {
//                            content.title = "Get out of here!"
//                            content.subtitle = "👋🏼"
//                        } else {
//                            content.title = "Sorry, you're stuck here"
//                            content.subtitle = "💁🏼‍♂️"
//                        }
//                        
//                        content.sound = UNNotificationSound.default
//                        content.badge = 1
//                        
//                        // show this notification as close to instantly as we can
//                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
//                        
//                        // choose a random identifier
//                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//                        
//                        // add our notification request
//                        UNUserNotificationCenter.current().add(request)
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//                #endif
            }
            ) {
                Text("Can I Go Home?")
//                    .foregroundColor(Color("TextColor"))
            }
            .buttonStyle(.borderedProminent)
//            .tint(.primary)
            .alert("Get out of here!" , isPresented: $goHome) {
                Button("Dismiss", role: .cancel) {
                }
            }
            .alert("Sorry, you're stuck here", isPresented: $stayHere) {
                Button("Dismiss", role: .cancel) { }
            }
            .badge(1)
            
        }
    }
}

struct GoHomeButton_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        GoHomeButton().environmentObject(shift)
//            .preferredColorScheme(.dark)
    }
}
