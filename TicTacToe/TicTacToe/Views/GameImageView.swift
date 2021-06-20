//
//  SwiftUIView.swift
//  TicTacToe
//
//  Created by Prashuk Ajmera on 6/19/21.
//

import SwiftUI

struct GameImageView: View {
    
    var systemImage: String?
    
    var body: some View {
        if let image = systemImage {
            Image(systemName: image)
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
        }
    }
}
