//
//  ClockIn.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

//Element to load the information informing the user when to ClockOut
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
                    //Sets the AppStorage variable when the start time changes so the widget can read the info
                    //iOS App will always default to 8am when launched, but the widgit will update
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
