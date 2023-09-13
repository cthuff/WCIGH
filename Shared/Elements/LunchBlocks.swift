//
//  LunchBlocks.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

//Element that allows the user to choose their lunch start and end time using two clocks
struct LunchBlocks: View {
    @EnvironmentObject var shift: Shift
    
    @State var lunchStart = Calendar.current.date(from: DateComponents(hour: 12))!
    @State var lunchEnd = Calendar.current.date(from: DateComponents(hour: 12, minute: 30))!
    
    var body: some View {
        VStack{
            HStack{
                Text("Lunch Start:")
                    .font(.title3)
                DatePicker("", selection: $lunchStart, displayedComponents: [.hourAndMinute])
                    .frame(width: 90)
            }
            HStack{
                Text("Lunch End:")
                    .font(.title3)
                DatePicker("", selection: $lunchEnd, displayedComponents: [.hourAndMinute])
                    .frame(width: 90)
            }
            .onAppear() {
                lunchEnd = lunchStart.advanced(by: shift.lunchInMinutes)
            }
        //Watches both lunch values in case the user doesn't edit one or the other
        }.onChange(of: lunchEnd, {
            shift.lunchLength = "\(Int(lunchStart.distance(to: lunchEnd) / 60))"
        })
        .onChange(of: lunchStart, {
            shift.lunchLength = "\(Int(lunchStart.distance(to: lunchEnd) / 60))"
            lunchEnd = lunchStart.advanced(by: shift.lunchInMinutes)
        })
    }
}

struct LunchBlocks_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        LunchBlocks().environmentObject(shift)
    }
}
