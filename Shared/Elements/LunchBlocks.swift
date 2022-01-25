//
//  LunchBlocks.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

struct LunchBlocks: View {
    @EnvironmentObject var shift: Shift
    
    @State var lunchStart = Calendar.current.date(from: DateComponents(hour: 12))!
    @State var lunchEnd = Calendar.current.date(from: DateComponents(hour: 12, minute: 30))!
    
    var body: some View {
        VStack{
            HStack{
                Text("Started lunch at:")
                    .font(.title3)
                DatePicker("", selection: $lunchStart, displayedComponents: [.hourAndMinute])
                    .frame(width: 90)
            }
            HStack{
                Text("Ended lunch at:")
                    .font(.title3)
                DatePicker("", selection: $lunchEnd, displayedComponents: [.hourAndMinute])
                    .frame(width: 90)
            }
        }.onChange(of: lunchEnd) { _ in
            shift.lunchLength = "\(Int(lunchStart.distance(to: lunchEnd) / 60))"
        }
        .onChange(of: lunchStart) { _ in
            shift.lunchLength = "\(Int(lunchStart.distance(to: lunchEnd) / 60))"
        }
    }
}

struct LunchBlocks_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        LunchBlocks().environmentObject(shift)
    }
}
