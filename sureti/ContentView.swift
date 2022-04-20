//
//  ContentView.swift
//  sureti
//
//  Created by Devolper.Scorpio on 20/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State var isActive:Bool = false
    var body: some View {
       
        VStack{
            if self.isActive{
               SignIn_Screen()
            }else{
               Splash_Screen()
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
