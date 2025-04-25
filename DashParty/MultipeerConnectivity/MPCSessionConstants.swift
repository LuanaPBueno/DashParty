
import Foundation
import MultipeerConnectivity
import CoreMotion


struct MPCSessionConstants {
    static let kKeyIdentity: String = "identity"
}

@Observable
class MPCSession: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, ObservableObject {
    // MARK: - Properties

    // Adicione esta propriedade à sua classe
    let motionManager = CMMotionManager()
    var matchManager: ChallengeManager
    var currentAcceleration: CMAcceleration?
    var pendingInvitations: [String: ((Bool, MCSession?) -> Void)] = [:]
    var peerDataHandler: ((Data, MCPeerID) -> Void)? {
        didSet {
            print("PEER DATA HANDLER CHANGED \(oldValue == nil) -> \(peerDataHandler == nil)")
        }
    }
    var peerConnectedHandler: ((MCPeerID) -> Void)?
    var peerDisconnectedHandler: ((MCPeerID) -> Void)?
    var gameStartedHandler: (() -> Void)?
    var invitationReceivedHandler: ((String) -> Void)?
    var selectedClans: [String: Clan] = [:] // Novo: guarda o clan escolhido por cada peer

        var myPeerID: MCPeerID {
            mcSession.myPeerID
        }

        var myDisplayName: String {
            mcSession.myPeerID.displayName
        }
    
    var invitationHandler: ((Bool, MCSession?) -> Void)?
    
    private let serviceString: String
    private let identityString: String
    var connectedPeersNames: [String] = [] {
            didSet {
                print("Lista de peers atualizada: \(connectedPeersNames)")
            }
        }
    private let maxNumPeers: Int
    private var isSendingMessages = false
    private var shouldStopSending = false
    var shouldStartGame = false
    var host: Bool = false
    
    private(set) var mcSession: MCSession
    var mcAdvertiser: MCNearbyServiceAdvertiser
    private var mcBrowser: MCNearbyServiceBrowser?
    
    var localPeerID: MCPeerID
    
    // MARK: - Initialization
    init(service: String, identity: String, maxPeers: Int, matchManager: ChallengeManager) {
        self.serviceString = service
        self.identityString = identity
        self.maxNumPeers = maxPeers
        self.matchManager = matchManager
    
        let peerID = MCPeerID(displayName: UIDevice.current.name)
        
        self.localPeerID = peerID
        self.mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .optional)
        self.mcAdvertiser = MCNearbyServiceAdvertiser(
            peer: peerID,
            discoveryInfo: [MPCSessionConstants.kKeyIdentity: identityString],
            serviceType: serviceString
        )
        
        super.init()
        
