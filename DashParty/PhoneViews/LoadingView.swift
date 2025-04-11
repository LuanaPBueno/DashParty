////
////  loadingView.swift
////  DashParty
////
////  Created by Maria Eduarda Mariano on 07/04/25.
////
//
//import SwiftUI
//import CoreMotion
//
//enum Screen: Hashable {
//    case home
//}
//
//struct LoadingView: View {
//    @State private var progress: CGFloat = 0.0
//    @State private var isLoadingComplete = false
//    
//    var body: some View {
//    
//            VStack(spacing: 40) {
//                Circle()
//                    .fill(Color(.lightGray))
//                    .frame(width: 200, height: 200)
//                
//                ZStack(alignment: .leading) {
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(Color.white)
//                        .frame(height: 30)
//                    
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(Color(.green))
//                        .frame(width: progress * 300, height: 30)
//                        .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 2)
//                }
//                .frame(width: 300, height: 30)
//                .padding(.top, 20)
//            }
//            
//            .onAppear {
//                // Simulando carregamento com animação
//                Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
//                    if progress < 1.0 {
//                        progress += 0.01
//                    } else {
//                        timer.invalidate()
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                            isLoadingComplete = true
//                        }
//                    }
//                }
//            }
//            .navigationDestination(for: Screen.self) { screen in
//                switch screen {
//                case .home:
//                    ContentView()
//                    
//                }
//            }
//        }
//    
//}
//
//#Preview{
//    LoadingView( )
//}
