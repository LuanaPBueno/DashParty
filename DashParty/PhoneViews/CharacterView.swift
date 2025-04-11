//
//  CharacterView.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 23/03/25.
//

//import SwiftUI
//import CoreMotion
//
//enum Clan: String, CaseIterable, Identifiable {
//    case bunny, monkey, feline, frog
//    
//    var id: String { self.rawValue }
//
//        var images: Image {
//            switch self {
//            case .bunny: return Image("clanBunny")
//            case .monkey: return Image("clanMonkey")
//            case .feline: return Image("clanFeline")
//            case .frog: return Image("clanFrog")
//            }
//        }
//    }
//   
//
//struct CharacterView: View {
//    var multipeerSession : MPCSession!
//    
//    //    var multipeerSession : MPCSession!
//    @State var navigate : Bool = false
//    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
//    @State private var isActive = false
//    @AppStorage("selectedClan") private var selectedClan: String?
//    @State private var tempSelection: Clan?
//    @State private var navigateToNext = false
//
//    
//    //    var users: [User]
//    //    var user : User
//    //    var matchManager: ChallengeManager
//    //    @State var navigateToShareScreen: Bool = false
//    //
//    
//    var body: some View{
//        NavigationStack{
//            ZStack{
//                Image("purpleBackground")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                VStack{
//                    Spacer()
//                    Text("Choose your guardian")
//                        .font(.custom("TorukSC-Regular", size: 28))
//                        .foregroundColor(.white)
//                    Spacer()
//                    HStack{
//                        
//                        ForEach(Clan.allCases) { clan in
//                            ClanCard(clan: clan, isSelected: tempSelection == clan)
//                                .onTapGesture {
//                                    tempSelection = clan
//                                }
//                        }
//                       
//                    }
//                    Spacer()
//                    Button(action: {
//                        if let chosen = tempSelection {
//                            selectedClan = chosen.rawValue
//                            navigateToNext = true
//                            // Navegar para próxima tela, se quiser
//                        }
//                    }) {
//                        Text("DONE")
//                            .font(.custom("TorukSC-Regular", size: 20))
//                            .padding()
//                            .frame(width: 120)
//                            .background(Image("decorativeRectOrange"))
//                            .foregroundColor(.white)
//                    }
//                    .disabled(tempSelection == nil)
//                    .opacity(tempSelection == nil ? 0.5 : 1.0)
//                    
//                    NavigationLink(destination: ReadyView(multipeerSession: multipeerSession), isActive: $navigateToNext) {
//                        EmptyView()
//                    }
//                }
//                .padding()
//            }
//        }
//    }
//    struct ClanCard: View {
//        let clan: Clan
//        let isSelected: Bool
//
//        var body: some View {
//            ZStack {
//                Text(clan.images)
//                
//            }
//            .overlay{
//                if isSelected {
//                    Image("faixaAmarela")
//                        .padding(.top, 130)
//                }
//                
//            }
//        }
//    }
//                
//                //                Button {
//                //                    matchManager.startMatch(users: [user, User(name: "A")], myUserID: user.id)
//                //                    navigateToShareScreen = true
//                //                } label: {
//                //                    ZStack{
//                //
//                //                        Image("startButton")
//                //                    }
//                //                }
//                //                .navigationDestination(isPresented: $navigateToShareScreen) {
//                //                    ShareScreen() // Substitua por sua tela de destino
//                //                }
//            }
//        
//
//
//#Preview{
//    CharacterView( )
//}

import SwiftUI
import CoreMotion

enum Clan: String, CaseIterable, Identifiable, Codable, Hashable {
    case bunny, monkey, feline, frog
    
    var id: String { self.rawValue }

    var image: Image {
        switch self {
        case .bunny: return Image("clanBunny")
        case .monkey: return Image("clanMonkey")
        case .feline: return Image("clanFeline")
        case .frog: return Image("clanFrog")
        }
    }
}

struct CharacterView: View {
    var multipeerSession = MPCSessionManager.shared
    
    @State private var tempSelection: Clan?
    @State private var navigateToNext = false
    
    var body: some View {
     
            ZStack {
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("Choose your guardian")
                        .font(.custom("TorukSC-Regular", size: 28))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack{
                        ForEach(Clan.allCases) { clan in
                            ClanCard(clan: clan, isSelected: tempSelection == clan)
                                .onTapGesture {
                                    tempSelection = clan
                                }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
//                        if let chosenClan = tempSelection,
//                        let session = multipeerSession {
//                            session.selectedClans[session.myDisplayName] = chosenClan
//                                navigateToNext = true
//                            }
                        multipeerSession.selectedClans[multipeerSession.myDisplayName] = tempSelection
                        navigateToNext = true
                    }) {
                        Text("DONE")
                            .font(.custom("TorukSC-Regular", size: 20))
                            .padding()
                            .frame(width: 120)
                            .background(Image("decorativeRectOrange"))
                            .foregroundColor(.white)
                    }
                    .disabled(tempSelection == nil)
                    .opacity(tempSelection == nil ? 0.5 : 1.0)
                    
//                    NavigationLink(destination: ReadyView(multipeerSession: multipeerSession), isActive: $navigateToNext) {
//                        EmptyView()
//                    }
                }
                .padding()
            }
        
    }
}

struct ClanCard: View {
    let clan: Clan
    let isSelected: Bool

    var body: some View {
        ZStack {
            clan.image
              
                
            if isSelected {
                Image("faixaAmarela")
                    .padding(.top, 133)
            }
        }
    }
}

#Preview {
    CharacterView(multipeerSession: MPCSessionManager.shared)
}
