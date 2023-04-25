//
//  DetailViewController.swift
//  Heroes App with Storyboard
//
//  Created by muhammad.alfarisi on 25/04/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroTitle: UILabel!
    @IBOutlet weak var heroDesc: UILabel!
    
    var selectedHero: HeroData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: self!.selectedHero!.imageAsset)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.heroImage.image = image
                    }
                }
            }
        }
        heroTitle.text = selectedHero?.name
        heroDesc.text = selectedHero?.deskripsi
        heroDesc.lineBreakMode = .byTruncatingTail
        heroDesc.numberOfLines = 0
    }
    
    @IBAction func goToWikipediaPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToWiki", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WikipediaViewController
        destinationVC.url = selectedHero?.urlWiki
    }
}
