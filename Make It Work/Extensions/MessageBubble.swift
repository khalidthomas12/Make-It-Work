//
//  MessageBubble.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/6/23.
//

import SwiftUI

struct MessageBubble: View {
    
    @State var message: Message
    @State private var showTime = false
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing)
        {
            HStack{
                
                Text(message.text)
                    .padding()
                    .foregroundColor(message.received ? .black: .white)
                    .background(message.received ? Color(.lightGray): .blue)
                    .cornerRadius(10)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading: .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute())) ")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.received ? .leading: .trailing, 25)
                
            }
        }
        .frame(maxWidth: 300, alignment: message.received ? .leading: .trailing)
            .padding(message.received ? .leading : .trailing)
            .padding(.horizontal,10)
    }
    
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "adfadf", text: "This is a message for you", received: false, timestamp: Date()))
    }
}
