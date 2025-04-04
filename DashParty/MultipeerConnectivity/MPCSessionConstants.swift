//
//  New.swift
//  DashParty
//
//  Created by Luana Bueno on 31/03/25.
//

import Foundation
/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A class that manages peer discovery-token exchange over the local network by using MultipeerConnectivity.
*/

import Foundation
import MultipeerConnectivity

struct MPCSessionConstants {
    static let kKeyIdentity: String = "identity"
}


class MPCSessionManager {
    static let shared = MPCSession(service: "nisample", identity: "Luana-Bueno.DashParty", maxPeers: 3)
}


@Observable
class MPCSession: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    var peerDataHandler: ((Data, MCPeerID) -> Void)?
    var peerConnectedHandler: ((MCPeerID) -> Void)?
    private var isSendingMessages = false
    private var shouldStopSending = false
    var peerDisconnectedHandler: ((MCPeerID) -> Void)?
    private let serviceString: String
    let mcSession: MCSession
    private let localPeerID = MCPeerID(displayName: UIDevice.current.name) //MARK: O nome de usuário que aparece é o nome do dispositivo. Depois, mudar isso para o nome do usuário ou imagem.
    private let mcAdvertiser: MCNearbyServiceAdvertiser
    private let identityString: String
    private let maxNumPeers: Int
    private var mcBrowser: MCNearbyServiceBrowser?
    var host: Bool = false
    
    init(service: String, identity: String, maxPeers: Int) {
        serviceString = service
        identityString = identity
        mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .optional)
        mcAdvertiser = MCNearbyServiceAdvertiser(peer: localPeerID,
                                                 discoveryInfo: [MPCSessionConstants.kKeyIdentity: identityString],
                                                 serviceType: serviceString)
        mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceString)
        maxNumPeers = maxPeers

        super.init()
        mcSession.delegate = self
        mcAdvertiser.delegate = self
        mcBrowser?.delegate = self
    }

    // MARK: - `MPCSession` public methods.
    func start() {
        mcAdvertiser.startAdvertisingPeer()
        if mcBrowser == nil {
            mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceString)
            mcBrowser?.delegate = self
        }
        mcBrowser?.startBrowsingForPeers()
    }

    func suspend() {
        mcAdvertiser.stopAdvertisingPeer()
        mcBrowser = nil
    }

    func invalidate() {
        suspend()
        mcSession.disconnect()
    }

    func sendDataToAllPeers(data: Data) {
        sendData(data: data, peers: mcSession.connectedPeers, mode: .reliable)
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

    // MARK: - `MPCSession` private methods.
    private func peerConnected(peerID: MCPeerID) {
        if let handler = peerConnectedHandler {
            DispatchQueue.main.async {
                handler(peerID)
            }
        }
        
        if !host {
            print("enviando msg de bom dia")
            sendBomDiaRepeatedlyToHost()
        } else {
            setupMessageHandler()
            print("⚡ Host pronto para receber mensagens dos peers")
        }
        
        if mcSession.connectedPeers.count == maxNumPeers {
            shouldStartGame =  true
            self.suspend()
        }
    }
    
    private func setupMessageHandler() {
        print("recebendo msg de bom dia")
        peerDataHandler = { [weak self] data, peerID in
            guard let self = self, self.host else { return }
            
            print("antes do if message")
            if let message = String(data: data, encoding: .utf8), message == "bom dia" {
                let timestamp = DateFormatter.localizedString(from: Date(),
                                                            dateStyle: .none,
                                                            timeStyle: .medium)
                print("no  if message")
                print("[\(timestamp)] 📬 Recebido de \(peerID.displayName): \(message)")
            }
            print("depois do if message")
        }
    }
    
    func stopSendingMessages() {
        shouldStopSending = true
    }


    private func peerDisconnected(peerID: MCPeerID) {
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

    // MARK: - `MCSessionDelegate`.
    internal func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            peerConnected(peerID: peerID)
            print("✅ Peer conectado: \(peerID.displayName), \(host)")
        case .notConnected:
            peerDisconnected(peerID: peerID)
            print("❌ Peer desconectado: \(peerID.displayName), \(host)")
        case .connecting:
            print("🔄 Conectando ao peer: \(peerID.displayName), \(host)")
            break
        @unknown default:
            fatalError("Unhandled MCSessionState")
        }
    }

    internal func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("📥 Dados recebidos de \(peerID.displayName): \(String(data: data, encoding: .utf8) ?? "Não foi possível decodificar")")
        if let handler = peerDataHandler {
            DispatchQueue.main.async {
                handler(data, peerID)
            }
        }
    }
    
    func sendBomDiaRepeatedlyToHost() {
        guard !host else { return }
        guard let hostPeer = mcSession.connectedPeers.first else {
            print("Host não encontrado.")
            return
        }
        
        // Evita iniciar múltiplos envios simultâneos
        guard !isSendingMessages else { return }
        isSendingMessages = true
        shouldStopSending = false
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            while self?.shouldStopSending == false {
                let message = "bom dia"
                if let data = message.data(using: .utf8) {
                    self?.sendData(data: data, peers: [hostPeer], mode: .reliable)
                }
                Thread.sleep(forTimeInterval: 0.001)
            }
            self?.isSendingMessages = false
        }
    }

    internal func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // The sample app intentional omits this implementation.
    }

    internal func session(_ session: MCSession,
                          didStartReceivingResourceWithName resourceName: String,
                          fromPeer peerID: MCPeerID,
                          with progress: Progress) {
        // The sample app intentional omits this implementation.
    }

    internal func session(_ session: MCSession,
                          didFinishReceivingResourceWithName resourceName: String,
                          fromPeer peerID: MCPeerID,
                          at localURL: URL?,
                          withError error: Error?) {
        // The sample app intentional omits this implementation.
    }

    
    func send(_: Data, toPeers: [MCPeerID], with: MCSessionSendDataMode) throws {
        //TODO: something
    }
    
//    func sendResourse(at: URL , withName: String, toPeer: MCPeerID, withCompletionHandler: ((any Error)?) -> Void?) -> Progress?{
//        //TODO: something
//    }
    
    
    var gameStartedHandler: (() -> Void)?
    var shouldStartGame = false
   

    
    // MARK: - `MCNearbyServiceBrowserDelegate`.
    internal func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        print("👀 Peer encontrado: \(peerID.displayName), \(host)")
        if self.host{
            guard let identityValue = info?[MPCSessionConstants.kKeyIdentity] else {
                print("⚠️ Peer sem identidade válida")
                return
            }
            print("🎯 Identidade do peer: \(identityValue)")
            if identityValue == identityString && mcSession.connectedPeers.count < maxNumPeers {
                print("📡 Enviando convite para \(peerID.displayName)")
                browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 10)
            }
        }
    }
    
    func getConnectedPeersNames() -> [String] {
        return mcSession.connectedPeers.map { $0.displayName }
    }
    
   
    internal func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // The sample app intentional omits this implementation.
    }

    // MARK: - `MCNearbyServiceAdvertiserDelegate`.
    internal func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                             didReceiveInvitationFromPeer peerID: MCPeerID,
                             withContext context: Data?,
                             invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("📩 Convite recebido de \(peerID.displayName)")
        if !self.host {
            if self.mcSession.connectedPeers.count < maxNumPeers {
                print("✅ Aceitando convite de \(peerID.displayName), \(host)")
                invitationHandler(true, mcSession)
            } else {
                print("❌ Número máximo de peers atingido, convite recusado, \(host)")
                invitationHandler(false, nil)
            }
        }
    }

}
