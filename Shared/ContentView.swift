//
//  ContentView.swift
//  Shared
//
//  Created by Craig on 1/12/22.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var shift: Shift
    
    @State private var timeRemaining = 3600
    @State private var showPrefs = false
    @State private var showInfo = false
    @State private var isRotated = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            HStack{
                //Places the info button at the bottom of the application.
                //When this button is pressed, toggle between this View and InfoView
                Button(action: {withAnimation(Animation.linear(duration: 0.25)) {showInfo.toggle(); isRotated.toggle(); showPrefs = false}}){
                    Image(systemName: "info.circle")
                }
                .padding(.top, 15)
                .padding(.bottom)
                .padding(.leading, 15)
                .frame(alignment: .leading)
                Spacer()
                //Places the gear button at the top of the application.
                //When this button is pressed, toggle between this View and PreferencesView
                Button(action: {withAnimation(Animation.linear(duration: 0.25)) {showPrefs.toggle(); showInfo = false; isRotated.toggle()}}){
                    Image(systemName: "gearshape.fill")
                        .rotationEffect(Angle.degrees(isRotated ? 300 : 0))
                }
                .padding(.top, 15)
                .padding(.bottom)
                .padding(.trailing, 15)
                .frame(alignment: .trailing)
                
                
            }
            //Loads the main content of the application
            if(showPrefs == false && showInfo == false){
                ClockIn()
                Lunch()
                ShiftLength()
                ClockOut()
                HStack{
                    Text("Time Remaining:")
                    Text("\(timeString(timeRemaining))")
                        .foregroundColor(.cyan)
                    //Since shift.remaining returns a value, each time it changes, we want the timeRemaining to match that value 
                        .onChange(of: shift.remaining()) { _ in
                            timeRemaining = shift.timeRemaining
                        }
                }
                .padding(.top, 15)
                .font(.title2)
            } else if (showPrefs == true) {
                //Loads the Preferences for the Application
                PreferencesView()
                //When this button is pressed, return to the main View above
                Button(action: {withAnimation(Animation.linear(duration: 0.25)) {showPrefs.toggle(); showInfo = false}}){
                    Text("Save")
                        .padding()
                }
                .padding(.top, 10)
            } else if (showInfo == true){
                InfoView()
                Button(action: {withAnimation(Animation.linear) {showInfo.toggle(); showPrefs = false}}){
                    Text("Dismiss")
                        .padding()
                }
                .padding(.top, 10)
            }
            HStack{
                
                #if os(macOS)
                Spacer()
                //Since the Applicaiton doesn't exist in the dock, a quit button will be loaded at the bottom so the user can close it at any time
                QuitButton()
                #endif
            }
        }
        //After the app is loaded, reset the saved start time so the widget will update to a new start time when it changes
        .onAppear(perform: {shift.startTime = 28800})
        .frame(minWidth: 350, maxWidth: 450)
        .onReceive(timer) { time in
            timeRemaining -= 1
        }
        //Update the widget when the app is being closed out on iOS. Prevents unecessary background updates.
        //Note: There is a slight delay in the update and the Widget loading the data that looks a little funky, but doesn't effect usability
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    //Accepts an integer of time in seconds that will be convereted into a time string that is displayed in the text field
    func timeString(_ time: Int) -> String {
        
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static let shift = Shift()
    static var previews: some View {
        Group {
            ContentView().environmentObject(shift)
        }
    }
}

#if canImport(UIKit)
//When the "done" button is pressed on the Keyboard Toolbar, this dismisses the keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
