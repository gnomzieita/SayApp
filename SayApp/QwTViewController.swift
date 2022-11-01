//
//  QwTViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 06.03.2022.
//

import UIKit
import FirebaseFirestore

class QwTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var docArra:[Any] = []
    var tagName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getInfo()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docArra.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
       // cell.textLabel?.text = docArra[indexPath.row]

        let info = (docArra[indexPath.row] as! QueryDocumentSnapshot).data()
        cell.textLabel?.text = info["questions_text"] as? String ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "addedit", sender: docArra[indexPath.row])
    }

    //.whereField("tag", isEqualTo: "CA")
    func getInfo() {
        
        Firestore.firestore().collection("questions").whereField("tag", isEqualTo: tagName).getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.docArra.removeAll()
                for document in querySnapshot!.documents {
                    self.docArra.append(document)
                }
                self.table.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addedit" {
            if let addID = sender as? QueryDocumentSnapshot{
                let vc = segue.destination as! AddQViewController
                vc.documentID = addID.documentID
            }
        } 
    }
    

}
