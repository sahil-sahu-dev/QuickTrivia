//
//  ContentView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 21/10/21.
//

import SwiftUI



struct TriviaQuestionsGameView: View {
    
    @ObservedObject var triviaDocument: TriviaQuestionsGame
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var questionIndex: Int = 0
    @State var hasTappedOption = false
    @State var tappedAnswer: String = ""
    @State var wrongAnswer: Int = 0
    
    var pinkColor:Color = Color(red: 255/255.0,green: 156/255.0, blue: 156/255.0)
    var yellowColor:Color = Color(red: 255/255.0,green: 235/255.0, blue: 161/255.0)
    var greenColor: Color = Color(red: 149/255.0, green: 218/255.0, blue: 193/255.0)
    var blackColor: Color = Color(red: 54/255.0, green: 54/255.0, blue: 54/255.0)
    
    
    var body: some View {
        
        ZStack{
            yellowColor
            VStack{
                
            questionView
                answers
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: home, trailing: toggleQuestion)
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    
    var home : some View {
        Button(action: {
            self.mode.wrappedValue.dismiss()
        }) {
            Image(systemName: "house").foregroundColor(blackColor)
        }
        
    }
    
    
    var questionView: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: 320, maxHeight: 100)
                .foregroundColor(yellowColor)

            question
                .foregroundColor(blackColor)
                .frame(maxWidth: 320)
            
        }
    }
    
    var question: some View {
        
        if(triviaDocument.trivias.count > questionIndex){
            return Text(triviaDocument.trivias[questionIndex].question)
        }
        
        return Text("")
    }
    
    
    var toggleQuestion: some View {
        HStack {
            
            Button("Previous") {
                questionIndex = questionIndex > 0 ? questionIndex-1 : questionIndex
                hasTappedOption = false
                tappedAnswer = ""
                wrongAnswer = 0
                
            }
            
            Button("Next") {
                questionIndex += 1
                hasTappedOption = false
                tappedAnswer = ""
                wrongAnswer = 0
            }
            
        }
        .foregroundColor(blackColor)
    }
    
    var blackLine: some View {
        Rectangle()
            .stroke(lineWidth: 5)
            .frame(width:500, height: 1)
            .foregroundColor(.black)

    }
    
    var answers: some View {
        
        LazyVGrid(columns: [GridItem(.fixed(400))],spacing: 10){
            if(triviaDocument.trivias.count > questionIndex){
                ForEach(triviaDocument.trivias[questionIndex].answerOptions, id: \.self){answer in
                    ZStack{
                        
                        option
                        .onTapGesture {
                            //haptic feedback and changing state variable for the tapped options
                            tappedAnswer = hasTappedOption ? tappedAnswer : answer
                            hasTappedOption = true
                            withAnimation(.default) {
                                wrongAnswer = !answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer)
                                    && answer.elementsEqual(tappedAnswer) ? wrongAnswer+1 : wrongAnswer
                                
                            }
                            
                            
                            answer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) ? HapticsManager.instance.notification(of: .success) : HapticsManager.instance.notification(of: .error)
                            
                        }
                        
                        .foregroundColor(!hasTappedOption ?
                                            blackColor : tappedAnswer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer) && tappedAnswer.elementsEqual(answer) ?
                                            greenColor :  tappedAnswer.elementsEqual(answer)
                                            ? pinkColor : blackColor)
                        
                        
                        .modifier(tappedAnswer.elementsEqual(answer) && !tappedAnswer.elementsEqual(triviaDocument.trivias[questionIndex].correct_answer)
                                    ? Shake(animatableData: CGFloat(wrongAnswer)) : Shake(animatableData: 0))
                        
                        Text(answer)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 320)
                        
                    }
                    .foregroundColor(.black)
                }
            }
            
        }
    }
    
    
    var option: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(maxWidth: 320, minHeight: 70)
    }
    
    
        
    
}


struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaQuestionsGameView(triviaDocument: TriviaQuestionsGame())
            
    }
}
