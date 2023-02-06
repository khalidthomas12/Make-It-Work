//
//  MessageModel.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/6/23.
//

import Foundation
import SwiftUI

struct Message: Identifiable, Codable {
    
     var id: String
     var text: String
     var received: Bool
     var timestamp: Date
}


