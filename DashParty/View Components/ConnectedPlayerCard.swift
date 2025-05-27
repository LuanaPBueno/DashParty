//
//  ConnectedPlayerCard.swift
//  DashParty
//
//  Created by Fernanda Auler on 15/04/25.
//

import SwiftUI

struct ConnectedPlayerCard: View {
    var playerName: String
    var sizePadding: Int
    var body: some View {
        GeometryReader { geometry in
            
            let fontSize = geometry.size.width * 0.07 < 20 ? 20 : geometry.size.width * 0.09

            ZStack {

                if MPCSessionManager.shared.host{
                    if let playerCharacter = GameInformation.instance.allPlayers.first(where: { $0.name == playerName }),
                       let imageName = playerCharacter.userClan?.alternateImage {
                        VStack {
                            imageName
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width)
                            Text(playerName)
                                .font(.custom("TorukSC-Regular", size: fontSize))
                                .foregroundColor(Color(.white))
                                .padding(.bottom, CGFloat(sizePadding))
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        
                    } else{
                        Image("phone")
                        
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Text(playerName)
                                        .font(.custom("TorukSC-Regular", size: fontSize))
                                        .foregroundColor(Color(red: 126/255, green: 97/255, blue: 46/255))
                                        .padding(.bottom, CGFloat(sizePadding))
                                        .minimumScaleFactor(0.5)
                                        .lineLimit(1)
                                    
                                    
                                }
                                    .padding(.vertical, geometry.size.height * 0.05)
                            )
                    }
                }
                else{
                    if let playerCharacter = GameInformation.instance.receivedPlayers.first(where: { $0.name == playerName }),
                       let imageName = playerCharacter.userClan?.alternateImage {
                        VStack {
                            imageName
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width)
                                .overlay(
                                    VStack {
                                        Spacer()
                                        Text(playerName)
                                            .font(.custom("TorukSC-Regular", size: fontSize))
                                            .foregroundColor(Color(red: 126/255, green: 97/255, blue: 46/255))
                                            .padding(.bottom, CGFloat(sizePadding))
                                            .minimumScaleFactor(0.5)
                                            .lineLimit(1)
                                    }
                                        .padding(.vertical, geometry.size.height * 0.05)
                                )
                        }
                        
                    } else{
                        Image("phone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Text(playerName)
                                        .font(.custom("TorukSC-Regular", size: fontSize))
                                        .foregroundColor(Color(red: 126/255, green: 97/255, blue: 46/255))
                                        .minimumScaleFactor(0.5)
                                        .lineLimit(1)
                                    
                                    
                                }
                                    .padding(.vertical, geometry.size.height * 0.2)
                            )
                    }
                }
             }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}



#Preview {
    ConnectedPlayerCard(playerName: "Player 1", sizePadding: 0)
}
