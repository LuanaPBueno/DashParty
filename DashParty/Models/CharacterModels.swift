//
//  CharacterStatus.swift
//  DashParty
//
//  Created by Luana Bueno on 27/05/25.
//


enum CharacterStatus {
    case winner, regular, didnotfinish
}

enum CharacterColor: String {
    case red, blue, yellow, green
}

enum KikoColor: String {
    case red = "KikoRed"
    case blue = "KikoBlue"
    case yellow = "KikoYellow"
    case green = "KikoGreen"
}

enum KikoType: String {
    case red = "KikoRed"
    case blue = "KikoBlue"
    case yellow = "KikoYellow"
    case green = "KikoGreen"
}

enum BannerType: String {
    case winner = "bannerGold"
    case regular = "bannerSilver"
}

struct CharacterFrameType {
    var status: CharacterStatus
    var color: CharacterColor
    
    var imageName: String {
        switch status {
        case .winner:
            return "characterFrame\(color.rawValue.capitalized)Win"
        case .regular:
            return "characterFrame\(color.rawValue.capitalized)Player"
        case .didnotfinish:
            return "characterFrame\(color.rawValue.capitalized)DNF"
        }
    }
}
extension CharacterColor {
    init(kikoColor: KikoColor) {
        switch kikoColor {
        case .red: self = .red
        case .blue: self = .blue
        case .yellow: self = .yellow
        case .green: self = .green
        }
    }
}
