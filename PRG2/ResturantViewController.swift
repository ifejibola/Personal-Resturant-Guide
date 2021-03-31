//
//  ResturantViewController.swift
//  PRG2
//
//  Created by Ife Ajibola on 2021-03-30.
//

import UIKit
import CoreData

class ResturantViewController: UITableViewController {
    
    var Resturant:[NSManagedObject] = []

    @IBAction func AddResturant(_ sender: Any) {
        let alert = UIAlertController(title: "New Resturant", message: "Add your lastest vist", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "save", style: .default){
            [unowned self] action in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else{return}
            
            self.save(name: nameToSave, dob: Date())
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    func save(name:String, dob:Date){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "Resturant", in: context){
            let resturant = NSManagedObject(entity: entity, insertInto: context)
            
            resturant.setValue(name, forKeyPath: "name")
            resturant.setValue(dob, forKeyPath: "dob")

            do{
                try context.save()
                Resturant.append(resturant)
            }catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Resturant")
        
        do{
            try Resturant = try context.fetch(request)
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.Resturant.count
    }

    //Uncomment and change identifier to Cell in code and Storyboard
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let user = Resturant[indexPath.row]
        cell.textLabel?.text = (user.value(forKeyPath: "name") as! String)

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
