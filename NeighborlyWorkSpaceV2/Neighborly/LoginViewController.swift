//
//  LoginViewController.swift
//  Neighborly
//
//  Created by Other users on 4/14/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit
import Starscream
import SendBirdSDK

class LoginViewController: UIViewController,UITextFieldDelegate,WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("Login Socket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("Login Socket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Login received text: \(text) \n")
       
        let jsonText = text.data(using: .utf8)!
        let decoder = JSONDecoder()
        let userInfo = try? decoder.decode(UserInfoMessage.self, from: jsonText)
        print("userID received:  \(userInfo?.userID)" )
        print("message received:  \(userInfo?.message)" )
        
        if(userInfo?.message == "valid"){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = appDelegate.centerContainer
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("login received data: \(data)")
    }
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
         super.viewDidLoad()
        socket.connect()
        socket.delegate = self
       
        loginButton.isEnabled = false
        self.emailField.delegate = self
        self.passwordTextfield.delegate = self
        // Do any additional setup after loading the view.
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(singleTap)
        
    }
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    @IBAction func loginClicked(_ sender: Any) {
        
        let loginMessage = LoginMessage(messageID: "login", message: "", email: emailField.text!, password: passwordTextfield.text!)
        let encoder = JSONEncoder()
        
        do{
            let data = try encoder.encode(loginMessage)
            socket.write(string: String(data: data, encoding: .utf8)!)
          
        }catch{
            
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func textFieldDidEndEditing(_ textField: UITextField) {
        if(emailField.text != "" && passwordTextfield.text != ""){
            loginButton.isEnabled = true
        }else{
            loginButton.isEnabled = false
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
