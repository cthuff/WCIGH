//
//  ClockOut.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

struct ShiftLength: View {
    
    @EnvironmentObject var shift: Shift
    var body: some View {
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
    }
}

struct ShiftLength_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        ShiftLength().environmentObject(shift)
    }
}
