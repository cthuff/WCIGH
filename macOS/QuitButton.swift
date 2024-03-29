//
//  QuitButton.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/18/22.
//

import SwiftUI

struct QuitButton: View {
    var body: some View {
        Button(action: {
            NSApplication.shared.terminate(self)
        })
        {
            Text("Quit App")
            .font(.caption)
            .fontWeight(.semibold)
        }
        .padding(.vertical)
        .padding(.bottom)
        .frame(alignment: .trailing)
    }
}

struct QuitButton_Previews: PreviewProvider {
    static var previews: some View {
        QuitButton()
    }
}
