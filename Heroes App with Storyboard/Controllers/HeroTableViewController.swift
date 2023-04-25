//
//  HeroTableViewController.swift
//  Heroes App with Storyboard
//
//  Created by muhammad.alfarisi on 24/04/23.
//

import UIKit

class HeroTableViewController: UITableViewController {
    
    var heroManager = HeroManager()
    
    var heroes: [HeroData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        heroManager.delegate = self
        heroManager.fetchHeroes()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroTableViewCell
         let hero = heroes[indexPath.row]
         cell.HeroTitle.text = hero.name
         DispatchQueue.global().async { [weak self] in
             if let data = try? Data(contentsOf: URL(string: hero.imageAsset)!) {
                 if let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                         cell.heroImage.layer.cornerRadius = cell.heroImage.frame.size.width / 2
                         cell.heroImage.image = image
                     }
                 }
             }
         }
         print(heroes)
         
         return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedHero = heroes[indexPath.row]
        }
    }
    
}

extension HeroTableViewController: HeroManagerDelegate {
    func didSuccess(_ heroManager: HeroManager, heroes: [HeroData]) {
        self.heroes = heroes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFail(error: Error) {
        print("error at viewcontroller \(error)")
    }
}
