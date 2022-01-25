//
//  ContentView.swift
//  Shared
//
//  Created by Craig on 1/12/22.
//

import SwiftUI
import WidgetKit

struct ContentView: View {

    @EnvironmentObject var shift: Shift
    
    @State private var timeRemaining = 3600
    @State private var showPrefs = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Button(action: {showPrefs.toggle()}){
                Image(systemName: "gearshape.fill")
            }
            .padding(.top, 15)
            .padding(.bottom)
            .padding(.trailing, 15)
            .frame(width: 350.0, alignment: .trailing)
            if(showPrefs == false){
                ClockIn()
                Lunch()
                ShiftLength()
                ClockOut()
                HStack{
                    Text("Time Remaining:")
                    Text("\(timeString(timeRemaining))")
                        .foregroundColor(.cyan)
                        .onChange(of: shift.remaining()) { _ in
                            timeRemaining = shift.timeRemaining
                        }
                }
                .padding(.top, 15)
                .font(.title2)
            } else {
                PreferencesView()
                Button(action: {showPrefs.toggle()}){
                    Text("Save")
                        .padding()
                }
                .padding(.top, 10)
            }
            #if os(macOS)
            QuitButton()
            #endif
        }
        .onAppear(perform: {shift.startTime = 28800})
        .frame(minWidth: 350, maxWidth: 450)
        .onReceive(timer) { time in
                timeRemaining -= 1

        }
    }
    
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
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
