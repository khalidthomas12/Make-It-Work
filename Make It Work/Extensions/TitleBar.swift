//
//  TitleBar.swift
//  Make It Work
//
//  Created by Khalid Thomas on 2/6/23.
//

import SwiftUI

struct TitleBar: View {
    
    @State var name: String = ""
    @State var email: String = ""
    
    var body: some View {
        
        
        
        HStack(spacing: 20){
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading){
                Text(name)
                    .font(.title).bold()
                    .foregroundColor(.white)
                Text(email)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "phone.down.circle.fill")
                .foregroundColor(.green)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
                .padding(10)
        }
        .padding()
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar()
            .background(Color(.blue))
    }
}
