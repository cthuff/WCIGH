//
//  GoHomeButton.swift
//  Tempus
//
//  Created by Craig on 3/10/22.
//

import SwiftUI

struct GoHomeButton: View {
    @EnvironmentObject var shift: Shift
    @State var goHome = false
    @State var stayHere = false
    
    var body: some View {
        VStack{
            Button(action: {
                if (shift.timeRemaining <= 0 ) {
                    goHome.toggle()
                } else {
                    stayHere.toggle()
                }
            }) {
                Text("Can I Go Home?")
                    .foregroundColor(Color("TextColor"))
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary)
            .alert("Get out of here!" , isPresented: $goHome) {
                Button("Dismiss", role: .cancel) { }
            }
            .alert("Sorry, you're stuck here", isPresented: $stayHere) {
                Button("Dismiss", role: .cancel) { }
            }
            
        }
    }
}

struct GoHomeButton_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        GoHomeButton().environmentObject(shift)
//            .preferredColorScheme(.dark)
    }
}
