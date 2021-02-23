//
//  LoginViewModel.swift
//  Assessment
//
//  Created by Hitesh on 23/02/21.
//

import Foundation
class LoginViewModel {
    
    private var xmppClient:XMPPClient?
    
    init(xmppClient:XMPPClient = XMPPClient()) {
        self.xmppClient = XMPPClient()
    }
    func setXMPPDelegate(_ delegate:Any) {
        self.xmppClient?.setXMPP(delegate: delegate)
    }
    func login(userName:String, password:String) -> Bool {
        if xmppClient!.checkAlreadyConnected() {
            return false
        }
        do {
            try xmppClient?.authanticate(userJID: userName, password: password)
        } catch {
            debugPrint("Error : ",error.localizedDescription)
            return false
        }
        return true
    }
    
    deinit {
        xmppClient = nil
    }
}
