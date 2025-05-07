import Foundation
import MultipeerConnectivity
import CoreMotion
import UIKit

struct MPCSessionConstants {
    static let kKeyIdentity: String = "identity"
}

@Observable
class MPCSession: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, ObservableObject {
    
    // MARK: - Propriedades
    
    // Variáveis para comunicação
    var nearbyPeers: [MCPeerID] = []
    var dataSendTimer: Timer?
    var connectedPeersNames: [String] = [] {
        didSet {
            print("Lista de peers atualizada: \(connectedPeersNames)")
        }
    }
    var isConnected: Bool = false
    var hostPeerID: MCPeerID?
    var hostName: String = ""
    var peersDiscoveryInfo: [MCPeerID: [String: String]] = [:]
    
    // Gerenciamento de background
    private var backgroundTaskID: UIBackgroundTaskIdentifier = .invalid
    private var shouldKeepSendingInBackground = false
    
    // Motion e gerenciamento de partida
    let motionManager = CMMotionManager()
    var matchManager: ChallengeManager
    var currentAcceleration: CMAcceleration?
    var pendingInvitations: [String: ((Bool, MCSession?) -> Void)] = [:]
    
    // Handlers
    var peerDataHandler: ((Data, MCPeerID) -> Void)? {
        didSet {
            print("PEER DATA HANDLER CHANGED \(oldValue == nil) -> \(peerDataHandler == nil)")
        }
    }
    var peerConnectedHandler: ((MCPeerID) -> Void)?
    var peerDisconnectedHandler: ((MCPeerID) -> Void)?
    var gameStartedHandler: (() -> Void)?
    var invitationReceivedHandler: ((String) -> Void)?
    var selectedClans: [String: Clan] = [:]
    
    var myPeerID: MCPeerID {
        mcSession.myPeerID
    }
    
    var myDisplayName: String {
        mcSession.myPeerID.displayName
    }
    
    var invitationHandler: ((Bool, MCSession?) -> Void)?
    
    private let serviceString: String
    private let identityString: String
    private let maxNumPeers: Int
    private var isSendingMessages = false
    private var shouldStopSending = false
    var shouldStartGame = false
    var host: Bool = false
    
    private(set) var mcSession: MCSession
    var mcAdvertiser: MCNearbyServiceAdvertiser
    private var mcBrowser: MCNearbyServiceBrowser?
    var localPeerID: MCPeerID
    
    // MARK: - Inicialização
    
    init(service: String, identity: String, maxPeers: Int, matchManager: ChallengeManager) {
        self.serviceString = service
        self.identityString = identity
        self.maxNumPeers = maxPeers
        self.matchManager = matchManager
        
        let peerID = MCPeerID(displayName: UIDevice.current.name)
        
        self.localPeerID = peerID
        self.mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        self.mcAdvertiser = MCNearbyServiceAdvertiser(
            peer: peerID,
            discoveryInfo: [MPCSessionConstants.kKeyIdentity: identityString],
            serviceType: serviceString
        )
        
        
        super.init()
        
        self.mcSession.delegate = self
        self.mcAdvertiser.delegate = self
        self.mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceString)
        self.mcBrowser?.delegate = self

        // Configurações para funcionar em background
        setupBackgroundHandling()
        startConnectionMonitor()
       // checkAdvertising()
    }
    
