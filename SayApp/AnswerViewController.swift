//
//  AnswerViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 09.02.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AnswerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let user:User = Auth.auth().currentUser!
    @IBOutlet weak var titleLabel: UILabel!
    var selectedCell = 6
    var s = ["0","1","2-3","4-5","7"]
    var questionID:Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return s.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "AnswerTableViewCell") as! AnswerTableViewCell
        cell.Selected(indexPath.row == selectedCell)
        cell.ansewerLabel.text = s[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Firestore.firestore().collection("answers").whereField("userID", isEqualTo: user.uid).getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.getData(querySnapshot!.documents.count)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func getData(_ q_id: Int) {
        Firestore.firestore().collection("questions").whereField("id", isEqualTo: q_id).getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count == 0 {
                    self.navigationController?.popViewController(animated: true)
                }
                else
                {
                    for document in querySnapshot!.documents {
                        let documentdata = document.data()
                        print("\(document.documentID) => \(documentdata)")
                        self.s.removeAll()
                        self.s = documentdata["questions_answers"] as! [String]
                        self.titleLabel.text = documentdata["questions_text"] as? String
                        self.questionID = documentdata["id"] as! Int
                        self.table.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        
        let question = ["userID":user.uid,
                        "questionID":questionID,
                        "question":self.titleLabel.text ?? "",
                        "answer":self.s[selectedCell]] as [String : Any]
        
        Firestore.firestore().collection("answers").addDocument(data: question) { err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.selectedCell = 6
                self.questionID = self.questionID + 1
                self.getData(self.questionID)
            }
        }
        
        //table.reloadData()
    }
    
    @IBAction func next(_ sender: Any) {
        
        let question = ["userID":user.uid,
                        "questionID":questionID,
                        "question":self.titleLabel.text ?? "",
                        "answer":self.s[selectedCell]] as [String : Any]
        
        Firestore.firestore().collection("answers").addDocument(data: question) { err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.selectedCell = 6
                self.questionID = self.questionID + 1
                self.getData(self.questionID)
            }
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
