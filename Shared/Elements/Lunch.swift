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
                Text("Clock").tag(1)
                Text("Minutes").tag(2)
            }
            .padding(.horizontal)
            .pickerStyle(.segmented)
            #if !os(macOS)
            .frame(maxWidth: UIScreen.main.bounds.size.width / 1.25)
            .onChange(of: shift.lunchLength, { shift.sendToWatch()})
            #endif
            .onChange(of: lunchPicker, {
                withAnimation(Animation.easeInOut(duration: 0.25)) {
                    showPicker.toggle()
                }
            })
            if (showPicker){
                LunchBlocks()
            }
            else {
                LunchMinutes()
            }
        }
    }
}

struct Lunch_Previews: PreviewProvider {
    
    static let shift = Shift()
    static var previews: some View {
        Group {
            Lunch().environmentObject(shift)
        }
    }
}
