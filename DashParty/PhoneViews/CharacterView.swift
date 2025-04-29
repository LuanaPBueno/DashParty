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
    @Binding var router:Router
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
                    
                    HStack {
                        
                        ForEach(Clan.allCases) { clan in
                            ClanCard(clan: clan, isSelected: tempSelection == clan)
                                .onTapGesture {
                                    HUBPhoneManager.instance.allPlayers[0].userClan = clan
                                    tempSelection = clan
                                }
                        }
                        
                    }
                    
                    
                    Spacer()
                    HStack{
                        Spacer()
                    Button(action: {
                        if MPCSessionManager.shared.host{
                            print("É host, deveria começar a história")
                            router =  .storyBoard
                            MPCSessionManager.shared.stopSendingUserData()
                        }else{
                            router = .waitingRoom
                            print("É player, deveria seguir para a sala de espera")
                        }
                        
                    }) {
                        
                        ZStack {
                                Image("decorativeRectOrange")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 55) // 📏 tamanho só do botão, sem afetar o resto
                                Text("Done")
                                    .font(.custom("TorukSC-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                    
                }
                      
                    }
                    .padding(.trailing, 20)
                    .disabled(tempSelection == nil)
                    .opacity(tempSelection == nil ? 0.5 : 1.0)
                }
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
