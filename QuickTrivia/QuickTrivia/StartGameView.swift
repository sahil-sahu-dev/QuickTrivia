//
//  StartGameView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 22/10/21.
//

import SwiftUI

struct StartGameView: View {
    
    var pinkColor:UIColor = UIColor(red: 255/255.0,green: 156/255.0, blue: 156/255.0, alpha: 1)
    var greenColor: UIColor = UIColor(red: 168/255.0, green: 237/255.0, blue: 219/255.0, alpha: 1)
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color(.black)
                VStack{
                    greenRectangle
                    pinkRectangle
                }
                title.padding()
                
                NavigationLink(destination: TriviaQuestionsGameView(triviaDocument: TriviaQuestionsGame())){
                    startButton
                        .foregroundColor(.black)
                        .padding()
                    
                }
                
            }
            .ignoresSafeArea(.all)
            
        }
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
            .foregroundColor(.black)
            .font(.largeTitle)
            .fontWeight(.bold)
            .offset(x: 5,y:-280)
    }
    
    var pinkRectangle: some View {
        Rectangle().foregroundColor(Color(pinkColor))
    }
    
    var greenRectangle: some View {
        Rectangle().foregroundColor(Color(greenColor))
    }
}

struct testView: View {
    var body: some View{
        Text("Hello")
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
