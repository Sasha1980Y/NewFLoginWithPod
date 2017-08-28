//
//  ViewController.swift
//  NewFLoginWithPod
//
//  Created by AlexanderYakovenko on 8/25/17.
//  Copyright © 2017 AlexanderYakovenko. All rights reserved.
//

import UIKit

import FacebookLogin
import FacebookCore
import FacebookShare

import Google
import GoogleSignIn




class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    
    
    
    let appDelegate = AppDelegate.sharedInstance
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Google+
        
        
        
        
        var error: NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        if error != nil {
            print(error)
            return
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        
        let signButton = GIDSignInButton(frame: CGRect(x: 50, y: 120, width: 150, height: 60))
        view.addSubview(signButton)
        
        //  FB ******
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 50, y: 50, width: 150, height: 60)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
        
        
       
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        
        appDelegate.googleOrFacebookLogin = 1
        let loginManager = LoginManager()
        
        
        
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(grantedPermissions: let grantedPermissions , declinedPermissions: let declinedPermissions, token: let accessToken):
            
                print("Logged in!")
                
                self.goToNext()
            }
        }
    }
    // google
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print(user.profile.email)
        goToNext()
    }
    
    
    func goToNext() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NextViewController")
        navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
    }
    
    
}
