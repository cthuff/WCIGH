//
//  PreferencesView.swift
//  Tempus
//
//  Created by Craig on 1/18/22.
//

import SwiftUI

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
