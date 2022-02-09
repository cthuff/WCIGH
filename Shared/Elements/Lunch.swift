//
//  Lunch.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

struct Lunch: View {
    @EnvironmentObject var shift: Shift
    @State private var lunchPicker = 1
    @State private var showPicker = true
    
    //Loads the View that allows the user to input their lunch in a minute format or using 2 clocks for start and end of lunch
    //Shifts based on which selection is active in the picker view
    var body: some View {
        VStack{
            Picker(selection: $lunchPicker, label: Text("Lunch Options") .bold()) {
                Text("Minutes").tag(1)
                Text("Clock").tag(2)
            }
            .padding(.horizontal, 50)
            .padding(.bottom, 5)
            .pickerStyle(.segmented)
            .frame(maxWidth: 450)
            #if !os(macOS)
            .onChange(of: shift.lunchLength, perform: {_ in shift.sendToWatch()})
            #endif
            .onChange(of: lunchPicker){ _ in
                withAnimation(Animation.easeInOut(duration: 0.25)) {
                    switch lunchPicker {
                    case 1:
                        !showPicker ? showPicker.toggle() : nil
                    default:
                        showPicker ? showPicker.toggle() : nil
                    }
                }
            }
            if (showPicker){
                LunchMinutes()
            }
            else {
                LunchBlocks()
            }
        }
    }
}

struct Lunch_Previews: PreviewProvider {
    
    static let shift = Shift()
    static var previews: some View {
        Lunch().environmentObject(shift)
    }
}
