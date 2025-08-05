//
//  InputsView.swift
//  
//
//  Created by Fabrice Kouonang on 2025-06-14.
//

import SwiftUI

struct InputsView: View {
    @Binding var inputUser: String
    var placeholder: String = ""
    var imageName: String

    var body: some View {
        VStack{
            HStack (spacing: 15){
                Image(systemName: imageName)
                    .font(.system(size: 24))
                    .foregroundStyle(.green)
                    
                TextField(placeholder,text: $inputUser)
                    .autocapitalization(.none)
                    .foregroundStyle(.black)
                  
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
            .background(Color.white.opacity(0.9))
            
        }
    }
}

#Preview {
    InputsView(inputUser: .constant("test"), imageName: "person.circle")
}