//    func checkAdvertising(){
//        if mcSession.myPeerID.displayName == UIDevice.current.name {
//            mcAdvertiser.stopAdvertisingPeer()
//        }
//    }
    
    // MARK: - Gerenciamento de Sessão
    
    func startSession(asHost: Bool) {
        self.host = asHost
        if host {
            print("🧑‍💼 Iniciando como HOST")
            mcAdvertiser.startAdvertisingPeer()
        } else {
            print("🎮 Iniciando como PLAYER")
            mcBrowser?.startBrowsingForPeers()
        }
    }
    
    func resetSession() {
        print("Session Resetada!!")
        self.invalidate()
        
        if host {
            localPeerID = MCPeerID(displayName: HUBPhoneManager.instance.roomName)
        } else {
            localPeerID = MCPeerID(displayName: HUBPhoneManager.instance.playername)
        }
        
        mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        
        mcAdvertiser = MCNearbyServiceAdvertiser(
            peer: localPeerID,
            discoveryInfo: [
                MPCSessionConstants.kKeyIdentity: identityString,
                "HostName": HUBPhoneManager.instance.playername
            ],
            serviceType: serviceString
        )
        mcAdvertiser.delegate = self
        
        if mcBrowser != nil {
            resetBrowser()
        }
         
        if host {
            mcAdvertiser.startAdvertisingPeer()
        } else {
            mcBrowser?.startBrowsingForPeers()
        }
    }
    
    func stopAdvertising(){
        print("chamei a stopAdvertising")
        mcAdvertiser.stopAdvertisingPeer()
    }
    
    private func resetBrowser() {
        mcBrowser?.stopBrowsingForPeers()
        mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceString)
        mcBrowser?.delegate = self
    }
    
    func start() {
        mcBrowser?.startBrowsingForPeers()
    }
    
    func suspend() {
        print("Session Suspended!!")
        mcAdvertiser.stopAdvertisingPeer()
        mcBrowser?.stopBrowsingForPeers()
    }
    
    func suspendAdvertising() {
        print("Suspending Advertising")
        mcAdvertiser.stopAdvertisingPeer()
    }
    
    func invalidate() {
        suspend()
        mcSession.disconnect()
    }
    
    // MARK: - Gerenciamento de Background
    
    private func setupBackgroundHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc  func appDidEnterBackground() {
        print("App entrou em background - mantendo conexão ativa")
        shouldKeepSendingInBackground = true
        
        // Iniciar tarefa em background
        backgroundTaskID = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        
        // Continuar enviando dados mesmo em background
        DispatchQueue.global(qos: .background).async { [weak self] in
            while self?.shouldKeepSendingInBackground == true {
                self?.sendDataInBackground()
                Thread.sleep(forTimeInterval: 1.0) // Intervalo maior para economizar bateria
            }
        }
    }
    
    @objc  func appWillEnterForeground() {
        print("App voltou para foreground")
        shouldKeepSendingInBackground = false
        endBackgroundTask()
        
        // Retomar envio normal se necessário
        if !host && isConnected {
            sendMyCoordinatesToHost()
        }
    }
    
    private func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTaskID)
        backgroundTaskID = .invalid
    }
    
    private func startConnectionMonitor() {
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.mcSession.connectedPeers.isEmpty && self.isConnected {
                print("Conexão perdida - tentando reconectar")
                self.resetSession()
            }
        }
    }
    
    // MARK: - Convites
    
    func acceptInvitation(peer: String) {
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
    
    // MARK: - Transferência de Dados
    
    func sendDataToAllPeers(data: Data) {
        sendData(data: data, peers: mcSession.connectedPeers, mode: .reliable)
        print("Enviei a mensagem para o usuário")
    }
    
    func startSendingUserDataContinuously(interval: TimeInterval = 1.0) {
        dataSendTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let userData: [SendingPlayer] = HUBPhoneManager.instance.allPlayers
            do {
                let encodedData = try JSONEncoder().encode(userData)
                self.sendDataToAllPeers(data: encodedData)
            } catch {
                print("Erro ao codificar os dados do usuário: \(error)")
            }
        }
    }

    func stopSendingUserData() {
        dataSendTimer?.invalidate()
        dataSendTimer = nil
    }
    
    func sendData(data: Data, peers: [MCPeerID], mode: MCSessionSendDataMode) {
        let connectedPeers = mcSession.connectedPeers.filter { peers.contains($0) }
        guard !connectedPeers.isEmpty else {
            print("⚠️ No connected peers to send data to.")
            return
        }
        
        // Usar modo diferente dependendo do estado do app
        let sendMode: MCSessionSendDataMode = UIApplication.shared.applicationState == .background ? .unreliable : mode
        
        do {
            try mcSession.send(data, toPeers: connectedPeers, with: sendMode)
        } catch {
            let nsError = error as NSError
            print("❌ Failed to send data: \(nsError)")
            
            // Códigos de erro documentados do MCSession (não existe enum oficial)
            if nsError.domain == "MCSessionErrorDomain" {
                switch nsError.code {
                case 0: // Não conectado
                    print("Peer não conectado - tentando reconectar")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.resetSession()
                    }
                case 1: // Timeout
                    print("Timeout ao enviar dados")
                case 2: // Muitos peers
                    print("Muitos peers conectados")
                default:
                    print("Erro desconhecido do MCSession")
                }
            }
        }
    }
    
    private func sendDataInBackground() {
        guard !host else { return }
        guard let hostPeer = mcSession.connectedPeers.first else { return }
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(
                EventMessage.playerUpdate(
                    SendingPlayer(
                        id: HUBPhoneManager.instance.user.id,
                        name: HUBPhoneManager.instance.playername,
                        currentSituation: HUBPhoneManager.instance.allPlayers[0].currentSituation,
                        currentChallenge: HUBPhoneManager.instance.allPlayers[0].currentChallenge,
                        youWon: HUBPhoneManager.instance.allPlayers[0].youWon,
                        interval: HUBPhoneManager.instance.allPlayers[0].interval,
                        progress: HUBPhoneManager.instance.allPlayers[0].progress,
                        userClan: HUBPhoneManager.instance.allPlayers[0].userClan ?? nil
                    )
                )
            )
            try mcSession.send(data, toPeers: [hostPeer], with: .unreliable)
        } catch {
            print("Erro ao enviar dados em background:", error)
        }
    }
    
    // MARK: - Envio de Coordenadas
    
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
                                id: HUBPhoneManager.instance.user.id,
                                name: HUBPhoneManager.instance.playername,
                                currentSituation: HUBPhoneManager.instance.allPlayers[0].currentSituation,
                                currentChallenge: HUBPhoneManager.instance.allPlayers[0].currentChallenge,
                                youWon: HUBPhoneManager.instance.allPlayers[0].youWon,
                                interval: HUBPhoneManager.instance.allPlayers[0].interval,
                                progress: HUBPhoneManager.instance.allPlayers[0].progress,
                                userClan: HUBPhoneManager.instance.allPlayers[0].userClan ?? nil
                            )
                        )
                    )
                   
                    self.sendData(data: data, peers: [hostPeer], mode: .reliable)
                } catch {
                    print("Erro ao codificar dados de aceleração:", error)
                    break
                }
                
                Thread.sleep(forTimeInterval: 0.01)
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
            DispatchQueue.main.async {
                self.isConnected = true
                if let idx = self.hostPeerID {
                    let discInfo = self.peersDiscoveryInfo[idx]
                    self.hostName = discInfo!["HostName"]!
                }
            }
            print("✅ Peer conectado: \(peerID.displayName), \(host)")
            
        case .notConnected:
            peerDisconnected(peerID: peerID)
            DispatchQueue.main.async {
                self.isConnected = false
            }
            print("❌ Peer desconectado: \(peerID.displayName), \(host)")
            
        case .connecting:
            print("🔄 Conectando ao peer: \(peerID.displayName), \(host)")
            
        @unknown default:
            fatalError("Unhandled MCSessionState")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            let players = try JSONDecoder().decode([SendingPlayer].self, from: data)
            print("✅ Recebido array de jogadores: \(players)")
            HUBPhoneManager.instance.receivedPlayers = players
            return
        } catch {
         //   print("❌ Não é um array de jogadores: \(error.localizedDescription)")
        }
        
        if let receivedString = String(data: data, encoding: .utf8) {
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
        DispatchQueue.main.async {
            if !self.nearbyPeers.contains(peerID) {
                self.nearbyPeers.append(peerID)
                
                if let info = info {
                    self.peersDiscoveryInfo[peerID] = info
                }
            }
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.nearbyPeers.removeAll { $0.displayName == peerID.displayName }
        }
        print("👋 Peer perdido: \(peerID.displayName)")
    }
    
    // MARK: - MCNearbyServiceAdvertiserDelegate
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("📩 Convite recebido de \(peerID.displayName)")
        let handler = invitationHandler
        handler(true, self.mcSession)
    }
    
    // MARK: - Gerenciamento de Peers
    
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
            self.setupMessageHandler(data, from: peerID)
        }
    }
    
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
                DispatchQueue.main.async {
                    if let existingPlayerIndex = HUBPhoneManager.instance.allPlayers.firstIndex(where: { $0.id == receivedData.id }) {
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].currentSituation = receivedData.currentSituation
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].currentChallenge = receivedData.currentChallenge
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].youWon = receivedData.youWon
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].interval = receivedData.interval
                        HUBPhoneManager.instance.allPlayers[existingPlayerIndex].progress =  receivedData.progress
                        
                        if receivedData.userClan != nil {
                            HUBPhoneManager.instance.allPlayers[existingPlayerIndex].userClan = receivedData.userClan
                        }
                    } else {
                        HUBPhoneManager.instance.allPlayers.append(receivedData)
                      //  print("appendando: \(receivedData)")
                    }
                }
            }
        } catch {
          //  print("Erro ao decodificar dados recebidos:", error)
        }
    }
    
    // MARK: - Utilitários
    
    func getConnectedPeersNames() -> [String] {
        return mcSession.connectedPeers.map { $0.displayName }
    }
    
    func invite(peer: MCPeerID) {
        hostPeerID = peer
        mcBrowser?.invitePeer(peer, to: mcSession, withContext: nil, timeout: 90)
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
