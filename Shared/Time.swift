//
//  Time.swift
//  Tempus
//
//  Created by Craig on 1/12/22.
//

import Foundation

struct Time {
    
    var hours = 8
    var minutes = 0
    
}

final class Calculator: ObservableObject{
    
    
    var lunchLength: String = String()
    var decimal: Bool = Bool()
    @Published var timeRemaining : Time = Time()
    
    func calculate(){
        
    }
    
    
}
