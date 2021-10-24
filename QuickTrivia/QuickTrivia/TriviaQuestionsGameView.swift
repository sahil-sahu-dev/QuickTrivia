//
//  ContentView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import SwiftUI



struct TriviaQuestionsGameView: View {
    
    @ObservedObject var triviaDocument: TriviaQuestionsGame
    
    @State var questionIndex: Int = 0
    
    
    var pinkColor:Color = Color(red: 255/255.0,green: 156/255.0, blue: 156/255.0)
    var greenColor: Color = Color(red: 168/255.0, green: 237/255.0, blue: 219/255.0)
    @State var hasTappedOption = false
    
    var body: some View {
        
        NavigationView{
            VStack{
        
                Text(questionIndex < triviaDocument.trivias.count ? triviaDocument.trivias[questionIndex].question : "").offset(y: -150)
                blackLine.offset(y:-50)
                answers
            }
            
        }
        
        .toolbar {
            ToolbarItem{
                nextQuestion
            }
        }
            
        
            
        
    }
    
    var question: some View {
        
            if(triviaDocument.trivias.count > questionIndex){
                return Text(triviaDocument.trivias[questionIndex].question)
                
            }
        
        return Text("")
    }
    
    var nextQuestion: some View {
        Button("Next Question") {
            questionIndex += 1
            hasTappedOption = false
        }.foregroundColor(.black)
    }
    
    var blackLine: some View {
        Rectangle()
            .stroke(lineWidth: 5)
            .frame(width:500, height: 1)
            .foregroundColor(.black)

    }
    
    var answers: some View
    {
        LazyVGrid(columns: [GridItem(.fixed(400))],spacing: 10){
            if(triviaDocument.trivias.count > questionIndex){
                ForEach(triviaDocument.trivias[questionIndex].answerOptions, id: \.self){answer in
                    ZStack{
                        withAnimation(){
                            option
                        }
                                .onTapGesture {
                                    hasTappedOption = true
                                    answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? HapticsManager.instance.notification(of: .success) : HapticsManager.instance.notification(of: .error)
                                }
                        .foregroundColor(hasTappedOption && answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? greenColor : pinkColor)
                            
                        Text(answer).foregroundColor(hasTappedOption && answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? .black : .white)
                        
                    }
                    .foregroundColor(.black)
                }
            }
            //option
        }
    }
    
    
    var option: some View {
        
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 350, height: 70)
           
        
    }
    
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuestionsGameView(triviaDocument: TriviaQuestionsGame())
            
    }
}
