//
//  SecretButton.swift
//  Tempus App
//
//  Created by Craig Huff on 8/27/24.
//

import SwiftUI
import UserNotifications

struct SecretButton: View {
    @EnvironmentObject var shift: Shift
    @State var secretPress = false
    
    
    var body: some View {
        VStack{
            Button(action: {
                secretPress.toggle()
            }
            ) {
                Text("DO NOT PRESS!")
            }
            .buttonStyle(.borderedProminent)
            .alert("You didn't listen 🥺" , isPresented: $secretPress) {
                Button("Dismiss", role: .cancel) {
                }
            }
            .badge(1)
            .padding()
            
        }
    }
}

struct SecretButton_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        GoHomeButton().environmentObject(shift)
//            .preferredColorScheme(.dark)
    }
}

