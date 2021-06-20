//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Prashuk Ajmera on 6/19/21.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isHumanTurn = true
    @Published var isGameBoardDisable = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMoves(for position: Int) {
        
        // Human move processing
        if isSquareOccupied(in: moves, forIndex: position) { return }
        
        moves[position] = Move(player: isHumanTurn ? .human : .computer, boardIndex: position)
        
        if winningCondition(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if drawCondition(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameBoardDisable = true
        
        // Computer move processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMove(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameBoardDisable = false
            
            if winningCondition(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                return
            }
            
            if drawCondition(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func determineComputerMove(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while (isSquareOccupied(in: moves, forIndex: movePosition)) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func winningCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPattern: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.player == player }
        let playerPosition = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPattern where pattern.isSubset(of: playerPosition) { return true }
        
        return false
    }
    
    func drawCondition(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}
