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
        }
    }
}

struct ClockIn_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        ClockIn().environmentObject(shift)
    }
}
