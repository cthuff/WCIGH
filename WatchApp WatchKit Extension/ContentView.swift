//
//  ContentView.swift
//  WatchApp WatchKit Extension
//
//  Created by Craig on 1/26/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var shift: Shift
    @State private var timeRemaining: Float = 1.0
    @State private var fraction: Float = 1/10
    @State private var shiftTimer: Date = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            ProgressView(value: timeRemaining)
                .progressViewStyle(CustomCircularProgressViewStyle())
                .onReceive(timer) { time in
                    if timeRemaining > fraction {
                    timeRemaining -= fraction
                    }
                }
                .progressViewStyle(.circular)
                .padding(.top, 25 )
                .padding(.bottom, 15)
            Text(shiftTimer, style: .timer)
                .font(.title2)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
        }
        .onReceive(shift.$sharedShift){ _ in
            fraction = 1 / Float(shift.sharedShift)
            timeRemaining = fraction * Float(shift.endTime.distance(to: shift.timeString()))
            shiftTimer = shift.timeString()
        }
        
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
struct CustomCircularProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            ProgressView(value: configuration.fractionCompleted)
                .tint(.purple)
                .scaleEffect(x: 2.0, y: 2.0, anchor: .center)
                .frame(width: 75, height: 75, alignment: .center)
            if let fractionCompleted = configuration.fractionCompleted {
                Text(fractionCompleted < 1 ?
                        "\(Int((configuration.fractionCompleted ?? 0) * 100))%"
                        : "Done!"
                )
                .foregroundColor(fractionCompleted < 1 ? .primary : .green)
                .font(.title3)
            }
        }
    }
}
 
