//
//  LunchMinutes.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

//Element that allows the user to input their lunch length as text in minutes
struct LunchMinutes: View {
    @EnvironmentObject var shift: Shift
    var body: some View {
        HStack{
            Text("Lunch Length: ")
            TextField("30", text: $shift.lunchLength)
                .frame(width: 40)
                .padding(.leading)
                #if os(iOS)
                .keyboardType(.numberPad)
                #endif
            Text("minutes")
        }
        .font(.title3)
    }
}

struct LunchMinutes_Previews: PreviewProvider {
    static var shift = Shift()
    static var previews: some View {
        LunchMinutes().environmentObject(shift)
    }
}
