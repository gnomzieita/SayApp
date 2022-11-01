//
//  AdminViewController.swift
//  Meta Say
//
//  Created by Alex Agarkov on 26.02.2022.
//

import UIKit
import FirebaseFirestore

class AdminViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {

    @IBOutlet weak var Segmented: UISegmentedControl!
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docArra.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
       // cell.textLabel?.text = docArra[indexPath.row]

        switch self.Segmented.selectedSegmentIndex {
        case 0:
            let info = (docArra[indexPath.row] as! QueryDocumentSnapshot).data()
            cell.textLabel?.text = info["questions_text"] as? String ?? ""
        case 1:
            cell.textLabel?.text = docArra[indexPath.row] as? String ?? ""
        case 2:
            if let info = docArra[indexPath.row] as? [String:String] {
                cell.textLabel?.text = info["tagName"]
            }
        default:
            print("HZ")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.Segmented.selectedSegmentIndex {
        case 0:
            self.performSegue(withIdentifier: "addedit", sender: docArra[indexPath.row])
        case 1:
            self.performSegue(withIdentifier: "detal", sender: docArra[indexPath.row])
        case 2:
            print("Tagr")
            self.performSegue(withIdentifier: "qwt", sender: docArra[indexPath.row])
            //qwt
        default:
            print("HZ")
        }
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = docArra[indexPath.row]
        print("1")
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let collection = Firestore.firestore().collection("questions")
        
        if sourceIndexPath.row < destinationIndexPath.row {
            let sourceinfo = docArra[sourceIndexPath.row] as! QueryDocumentSnapshot
            var sourcequestions = sourceinfo.data()
            sourcequestions["id"] = (sourcequestions["id"] as? Int ?? 0) + (destinationIndexPath.row - sourceIndexPath.row)
            collection.document(sourceinfo.documentID).setData(sourcequestions)
            for index in sourceIndexPath.row+1 ... destinationIndexPath.row {
                let sourinf = docArra[index] as! QueryDocumentSnapshot
                var sourcequestions = sourinf.data()
                sourcequestions["id"] = (sourcequestions["id"] as? Int ?? 0) - 1
                collection.document(sourinf.documentID).setData(sourcequestions)
            }
            
        } else if sourceIndexPath.row > destinationIndexPath.row {
            let sourceinfo = docArra[sourceIndexPath.row] as! QueryDocumentSnapshot
            var sourcequestions = sourceinfo.data()
            sourcequestions["id"] = (sourcequestions["id"] as? Int ?? 0) - (sourceIndexPath.row - destinationIndexPath.row)
            collection.document(sourceinfo.documentID).setData(sourcequestions)
            for index in destinationIndexPath.row ... sourceIndexPath.row-1 {
                let sourceinfo = docArra[index] as! QueryDocumentSnapshot
                var sourcequestions = sourceinfo.data()
                sourcequestions["id"] = (sourcequestions["id"] as? Int ?? 0) + 1
                collection.document(sourceinfo.documentID).setData(sourcequestions)
            }
        }
        getInfo()
    }
    
    
    @IBOutlet weak var table: UITableView!
    var docArra:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.table.dragDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            getInfo()
    }

    
    @IBAction func selectType(_ sender: Any) {
        getInfo()
        if Segmented.selectedSegmentIndex == 0 {
            self.table.dragInteractionEnabled = true
        }
        else
        {
            self.table.dragInteractionEnabled = false
        }
        
        switch self.Segmented.selectedSegmentIndex {
        case 0:
            self.table.dragInteractionEnabled = true
            self.addButton.isHidden = false
        case 1:
            self.table.dragInteractionEnabled = false
            self.addButton.isHidden = true
        case 2:
            print("Tagr")
            self.table.dragInteractionEnabled = false
            self.addButton.isHidden = false
            //qwt
        default:
            print("HZ")
            self.table.dragInteractionEnabled = false
            self.addButton.isHidden = false
        }
    }
    @IBOutlet weak var addButton: DesignableButton!
    
    func getInfo() {
        
        switch Segmented.selectedSegmentIndex {
        case 0:
            Firestore.firestore().collection("questions").order(by: "id").getDocuments(){ (querySnapshot, err) in
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
        case 1:
            Firestore.firestore().collection("answers").getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.docArra.removeAll()
                    var tempArray:[String] = []
                    for document in querySnapshot!.documents {
                        let documentdata = document.data()
                        let userID = documentdata["userID"] as? String ?? ""
                        if !tempArray.contains(userID) {
                            self.docArra.append(userID)
                            tempArray.append(userID)
                        }
                    }
                    self.table.reloadData()
                }
            }
        case 2:
            Firestore.firestore().collection("Tags").getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.docArra.removeAll()
                    for document in querySnapshot!.documents {
                        self.docArra.append(document.data())
                    }
                    self.table.reloadData()
                }
            }
        default:
            print("HZ")
        }
    }
    
    @IBAction func add(_ sender: Any) {
        switch self.Segmented.selectedSegmentIndex {
        case 0:
            self.performSegue(withIdentifier: "addedit", sender: nil)
        case 1:
            print("HZ")
        case 2:
            print("Tagr")
            self.performSegue(withIdentifier: "addTag", sender: nil)
            //qwt
        default:
            print("HZ")
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detal" {
            let vc = segue.destination as! DetailViewController
            vc.userID = sender as! String
        }
        else if segue.identifier == "addedit" {
            if let addID = sender as? QueryDocumentSnapshot{
                let vc = segue.destination as! AddQViewController
                vc.documentID = addID.documentID
            }
        } else if segue.identifier == "qwt" {
            //QwTViewController
            let vc = segue.destination as! QwTViewController
            if let tagName = sender as? [String:String] {
                vc.tagName = tagName["tagName"] ?? ""
            }
        }
    }
}
