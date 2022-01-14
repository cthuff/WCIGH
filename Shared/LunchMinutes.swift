//
//  LunchMinutes.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

struct LunchMinutes: View {
    @EnvironmentObject var shift: Shift
    var body: some View {
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
    }
}

struct LunchMinutes_Previews: PreviewProvider {
    static var shift = Shift()
    static var previews: some View {
        LunchMinutes().environmentObject(shift)
    }
}
