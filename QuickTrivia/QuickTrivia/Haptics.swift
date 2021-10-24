//
//  Haptics.swift
//  QuickTrivia
//
//  Created by Sahil Sahu on 24/10/21.
//

import Foundation
import AVKit


class HapticsManager {
    static let instance = HapticsManager()
    
    
    func notification (of type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    
    func impact(of style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
        
    }
}
