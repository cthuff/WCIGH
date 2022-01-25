//
//  ClockIn.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

struct ClockIn: View {
    
    @EnvironmentObject var shift: Shift
    
    var body: some View {
        HStack{
            Text("Clocked in at:")
                .font(.title3)
            DatePicker("", selection: $shift.start, displayedComponents: [.hourAndMinute])
                .frame(width: 90)
                .onChange(of: shift.start) {_ in
                    let tempStart = Calendar.current.dateComponents([.hour, .minute], from: shift.start)
                    shift.startTime = ((tempStart.hour ?? 8) * 60 * 60) + ((tempStart.minute ?? 0 ) * 60)
                }
        }
    }
}

struct ClockIn_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        ClockIn().environmentObject(shift)
    }
}
