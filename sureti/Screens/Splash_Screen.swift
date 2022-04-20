    //
    //  Splash_Screen.swift
    //  sureti
    //
    //  Created by Devolper.Scorpio on 20/04/2022.
    //

import SwiftUI

struct Splash_Screen: View {
    
    var body: some View {
        
        VStack{
            Image("Logo")
        }.edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .background(Overlay())
    }
}

struct Splash_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Splash_Screen()
    }
}

