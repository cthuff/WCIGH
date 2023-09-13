//
//  ClockOut.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

//Element to allow the user to adjust the length of their normal shift length
struct ShiftLength: View {
    @EnvironmentObject var shift: Shift
    var body: some View {
        HStack{
            Text("Shift Length: ")
            TextField("8", text: $shift.workLength)
                .frame(width: 40)
                .padding(.leading)
                #if os(iOS)
                .onChange(of: shift.workLength, { shift.sendToWatch()} )
                .keyboardType(.numberPad)
                .toolbar {
                    //This will load the toolbar for every keyboard in the view when this is present. If there is no ShiftLength Object in the view, then the toolbar will need to be added 
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
