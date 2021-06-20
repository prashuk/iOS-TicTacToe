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
    @Published var isGameBoardDisable = false
    @Published var alertItem: AlertItem?
    
    @Published var humanWon = 0
    @Published var computerWon = 0
    
    func processPlayerMoves(for position: Int) {
        
        // Human move processing
        if isSquareOccupied(in: moves, forIndex: position) { return }
        
        moves[position] = Move(player: .human, boardIndex: position)
        
        if winningCondition(for: .human, in: moves) {
            humanWon = humanWon + 1
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
                computerWon = computerWon + 1
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
        
        // If AI can win, then win
        let winPattern: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let computerMoves = moves.compactMap{ $0 }.filter{ $0.player == .computer }
        let computerPosition = Set(computerMoves.map{ $0.boardIndex })
        
        for pattern in winPattern {
            let winPosition = pattern.subtracting(computerPosition)
            
            if winPosition.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first!}
            }
        }
        
        // If AI can't win, then block
        let humanMoves = moves.compactMap{ $0 }.filter{ $0.player == .human }
        let humanPosition = Set(humanMoves.map{ $0.boardIndex })
        
        for pattern in winPattern {
            let winPosition = pattern.subtracting(humanPosition)
            
            if winPosition.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first!}
            }
        }
        
        // If AI can't block, then take the middle square
        let center = 4
        
        if !isSquareOccupied(in: moves, forIndex: center) {
            return center
        }
        
        // If AI can't take middle square, take random available square
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
