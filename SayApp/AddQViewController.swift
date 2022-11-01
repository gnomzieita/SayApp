//
//  AddQViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 26.02.2022.
//

import UIKit
import FirebaseFirestore

public protocol AddQViewControllerProtocol: NSObjectProtocol {
    func setTagName(_ tName:String)
}

class AddQViewController: UIViewController, AddQViewControllerProtocol {
    
    
    func setTagName(_ tName: String) {
        self.tagName = tName
        self.tagField.text = tName
    }
    

    @IBOutlet weak var qTitle: UITextField!
    @IBOutlet weak var q1: UITextField!
    @IBOutlet weak var q2: UITextField!
    @IBOutlet weak var q3: UITextField!
    @IBOutlet weak var q4: UITextField!
    @IBOutlet weak var q5: UITextField!
    @IBOutlet weak var tagField: UITextField!
    
    var tagName:String = ""
    var docID:Int = 0
    
    var documentID:String = ""
    var document:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if documentID.count > 0 {
            print(documentID)
            Firestore.firestore().collection("questions").document(documentID).getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    self.qTitle.text = dataDescription?["questions_text"] as? String ?? ""
                    
                    if let questions_answers = dataDescription?["questions_answers"] as? [String?] {
                        let qArray:[UITextField] = [self.q1, self.q2, self.q3, self.q4, self.q5]
                        
                        for (index, element) in questions_answers.enumerated() {
                            qArray[index].text = element
                        }
                    }
                    
                    self.tagField.text = dataDescription?["tag"] as? String ?? ""
                    self.docID = dataDescription?["id"] as? Int ?? 0
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    @IBAction func addTap(_ sender: Any) {

        let collection = Firestore.firestore().collection("questions")
        if documentID.count > 0 {
            var questions_answers:[String] = []
            if let text = self.q1.text , text.count > 0 {
                questions_answers.append(text)
                if let text = self.q2.text , text.count > 0 {
                    questions_answers.append(text)
                    if let text = self.q3.text , text.count > 0 {
                        questions_answers.append(text)
                        if let text = self.q4.text , text.count > 0 {
                            questions_answers.append(text)
                            if let text = self.q5.text , text.count > 0 {
                                questions_answers.append(text)
                            }
                        }
                    }
                }
            }
            if questions_answers.count >= 2, (self.qTitle.text?.count ?? 0) > 0 {
                let questions = ["id":self.docID,
                                 "tag":self.tagName,
                                 "questions_text": self.qTitle.text as Any,
                                 "questions_answers": questions_answers] as [String : Any]

                collection.document(documentID).setData(questions)
                
                self.navigationController?.popViewController(animated: true)
            }
            
        } else {
            collection.getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                
                var questions_answers:[String] = []
                if let text = self.q1.text , text.count > 0 {
                    questions_answers.append(text)
                    if let text = self.q2.text , text.count > 0 {
                        questions_answers.append(text)
                        if let text = self.q3.text , text.count > 0 {
                            questions_answers.append(text)
                            if let text = self.q4.text , text.count > 0 {
                                questions_answers.append(text)
                                if let text = self.q5.text , text.count > 0 {
                                    questions_answers.append(text)
                                }
                            }
                        }
                    }
                }
                if questions_answers.count >= 2, (self.qTitle.text?.count ?? 0) > 0 {
                    let questions = ["id":querySnapshot!.documents.count,
                                     "tag":self.tagName,
                                     "questions_text": self.qTitle.text as Any,
                                     "questions_answers": questions_answers] as [String : Any]

                    collection.addDocument(data: questions as [String : Any])
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        }
    }
    
    @IBAction func selectTag(_ sender: Any) {
        self.performSegue(withIdentifier: "selectTag", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectTag" {
            let vc = segue.destination as! SelectTagViewController
            vc.delegate = self
        }
    }
    

}
