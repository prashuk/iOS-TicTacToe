//
//  GameSquareView.swift
//  TicTacToe
//
//  Created by Prashuk Ajmera on 6/19/21.
//

import SwiftUI

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.green)
            .opacity(0.5)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}
