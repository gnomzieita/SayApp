//
//  DetailViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 28.02.2022.
//

import UIKit
import FirebaseFirestore

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var answerArray:[[String:Any]] = []
    var userID:String = ""
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "detailTableViewCell") as! detailTableViewCell
            //cell.textLabel?.text = answerArray[indexPath.row]
        cell.setData(answerArray[indexPath.row])
        
        return cell
    }
    

    func getData() {
        Firestore.firestore().collection("answers").whereField("userID", isEqualTo: userID).getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.answerArray.removeAll()
                for document in querySnapshot!.documents {
                    let documentdata = document.data()
                    print("\(document.documentID) => \(documentdata)")
                    
                    self.answerArray.append(documentdata)
                }
                
                self.table.reloadData()
            }
        }
    }
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.title = userID
        // Do any additional setup after loading the view.
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
