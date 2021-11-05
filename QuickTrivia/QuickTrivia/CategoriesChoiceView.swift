//
//  CategoriesChoiceView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 02/11/21.
//

import SwiftUI

struct CategoriesChoiceView: View {
    
    @EnvironmentObject var triviaDocument: TriviaQuestionsGame
    
    var yellowColor:Color = Color(red: 255/255.0,green: 235/255.0, blue: 161/255.0)
    var blackColor: Color = Color(red: 54/255.0, green: 54/255.0, blue: 54/255.0)
    
    var categories = ["General Knowledge", "Geography", "History", "Sports", "Science & Nature"]
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 150, maximum: 200))]
    }
    
    var body: some View {
        
            ZStack{
                yellowColor
                    .edgesIgnoringSafeArea(.top)
                    .edgesIgnoringSafeArea(.bottom)
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(categories, id: \.self) { category in
                            
                            NavigationLink(destination: TriviaQuestionsGameView()){
                            
                                CardView(category: category)
                                .aspectRatio(9/10, contentMode: ContentMode.fill)
                                .padding()
                                .foregroundColor(blackColor)
                                
                            
                            }.simultaneousGesture(TapGesture().onEnded {
                                self.triviaDocument.loadNewCategory(for: category)
                            })
                        }
                    }
                }
            }
    }
}


struct CardView: View {
    
    var blackColor: Color = Color(red: 54/255.0, green: 54/255.0, blue: 54/255.0)
    var category: String
    
    var body: some View{
        GeometryReader{ geometry in
        RoundedRectangle(cornerRadius: 15)
                .overlay(Text(category)
                            .foregroundColor(.white)
                            .padding())
            
        }
        
    }

    
}


struct CategoriesChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesChoiceView()
    }
}
