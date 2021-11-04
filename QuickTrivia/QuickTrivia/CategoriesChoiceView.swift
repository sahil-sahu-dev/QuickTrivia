//
//  CategoriesChoiceView.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 02/11/21.
//

import SwiftUI

struct CategoriesChoiceView: View {
    
    //@EnvironmentObject var triviaDocument: TriviaQuestionsGame

    var body: some View {
        DTCard(color: .red)
        
    }
}

struct DTCard: View {
    var color: Color
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack(spacing: 20) {
                Image(systemName: "globe")
                if #available(iOS 15.0, *) {
                    Text("DevTechie")
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                } else {
                    // Fallback on earlier versions
                }
                if #available(iOS 15.0, *) {
                    Text("DevTechie")
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 15.0, *) {
                    Text("iOS Video Courses")
                        .foregroundStyle(.secondary)
                } else {
                    // Fallback on earlier versions
                }
                
                if #available(iOS 15.0, *) {
                    Text("SwiftUI  ̣ Swift")
                        .foregroundStyle(.tertiary)
                } else {
                    // Fallback on earlier versions
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.quaternary))
            .foregroundStyle(color)
            .animation(.easeInOut, value: color)
        } else {
            // Fallback on earlier versions
        }
    }
    
}

struct CategoriesChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesChoiceView()
    }
}
