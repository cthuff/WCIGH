//
//  ContentView.swift
//  Shared
//
//  Created by Craig on 1/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var calc: Calculator
    @State var startTime = Calendar.current.date(from: DateComponents(hour: 8))!
    @State var lunchLength = "30"
    @State var endTime = Date()
    var body: some View {
        VStack{
            DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
                .padding(.trailing, UIScreen.main.bounds.width / 2 - 45)
            TextField("", text: $lunchLength)
                .frame(width: 40.0)
                
        }
            
//            }
    }
    
    func calculate() -> Date {
        
        var comp = DateComponents()
        comp.hour = 8
        comp.minute = 0
        
        var comp2 = DateComponents()
        comp2.hour = 9
        comp2.minute = 0
        
        
        let date = Calendar.current.date(from: comp) ?? Date.now
        let endDate = Calendar.current.date(from: comp2) ?? Date.now
        print(endDate.timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate)
        
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: date, to: endDate)
        
        return diffComponents.date ?? Date.now
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var calc = Calculator()
    static var previews: some View {
        Group {
            ContentView().environmentObject(calc).previewInterfaceOrientation(.portrait)
        }
    }
}
