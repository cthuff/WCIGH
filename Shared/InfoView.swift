//
//  InfoView.swift
//  Tempus
//
//  Created by Craig on 2/7/22.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Spacer()
            ב״ה()
            }
            Text("Designed by Craig Huff and Samantha Rosas")
                .padding(.bottom, 5)
                .lineLimit(nil)
            Link("Personal Website", destination: URL(string: "https://craighuff.com")!)
            Text("A special thank you to Paul Hudson for the great SwiftUI Tutorials")
                .padding(5)
                .lineLimit(nil)
            Link("Learn SwiftUI", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!)
                .padding(.bottom, 5)
            
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
