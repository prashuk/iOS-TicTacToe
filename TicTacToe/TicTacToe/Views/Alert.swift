//
//  Alert.swift
//  TicTacToe
//
//  Created by Prashuk Ajmera on 6/19/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let button: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win"),
                          message: Text("You are so smart. You beat your own AI."),
                          button: Text("Hell Yeah"))
    
    static let computerWin = AlertItem(title: Text("You Lost"),
                          message: Text("You programmed a super AI."),
                          button: Text("Rematch"))
    
    static let draw = AlertItem(title: Text("Draw"),
                          message: Text("What a battle of wits we have here..."),
                          button: Text("Try Again"))
}
