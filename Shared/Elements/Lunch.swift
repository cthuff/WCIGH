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
