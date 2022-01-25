//
//  PreferencesView.swift
//  Tempus
//
//  Created by Craig on 1/18/22.
//

import SwiftUI

//Allows the users to set their default lunch and shift length and loads a separate view from Content View
struct PreferencesView: View {
    @EnvironmentObject var shift: Shift
    var body: some View {
        VStack{
            HStack{
                Text("How long is your usual lunch?")
                TextField("0", text: $shift.lunchLength)
                    .frame(width: 40)
                    .padding(.leading)
                Text("minutes")
            }
            HStack{
                Text("How long is your usual shift?")
                TextField("0", text: $shift.workLength)
                    .frame(width: 40)
                    .padding(.leading)
                //Loads the "Done" button in the toolbar for this view in iOS only
                #if os(iOS)
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
        }
        .padding(.horizontal, 5)
        #if os(iOS)
        .keyboardType(.numberPad)
        #endif
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        PreferencesView().environmentObject(shift)
    }
}
