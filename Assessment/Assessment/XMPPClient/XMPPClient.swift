//
//  XMPPClient.swift
//  Assessment
//
//  Created by Hitesh on 23/02/21.
//

import Foundation
import XMPPFramework

struct XMPPConstant {
    static let host = "stun.joiint.com"
    static let port:UInt16 = 5222
    
    private init() {}
}

enum XMPPClientError:Error {
    case wrongUserJID
}

class XMPPClient:NSObject {
    
    // MARK:- Property
    private let hostName:String
    private let hostPort:UInt16
    
    private var userJID:XMPPJID?
    private var password:String?
    
    
    private var xmppStream:XMPPStream
    
    // MARK:- LifeCycle
    
    init(hostName:String = XMPPConstant.host, hostPort:UInt16 = XMPPConstant.port) {
        
        self.hostName = hostName
        self.hostPort = hostPort
        
        self.xmppStream = XMPPStream()
        self.xmppStream.hostName = hostName
        self.xmppStream.hostPort = hostPort
        
        super.init()
        
        setXMPP(delegate: self)
    }
    func authanticate(userJID:String, password:String) throws {
        guard let userXMPPJID = XMPPJID(string: userJID) else { throw XMPPClientError.wrongUserJID }
        
        self.userJID = nil
        self.userJID = userXMPPJID
        self.password = password
        self.xmppStream.myJID = self.userJID
        connect()
    }
    func setXMPP(delegate:Any, queue:DispatchQueue = .main) {
        self.xmppStream.addDelegate(delegate, delegateQueue: queue)
    }
    func connect() {
        if !xmppStream.isDisconnected {
            disConnect()
        }
        do {
            try xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
        } catch {
            debugPrint("XMPP connection error :- ",error.localizedDescription)
        }
    }
    
    func checkAlreadyConnected() -> Bool {
        if !xmppStream.isDisconnected {
            return true
        }
        return false
    }
    
    func disConnect() {
        xmppStream.disconnect()
    }
}

// MARK:- XMPPStreamDelegate
extension XMPPClient:XMPPStreamDelegate {
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        debugPrint("Stream: Connected")
        guard let pass = self.password else { return }
        do {
            try xmppStream.authenticate(withPassword: pass)
        } catch {
            debugPrint("XMPP authenication error :- ",error.localizedDescription)
        }
    }
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        xmppStream.send(XMPPPresence())
        debugPrint("Stream: Authenticated")
    }
    
    func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        debugPrint("XMPP StreamDidDisconnect error :- ",error?.localizedDescription ?? "Nothing")
    }
}
