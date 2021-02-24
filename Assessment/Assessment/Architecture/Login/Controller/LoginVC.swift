//
//  LoginVC.swift
//  Assessment
//
//  Created by Hitesh on 23/02/21.
//

import UIKit
import XMPPFramework

class LoginVC: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    let loginViewModel = LoginViewModel()
    
    var isLoginEnable: Bool = false {
        didSet {
            btnLogin.isUserInteractionEnabled = isLoginEnable
            btnLogin.alpha = isLoginEnable ? 1.0 : 0.5
        }
    }
    var isLoading: Bool = false {
        didSet {
            btnLogin.isUserInteractionEnabled = !isLoading
            activityView.isHidden = !isLoading
            if isLoading {
                activityView.startAnimating()
            } else {
                activityView.stopAnimating()
            }
        }
    }
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoading = false
        isLoginEnable = false
        loginViewModel.setXMPPDelegate(self)
        addTextFieldObserver()
    }
    
    private func addTextFieldObserver() {
        txtEmail.addTarget(self, action: #selector(textFieldDidUpdateText(_:)), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldDidUpdateText(_:)), for: .editingChanged)
    }
    
    fileprivate func validate() -> Bool {
        let userName = txtEmail.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let password = txtPassword.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        if userName.isEmpty && password.isEmpty {
            return false
        } else if userName.isEmpty {
            return false
        } else if password.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    @objc fileprivate func textFieldDidUpdateText(_ textField:UITextField) {
        isLoginEnable = validate()
    }
    
    func redirectToPostVC() {
        let vc = StoryBorads.main.instantiateViewController(withIdentifier: PostsVC.storyBoardIdentifier) as! PostsVC
        self.navigationController?.setViewControllers([vc], animated: false)
    }
    
    // MARK:- IBAction
    @IBAction func onBtnLoginAction(_ sender: Any) {
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        isLoading = loginViewModel.login(userName: email, password: password)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK :- XMPPStreamDelegate
extension LoginVC: XMPPStreamDelegate {
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        isLoading = false
        self.showAlert(title: "Success!", message: "Login successfully") {
            self.redirectToPostVC()
        }
    }
    
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        isLoading = false
        self.showAlert(message: "Wrong username or password", completion: nil)
    }
    
    func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        isLoading = false
        if error != nil {
            self.showAlert(message: error!.localizedDescription, completion: nil)
        }

    }
}
