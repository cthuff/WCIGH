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
            Text("Info")
                .font(.title)
            Text("A special thank you to Paul Hudson for the great SwiftUI Tutorials")
                .padding(.vertical, 5)
            Link("Learn SwiftUI", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