        self.mcSession.delegate = self
        self.mcAdvertiser.delegate = self
       // self.resetBrowser() -> Aqui, ele inicia
        self.mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceString)
        self.mcBrowser?.delegate = self
    }
    
    func startSession(asHost: Bool) {
        self.host = asHost
        if host {
            print("🧑‍💼 Iniciando como HOST")
           // mcAdvertiser.startAdvertisingPeer()
        } else {
            print("🎮 Iniciando como PLAYER")
            mcBrowser?.startBrowsingForPeers()
        }
    }

    
    // MARK: - Session Management
     func resetSession() {
        mcAdvertiser.stopAdvertisingPeer()
        mcSession.disconnect()
        if host{
            localPeerID = MCPeerID(displayName: HUBPhoneManager.instance.roomName)
        } else{
            localPeerID = MCPeerID(displayName: HUBPhoneManager.instance.playername)
        }
        mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .optional)
        mcSession.delegate = self
        mcAdvertiser = MCNearbyServiceAdvertiser(
            peer: localPeerID,
            discoveryInfo: [MPCSessionConstants.kKeyIdentity: identityString],
            serviceType: serviceString
        )
        mcAdvertiser.delegate = self
        mcAdvertiser.startAdvertisingPeer()
        
        if mcBrowser != nil {
            resetBrowser()
        }
         
    }

    private func resetBrowser() {
        mcBrowser?.stopBrowsingForPeers()
        mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceString)
        mcBrowser?.delegate = self
        mcBrowser?.startBrowsingForPeers()
    }
    
    func start() {
       // mcAdvertiser.startAdvertisingPeer()
        mcBrowser?.startBrowsingForPeers()
    }
    
    func suspend() {
        mcAdvertiser.stopAdvertisingPeer()
        mcBrowser?.stopBrowsingForPeers()
    }
    
    func invalidate() {
        suspend()
        mcSession.disconnect()
    }
    
    // MARK: - Invitation Handling
    func acceptInvitation() {
        DispatchQueue.main.async {
            self.invitationHandler?(true, self.mcSession)
            self.invitationHandler = nil
        }
    }
    
    func rejectInvitation() {
        DispatchQueue.main.async {
            self.invitationHandler?(false, nil)
            self.invitationHandler = nil
        }
    }
    
    // MARK: - Data Transfer
    func sendDataToAllPeers(data: Data) {
        sendData(data: data, peers: mcSession.connectedPeers, mode: .reliable)
        print("Enviei a mensagem para o usuário")
    }

    
    func sendData(data: Data, peers: [MCPeerID], mode: MCSessionSendDataMode) {
        let connectedPeers = mcSession.connectedPeers.filter { peers.contains($0) }
        guard !connectedPeers.isEmpty else {
            print("⚠️ No connected peers to send data to.")
            return
        }
        
        do {
            try mcSession.send(data, toPeers: connectedPeers, with: mode)
        } catch {
            print("❌ Failed to send data: \(error)")
        }
    }
    
    func setupCoreMotion() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01 // 100 Hz
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                if let acceleration = data?.acceleration {
                    self?.currentAcceleration = acceleration
                }
            }
        } else {
            print("Acelerômetro não disponível")
        }
    }

    struct AccelerationData: Codable {
        let x: Double
        let y: Double
        let z: Double
        let timestamp: Date // Opcional: útil para sincronização
    }

    //MARK: ENVIANDO DATA
    func sendMyCoordinatesToHost() {
        guard !host else { return }
        guard let hostPeer = mcSession.connectedPeers.first else {
            print("Host não encontrado.")
            return
        }
        
        guard !isSendingMessages else { return }
        isSendingMessages = true
        shouldStopSending = false
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            while self.shouldStopSending == false {
                    
                    do {
                        let encoder = JSONEncoder()
                        encoder.dateEncodingStrategy = .iso8601
                        let data = try encoder.encode(
                            EventMessage.playerUpdate(
                                SendingPlayer(
                                    id: HUBPhoneManager.instance.user.id ,
                                    name: HUBPhoneManager.instance.playername,
                                    currentSituation: HUBPhoneManager.instance.allPlayers[0].currentSituation,
                                    currentChallenge: HUBPhoneManager.instance.allPlayers[0].currentChallenge,
                                    youWon: HUBPhoneManager.instance.allPlayers[0].youWon,
                                    interval: HUBPhoneManager.instance.allPlayers[0].interval,
                                    progress: HUBPhoneManager.instance.allPlayers[0].progress
                                    
                                )
                            )
                        )
                       
                        self.sendData(data: data, peers: [hostPeer], mode: .reliable)
                    } catch {
                        print("Erro ao codificar dados de aceleração:", error)
                        break
                    }
                
                
                Thread.sleep(forTimeInterval: 0.01) // Ajuste conforme necessário
            }
            self.isSendingMessages = false
        }
    }
    
    func stopSendingMessages() {
        shouldStopSending = true
    }
    
    // MARK: - MCSessionDelegate
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            peerConnected(peerID: peerID)
            print("✅ Peer conectado: \(peerID.displayName), \(host)")
        case .notConnected:
            peerDisconnected(peerID: peerID)
            print("❌ Peer desconectado: \(peerID.displayName), \(host)")
        case .connecting:
            print("🔄 Conectando ao peer: \(peerID.displayName), \(host)")
        @unknown default:
            fatalError("Unhandled MCSessionState")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("📥 Dados recebidos de \(peerID.displayName): \(String(data: data, encoding: .utf8) ?? "Não foi possível decodificar")")
        
        let receivedString = String(data: data, encoding: .utf8)
                if receivedString == "StartTime" {
                    HUBPhoneManager.instance.matchManager.players[0].startTime = true
                    HUBPhoneManager.instance.matchManager.atualizaStart()
                    }
                    
                if receivedString == "Reset" {
                    HUBPhoneManager.instance.matchManager.players[0].startTime = false
                    for index in HUBPhoneManager.instance.allPlayers.indices {
                        HUBPhoneManager.instance.allPlayers[index].youWon = false
                    }
                    print("Recebi a func de reset")
                    HUBPhoneManager.instance.matchManager.reset()
                }
        
        if let handler = peerDataHandler {
            DispatchQueue.main.async {
                handler(data, peerID)
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Não implementado
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Não implementado
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Não implementado
    }
    
    // MARK: - MCNearbyServiceBrowserDelegate
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        print("👀 Peer encontrado: \(peerID.displayName), \(host)")
        guard let identityValue = info?[MPCSessionConstants.kKeyIdentity] else {
            print("⚠️ Peer sem identidade válida")
            return
        }
        
        if identityValue == identityString {
            if host {
                if mcSession.connectedPeers.count < maxNumPeers {
                    print("📡 Host enviando convite para \(peerID.displayName)")
                    browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 10)
                }
            } else {
                // Player adiciona à lista de peers disponíveis
                DispatchQueue.main.async {
                    self.pendingInvitations[peerID.displayName] = { accept, session in
//                        if accept {
//                            browser.invitePeer(peerID, to: session ?? self.mcSession, withContext: nil, timeout: 10)
//                        }
                    }
                    // Notifica a UI que há uma nova sala disponível
                    self.invitationReceivedHandler?(peerID.displayName)
                }
            }
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("👋 Peer perdido: \(peerID.displayName)")
    }
    
    // MARK: - MCNearbyServiceAdvertiserDelegate
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        if !host{
            print("📩 Convite recebido de \(peerID.displayName)")
          
                DispatchQueue.main.async {
                    self.invitationHandler = invitationHandler
                    self.invitationReceivedHandler?(peerID.displayName)
                }
            
        }
    }
    
    // MARK: - Peer Management
    private func peerConnected(peerID: MCPeerID) {
        updateConnectedPeersList()
        if let handler = peerConnectedHandler {
            DispatchQueue.main.async {
                handler(peerID)
            }
            updateConnectedPeersList()
        }

        
        if !host {
            print("enviando coordenadas")
            matchManager.startMatch(users: [HUBPhoneManager.instance.user], myUserID: HUBPhoneManager.instance.allPlayers[0].id, index: 0)
            sendMyCoordinatesToHost()
        }
        setupMessageHandler()
        print("⚡ Host pronto para receber mensagens dos peers")
        
        if mcSession.connectedPeers.count == maxNumPeers {
            shouldStartGame = true
            self.suspend()
        }
    }
    
    private func peerDisconnected(peerID: MCPeerID) {
        updateConnectedPeersList()
        if !host {
            stopSendingMessages()
        }
        
        if let handler = peerDisconnectedHandler {
            DispatchQueue.main.async {
                handler(peerID)
            }
        }
        
        if mcSession.connectedPeers.count < maxNumPeers {
            self.start()
        }
       
    }
    
    private func updateConnectedPeersList() {
           DispatchQueue.main.async {
               self.connectedPeersNames = self.mcSession.connectedPeers.map { $0.displayName }
           }
       }
    
    private func setupMessageHandler() {
        peerDataHandler = { [weak self] data, peerID in
            guard let self = self else { return }
            
            setupMessageHandler(data, from: peerID)
        }
    }
    
    //MARK: Enviando DATA
    func setupMessageHandler(_ data: Data, from peer: MCPeerID) {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let receivedData = try decoder.decode(EventMessage.self, from: data)
            switch receivedData {
            case .navigation(let navigationData):
                print(Thread.isMainThread)
                HUBPhoneManager.instance.router = navigationData
            case .playerUpdate(let receivedData):
            //let receivedData = try decoder.decode(SendingPlayer.self, from: data)
                
                // Atualizar UI ou processar os dados
                DispatchQueue.main.async {
                    if let existingPlayerIndex = HUBPhoneManager.instance.allPlayers.firstIndex(where: { $0.id == receivedData.id }) {
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].currentSituation = receivedData.currentSituation
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].currentChallenge = receivedData.currentChallenge
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].youWon = receivedData.youWon
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].interval = receivedData.interval
                        
                        print("Mudando o status: \(receivedData)")
                    } else {
                        HUBPhoneManager.instance.allPlayers.append(receivedData)
                        print("appendando: \(receivedData)")
                    }
                }
            }
        } catch {
            print("Erro ao decodificar dados recebidos:", error)
        }
    }
    
 
    
    
    // MARK: - Utility
    func getConnectedPeersNames() -> [String] {
        return mcSession.connectedPeers.map { $0.displayName }
    }
    
}

// Singleton manager
class MPCSessionManager {
    static let shared = MPCSession(service: "nisample", identity: "com.dashparty.app", maxPeers: 3, matchManager: HUBPhoneManager.instance.matchManager)
}

enum EventMessage: Codable {
    case navigation(Router)
    case playerUpdate(SendingPlayer)
    
}
