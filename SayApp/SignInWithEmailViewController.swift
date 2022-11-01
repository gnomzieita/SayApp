//
//  SignInWithEmailViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 26.02.2022.
//

import UIKit
import FirebaseAuth

class SignInWithEmailViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private var email: String { emailField.text! }
    private var password: String { passwordField.text! }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInTap(_ sender: Any) {
        if email == "admin@gmail.com" && password == "admin" {
            self.performSegue(withIdentifier: "admin", sender: nil)
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
              guard error == nil else { return self.displayError(error) }

                self.performSegue(withIdentifier: "LoginOK", sender: result)
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if let userInfo = sender as? AuthDataResult {
//
//        }
    }

}
