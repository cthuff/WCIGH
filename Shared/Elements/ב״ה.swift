//
//  ב״ה.swift
//  Tempus
//
//  Created by Craig on 2/8/22.
//

import SwiftUI

struct ב״ה: View {
    var body: some View {
        HStack{
            Spacer()
            Text("ב״ה")
                .foregroundColor(.accentColor)
                .padding(.top, 10)
                .padding(.bottom)
                .padding(.trailing, 15)
                .frame(alignment: .trailing)
            
            }
        
    }
}

struct ב״הPreviews: PreviewProvider {
    static var previews: some View {
        ב״ה()
    }
}
