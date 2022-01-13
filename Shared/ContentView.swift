//
//  ContentView.swift
//  Shared
//
//  Created by Craig on 1/12/22.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var shift: Shift
    
    @State private var timeRemaining = 100
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
                Text(shift.remaining())
                    .foregroundColor(.orange)
            }
            .padding(.top, 25)
            .font(.title2)
            }
        .onReceive(timer) { time in
            if shift.timeRemaining > 0 {
                shift.timeRemaining -= 1
            }
        }
    }
    
//    func remaining() -> String {
//
//        let time = Calendar.current.dateComponents([.hour, .minute, .second], from: shift.endTime)
//        let now = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now)
//        let hours   = (time.hour ?? 0) - (now.hour ?? 0) //Int(time) / 3600
//        let minutes = (time.minute ?? 0) - (now.minute ?? 0) //Int(time) / 60 % 60
//        let seconds = (time.second ?? 0) - (now.second ?? 0) //Int(time) % 60
//
//        timeRemaining = hours * 3600 + minutes * 60 + seconds
////        return "\(timeRemaining)"
//        return String(format:"%02i:%02i:%02i", hours, minutes > 0 ? minutes : minutes + 60, seconds > 0 ? seconds : seconds + 60)
//    }
    
}


struct ContentView_Previews: PreviewProvider {
    
    static let shift = Shift()
    static var previews: some View {
        Group {
            ContentView().environmentObject(shift)
        }
    }
}
