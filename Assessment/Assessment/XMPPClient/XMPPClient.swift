//
//  XMPPClient.swift
//  Assessment
//
//  Created by Hitesh on 23/02/21.
//

import Foundation
import XMPPFramework

enum XMPPClientError:Error {
    case wrongUserJID
}

class XMPPClient:NSObject {
    
    let hostName:String
    let hostPort:UInt16
    
    let userJID:XMPPJID
    let password:String
    
    
    var xmppStream:XMPPStream
    
    init(hostName:String, hostPort:UInt16 = 5222, userJID:String, password:String, queue:DispatchQueue = .main) throws {
        guard let userXMPPJID = XMPPJID(string: userJID) else { throw XMPPClientError.wrongUserJID }
        
        self.hostName = hostName
        self.hostPort = hostPort
        self.userJID = userXMPPJID
        self.password = password
        
        self.xmppStream = XMPPStream()
        self.xmppStream.hostName = hostName
        self.xmppStream.hostPort = hostPort
        self.xmppStream.myJID = self.userJID
        
        super.init()
        
        self.xmppStream.addDelegate(self, delegateQueue: queue)
    }
    
    func connect() {
        if !xmppStream.isDisconnected {
            return
        }
    
        do {
            try xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
        } catch {
            debugPrint("XMPP connection error :- ",error.localizedDescription)
        }
    }
}

// MARK:- XMPPStreamDelegate
extension XMPPClient:XMPPStreamDelegate {
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        debugPrint("Stream: Connected")
        do {
            try xmppStream.authenticate(withPassword: self.password)
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
