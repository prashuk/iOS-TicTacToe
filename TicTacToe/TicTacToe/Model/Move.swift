//
//  Move.swift
//  TicTacToe
//
//  Created by Prashuk Ajmera on 6/19/21.
//

import Foundation

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
