//
//  AddTagViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 06.03.2022.
//

import UIKit
import FirebaseFirestore

class AddTagViewController: UIViewController {

    @IBOutlet weak var tagNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTag(_ sender: Any) {
        let collection = Firestore.firestore().collection("Tags")
        if self.tagNameField.text?.count ?? 0 > 0 {
            let tagInfo = ["tagName":self.tagNameField.text ?? ""] as [String : Any]
            collection.addDocument(data: tagInfo)
            
            self.navigationController?.popViewController(animated: true)
        }
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
