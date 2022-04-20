//
//  Custom_Button.swift
//  sureti
//
//  Created by Devolper.Scorpio on 20/04/2022.
//

import SwiftUI

struct Custom_Button: View {
    var text : String = ""
    var body: some View {
        HStack{
            Text(text)
                .foregroundColor(Color("Primary_Color"))
                .font(.custom("Product Sans Regular", size: 20))
        }.padding()
         .frame(width : 172 ,height: 40 )
         .background(Color("Button_Color"))
         .cornerRadius(30.0)
         .shadow(color: Color.black.opacity(0.2), radius: 15.0)
    }
}

struct Custom_Button_Previews: PreviewProvider {
    static var previews: some View {
        Custom_Button()
    }
}
