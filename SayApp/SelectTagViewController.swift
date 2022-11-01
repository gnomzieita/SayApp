//
//  SelectTagViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 05.03.2022.
//

import UIKit
import FirebaseFirestore

class SelectTagViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var delegate: AddQViewControllerProtocol?
    
    @IBOutlet weak var table: UITableView!
    var docArra:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Firestore.firestore().collection("Tags").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.docArra.removeAll()
                for document in querySnapshot!.documents {
                    let documentdata = document.data()
                    self.docArra.append(documentdata["tagName"] as? String ?? "")
                }
                self.table.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.docArra.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
            cell.textLabel?.text = docArra[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //docArra[indexPath.row]
        self.delegate?.setTagName(docArra[indexPath.row])
        self.dismiss(animated: true, completion: nil)
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
