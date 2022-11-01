//
//  SetYourPasswordViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 06.02.2022.
//

import UIKit
import FirebaseAuth

class SetYourPasswordViewController: UIViewController {

    var email:String = ""
    
    private var password: String { passTextField.text! }
    
    @IBOutlet weak var passTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showPass(_ sender: Any) {
        passTextField.isSecureTextEntry = !passTextField.isSecureTextEntry
    }
    
    
    @IBAction func register(_ sender: Any) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          guard error == nil else { return self.displayError(error) }
            self.navigationController?.isNavigationBarHidden = true
            self.performSegue(withIdentifier: "next", sender: nil)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
