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
            TextField("8", text: $shift.workLength)
                .frame(width: 40)
                .padding(.leading)
                #if os(iOS)
                .keyboardType(.numberPad)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            hideKeyboard()
                        }
                    }
                }
                #endif
            
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
