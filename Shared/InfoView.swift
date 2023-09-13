//
//  InfoView.swift
//  Tempus
//
//  Created by Craig on 2/7/22.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
            ב״ה()
            }
            Text("Designed by Craig Huff and Samantha Rosas")
                .padding()
                .lineLimit(nil)
            Link("Personal Website", destination: URL(string: "https://craighuff.com")!)
                .foregroundColor(.blue)
            Text("A special thank you to Paul Hudson for the SwiftUI Tutorials that this app was built upon")
                .lineLimit(nil)
                .padding()
            Link("Learn SwiftUI", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!)
                .foregroundColor(.blue)
        }
        .lineLimit(nil)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
