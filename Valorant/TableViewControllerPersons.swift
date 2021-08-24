//
//  TableTableViewController.swift
//  Valorant
//
//  Created by daniel on 05/04/2021.
//

import UIKit

class TableViewControllerPersons: UITableViewController {
    
    var connection = Connection()
    let spanishLanguage = "language=es-ES"
    var persons: [Person] = []
    let MAX_IMAGE_DATA = 15
    var imageDonwlodaded = 0
    var loading = Loading()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        title = "Personajes Valorant"
        connectionGetListAndImage()
        if imageDonwlodaded < MAX_IMAGE_DATA {
            self.loading.setupLoadingViews(controller: self)
            self.loading.showLoading(controller: self)
            self.tableView.separatorStyle = .none
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentCell", for: indexPath) as! MyTableViewCellPersons
        
        // Configure the cell...
        cell.displayNameLabel.text = persons[indexPath.row].displayName
        cell.imageViewCell.image = persons[indexPath.row].image
        cell.displayNameLabel.textColor = UIColor(named: "TextColor")
        cell.backgroundColor = UIColor(named: "CellBackground")
        cell.layer.borderColor = UIColor(named: "TextColor")?.cgColor
        cell.layer.borderWidth = 4.0

        return cell
    }
    
    func connectionGetListAndImage() {
        
        connection.getPersons(language: spanishLanguage) { [self] (persons) in
            if let persons = persons {
                self.persons = persons.data!
                print("Count \(self.persons.count)")
                // Borramos la posición 5 del array que viene repetida desde la API
                self.persons.remove(at: 5)
                self.persons = self.persons.sorted { $0.displayName! < $1.displayName! }
                for person in self.persons  {
                    connection.getImage(urlString: person.displayIcon!) {[self] (image) in
                        if let image = image {
                            person.image = image
                            imageDonwlodaded += 1
                            print(imageDonwlodaded)
                        }
                        if imageDonwlodaded >= MAX_IMAGE_DATA {
                            DispatchQueue.main.async {
                                self.loading.hideLoading()
                                tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        if let detailVLC = segue.destination as? DetailViewController {
            detailVLC.agent = self.persons[indexPath!]
        }
     }
     
    
}
