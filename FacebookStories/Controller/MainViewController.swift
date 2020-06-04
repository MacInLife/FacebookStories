//
//  MainViewController.swift
//  FacebookStories
//
//  Created by Marie-Ange Coco on 01/06/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var credentialsCollection: [Credentials] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentialsCollection.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "credentialsCell", for: indexPath)
        cell.textLabel?.text = credentialsCollection[indexPath.row].title
        return cell
    }
}

