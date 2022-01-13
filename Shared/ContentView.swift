//
//  ContentView.swift
//  Shared
//
//  Created by Craig on 1/12/22.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var shift: Shift
    
    @State private var timeRemaining = 3600
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            HStack{
                Text("Clocked in:")
                    .font(.title3)
                DatePicker("", selection: $shift.start, displayedComponents: [.hourAndMinute])
                    .frame(width: 90)
            }
            HStack{
                Text("How long was lunch?")
                TextField("time", text: $shift.lunchLength)
                    .frame(width: 40)
                    .foregroundColor(.green)
                    .padding(.leading)
                    .keyboardType(.numberPad)
                    
                Text("minutes")
            }
            .font(.title3)
            HStack{
                Text("How long is your shift?")
                TextField("time", text: $shift.workLength)
                    .frame(width: 40)
                    .foregroundColor(.green)
                    .padding(.leading)
                    .keyboardType(.numberPad)
                Text("hours")
            }
            .font(.title3)
            
            HStack{
                Text("Clock Out At:")
                    .bold()
                Text(shift.clockOut(), format: .dateTime.minute().hour())
                    .foregroundColor(.mint)
                    
            }
            .font(.title2)
            .padding(.top, 25)
            HStack{
                Text("Time Remaining:")
                Text("\(timeString(timeRemaining))")
                    .foregroundColor(.orange)
                    .onChange(of: shift.remaining()) { _ in
                        timeRemaining = shift.timeRemaining}
            }
            .padding(.top, 25)
            .font(.title2)
            }
        .onReceive(timer) { time in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
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
