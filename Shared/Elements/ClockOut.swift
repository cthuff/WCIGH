//
//  ClockOut.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

struct ClockOut: View {
    @EnvironmentObject var shift: Shift
    var body: some View {
        HStack{
            Text("Clock Out At:")
                .bold()
            Text(shift.clockOut(), format: .dateTime.minute().hour())
                .foregroundColor(.mint)
        }
        .font(.title2)
        .padding(.top, 25)
    }
}

struct ClockOut_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        ClockOut()
    }
}
