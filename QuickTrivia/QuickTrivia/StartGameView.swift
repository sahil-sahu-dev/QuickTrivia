//
//  StartGameView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 22/10/21.
//

import SwiftUI

struct StartGameView: View {
    
    var yellowColor:Color = Color(red: 255/255.0,green: 235/255.0, blue: 161/255.0)
    var greenColor: Color = Color(red: 149/255.0, green: 218/255.0, blue: 193/255.0)
    
    var blackColor: Color = Color(red: 54/255.0, green: 54/255.0, blue: 54/255.0)
    
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                
                yellowColor
                title
                    .padding()
                    .offset(y:30)
                
                NavigationLink(destination: CategoriesChoiceView()
                                .navigationBarTitle("Categories")
                                
                ){
                    startButton
                        .foregroundColor(blackColor)
                        .padding()
                        .offset(y:50)
                    
                }
                
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)
            
        }.accentColor(.black)
    }
    
    
    var startButton: some View {
        
        Text("Start Game")
            .foregroundColor(.white)
            .padding()
            
        
        .background(
            RoundedRectangle(cornerRadius: 10 , style: .continuous)
                .frame(width: 200, height: 50, alignment: .center)
        )
        
    }
    
    var title: some View {

        Text("QuickTrivia 🧠")
            .foregroundColor(blackColor)
            .font(.largeTitle)
            .fontWeight(.bold)
            .offset(x: 5,y:-280)
    }
    
    
}


struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartGameView()
                .previewDevice("iPhone 12 Pro Max")
           
           
        }
    }
}
