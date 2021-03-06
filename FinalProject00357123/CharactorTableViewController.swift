//
//  CharactorTableViewController.swift
//  FinalProject00357123
//
//  Created by 張宇帆 on 2018/1/10.
//  Copyright © 2018年 NTOU department of computer science. All rights reserved.
//

import UIKit

class CharactorTableViewController: UITableViewController, UINavigationControllerDelegate  {

    var myCharactors = [Charactor]()
    
    var isAdd = false
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        myCharactors.remove(at: indexPath.row)
        Charactor.saveToFile(lovers: myCharactors)
        tableView.reloadData()
        
    }
    
    @IBAction func goBackToCharactorsTableViewController(segue: UIStoryboardSegue) {
        if let controller = segue.source as? CharactorEditorViewController {
            if controller.shouldAdd{
                myCharactors.append(controller.charactor_data)
            }else{
                myCharactors[controller.setindex] = controller.charactor_data
            }
            
            Charactor.saveToFile(lovers: myCharactors)
            tableView.reloadData()
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let row = tableView.indexPathForSelectedRow?.row {
            let myCharactorData = myCharactors[row]
            let controller = segue.destination as? CharactorEditorViewController
            controller?.shouldAdd = false
            controller?.setindex = row
            controller?.charactor_data = myCharactorData
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let lmyCharactors = Charactor.readFromFile() {
            self.myCharactors = lmyCharactors
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCharactors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharactorCell", for: indexPath) as? CharactorTableViewCell else  {
            assert(false)
        }
        
        // Configure the cell...
        let myCharactor = myCharactors[indexPath.row]
        cell.MyCharactorNames.text = myCharactor.name
        cell.MyModelNames.text = myCharactor.orgName
        cell.MyImages.image = myCharactor.image
        cell.MyModelImages.image = ModelChooseCell.getImage(myCharactor.modelName ?? "")
        cell.MyModelNames.text = ModelChooseCell.getDesName(myCharactor.modelName ?? "")
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
