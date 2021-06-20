//
//  ContentView.swift
//  TicTacToe
//
//  Created by Prashuk Ajmera on 6/18/21.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text("Tic-Tac-Toe")
                    .foregroundColor(.green)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                Spacer()
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            GameImageView(systemImage: viewModel.moves[i]?.indicator)
                        }
                        .onTapGesture {
                            viewModel.processPlayerMoves(for: i)
                        }
                    }
                }
                Spacer()
                HStack {
                    Text("You: \(viewModel.humanWon)")
                    Spacer()
                    Text("Computer: \(viewModel.computerWon)")
                }
                .padding()
                .foregroundColor(.green)
                .font(.system(size: 21, weight: .semibold, design: .monospaced))
            }
            .disabled(viewModel.isGameBoardDisable)
            .padding()
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.button,
                                              action: { viewModel.resetGame() }))
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
