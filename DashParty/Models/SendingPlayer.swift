import Foundation
import Combine

class SendingPlayer: ObservableObject, Codable, Equatable, Identifiable {
    static func == (lhs: SendingPlayer, rhs: SendingPlayer) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID
    var name: String
    var currentSituation: Bool
    var currentChallenge: Challenge
    var youWon: Bool
    var interval: TimeInterval
    @Published var progress: Double
    var userClan: Clan?
   
    
    init(id: UUID, name: String, currentSituation: Bool, currentChallenge: Challenge, youWon: Bool, interval: TimeInterval,  progress: Double, userClan: Clan? = nil) {
        self.id = id
        self.name = name
        self.currentSituation = currentSituation
        self.currentChallenge = currentChallenge
        self.youWon = youWon
        self.interval = interval
        self.progress = progress
        self.userClan = userClan
       
    }

    // MARK: - Codable (manual encoding/decoding due to @Published)
    enum CodingKeys: String, CodingKey {
        case id, name, currentSituation, currentChallenge, youWon, interval, userClan, progress
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        currentSituation = try container.decode(Bool.self, forKey: .currentSituation)
        currentChallenge = try container.decode(Challenge.self, forKey: .currentChallenge)
        youWon = try container.decode(Bool.self, forKey: .youWon)
        interval = try container.decode(TimeInterval.self, forKey: .interval)
        userClan = try container.decodeIfPresent(Clan.self, forKey: .userClan)
        progress = try container.decode(Double.self, forKey: .progress)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(currentSituation, forKey: .currentSituation)
        try container.encode(currentChallenge, forKey: .currentChallenge)
        try container.encode(youWon, forKey: .youWon)
        try container.encode(interval, forKey: .interval)
        try container.encode(userClan, forKey: .userClan)
        try container.encode(progress, forKey: .progress)
    }
}
