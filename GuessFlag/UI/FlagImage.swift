//
//  FlagImage.swift
//  GuessFlag
//
//  Created by Vladislav Sosiuk on 27.10.2019.
//  Copyright © 2019 vlados. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
