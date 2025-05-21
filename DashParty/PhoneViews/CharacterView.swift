import SwiftUI
import CoreMotion

enum Clan: String, CaseIterable, Identifiable, Codable, Hashable {
    case bunny, monkey, feline, frog
    
    var id: String { self.rawValue }
    
    var image: Image {
        switch self {
        case .bunny: return Image("bunnyGreen")
        case .monkey: return Image("bunnyRed")
        case .feline: return Image("bunnyYellow")
        case .frog: return Image("bunnyBlue")
        }
    }
    
    var alternateImage: Image {
        switch self {
        case .bunny: return Image("bunnyGreenGlow")
        case .monkey: return Image("bunnyRedGlow")
        case .feline: return Image("bunnyYellowGlow")
        case .frog: return Image("bunnyBlueGlow")
        }
    }
    
    var color: KikoColor {
        switch self {
        case .bunny: return .green
        case .monkey: return .red
        case .feline: return .yellow
        case .frog: return .blue
        }
    }
}

struct CharacterView: View {
    @Binding var router:Router
    @State private var tempSelection: Clan?
    @State private var navigateToNext = false
    
    var body: some View {
        
        ZStack {
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                Text("Choose your guardian")
                    .font(.custom("TorukSC-Regular", size: 34))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 0) {
                    ForEach(Clan.allCases, id: \.self) { clan in
                        ClanCard(
                            clan: clan,
                            isSelected: clan == tempSelection
                        )
                        .onTapGesture {
                            HUBPhoneManager.instance.allPlayers[0].userClan = clan
                            tempSelection = clan
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)                    .padding(20)
                
                
                Spacer()
                
                HStack{
                    
                    Spacer()
                    if MPCSessionManager.shared.host{
                        Button(action: {
                            router =  .storyBoard
                            MPCSessionManager.shared.stopSendingUserData()
                        }) {
                            OrangeButtonPhone(text: "Play", sizeFont: 24)
                                .frame(width:200, height: 69)
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
        let displayedImage = isSelected ? clan.alternateImage : clan.image
        
        displayedImage
            .resizable()
            .scaledToFit()
        //           .frame(width: 100, height: 100)
    }
}



//    var body: some View {
////        ZStack {
//            clan.image
//            .resizable()
//            .scaledToFit()
//            .frame(width: 140, height: 180)
// .frame(width: 120, height: 120)


//            if isSelected {
//                Image("faixaAmarela")
//                    .padding(.top, 133)
//            }
//        }


#Preview {
    CharacterView(router: .constant(.start))
}

