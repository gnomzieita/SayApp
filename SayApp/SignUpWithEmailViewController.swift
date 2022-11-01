//
//  SignUpWithEmailViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 06.02.2022.
//

import UIKit

class SignUpWithEmailViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func next(_ sender: Any) {
        if email.text == confirmEmail.text {
            self.performSegue(withIdentifier: "Next", sender: email.text)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! SetYourPasswordViewController
        vc.email = sender as! String
        
    }
    

}
