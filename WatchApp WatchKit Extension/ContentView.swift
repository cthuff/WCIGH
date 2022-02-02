//
//  ContentView.swift
//  WatchApp WatchKit Extension
//
//  Created by Craig on 1/26/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var shift: Shift
    @State private var timeRemaining = 1.0
    @State private var fraction: Double = 1/10
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Text("\(shift.sharedShift)")
            ProgressView(value: timeRemaining)
                .progressViewStyle(CircularProgressViewStyle(tint: .purple  ))
                .scaleEffect(x: 1.5, y: 1.5, anchor: .center)
                .frame(width: 70, height: 70, alignment: .center)
                .onReceive(timer) { time in
                    if timeRemaining > fraction / 2 {
                    timeRemaining -= fraction
                    }
                }
                .progressViewStyle(.circular)
                .padding()
            Text(shift.timeString(), style: .timer)
                .font(.title2)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
        }
        .onReceive(shift.$sharedShift){ _ in
            fraction = 1 / Double(shift.sharedShift)
            print("lunch length: \(shift.lunchLength)")
            timeRemaining = fraction * shift.endTime.distance(to: shift.timeString())
            
        }
        .onAppear(perform: {
            let totalTime = Double(shift.sharedShift) //((Double(shift.workLength) ?? 8) * 3600 + (Double(shift.lunchLength) ?? 30)  * 60)
            fraction = 1 / totalTime
            timeRemaining = fraction * shift.endTime.distance(to: shift.timeString())
        })
    }

}

struct ComplicationContentView: View {
    var body: some View{
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        ContentView().environmentObject(shift)
    }
}


