//
//  Overlay.swift
//  sureti
//
//  Created by Devolper.Scorpio on 20/04/2022.
//

import SwiftUI

struct Overlay: View {
    
    @State var animate : Bool = false

    var body: some View {
        VStack{
            HStack{
                Image("Splash  top")
                    .overlay(
                        VStack{
                            Image("Rectangle")
                                .scaledToFit()
                                .offset(x: -32 , y: animate ? -80 : 190)
                                .animation(.default)
                        }
                    )
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Image("Splash  bottom")
                    .overlay(
                        VStack{
                            Image("Rectangle")
                                .scaledToFit()
                                .offset(x: 25 , y: animate ? 70 : -220)
                                .animation(.default)
                        }
                    )
            }
        }.background(Color("Primary_Color"))
            .edgesIgnoringSafeArea(.all)
            .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    self.animate = true
                }
            }
        }
    }
}

struct Overlay_Previews: PreviewProvider {
    static var previews: some View {
        Overlay()
    }
}
