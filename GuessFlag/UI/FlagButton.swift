//
//  FlagButton.swift
//  GuessFlag
//
//  Created by Vladislav Sosiuk on 27.10.2019.
//  Copyright © 2019 vlados. All rights reserved.
//

import SwiftUI

struct FlagButton: View {
    
    let imageName: String
    let animation: FlagButtonAnimation
    let willAnimate: () -> Void
    let didAnimate: () -> Void
    
    @State private var rotationAngle: Double  = 0
    @State private var attempts = 1
    
    var body: some View {
        Button(action:buttonTapped) {
            FlagImage(imageName: imageName)
        }
        .modifier(Shake(animatableData: CGFloat(attempts)))
        .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
    }
    
    private func buttonTapped() {
        self.willAnimate()
        switch self.animation {
        case .spin:
            withAnimation(.easeInOut(duration: self.animation.duration)) {
                self.rotationAngle += 360
            }
        case .shake:
            withAnimation(.easeInOut(duration: self.animation.duration)) {
                self.attempts += 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.animation.duration) {
            self.didAnimate()
        }
    }
}

extension FlagButton {
    enum FlagButtonAnimation {
        case spin
        case shake
        
        var duration: Double {
            switch self {
            case .spin:
                return 0.3
            case .shake:
                return 0.3
            }
        }
    }
}
