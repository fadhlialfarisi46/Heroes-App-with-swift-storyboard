//
//  HeroManager.swift
//  Heroes App with Storyboard
//
//  Created by muhammad.alfarisi on 24/04/23.
//

import Foundation

protocol HeroManagerDelegate {
    func didSuccess(_ heroManager: HeroManager, heroes: [HeroData])
    func didFail(error: Error)
}

struct HeroManager {
    let apiUrl = "https://my-json-server.typicode.com/fadhlialfarisi46/free-api-hero/pahlawan"
    
    var delegate: HeroManagerDelegate?
    
    func fetchHeroes() {
        if let url = URL(string: apiUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFail(error: error!)
                    return
                }
                if let safeData = data {
                    if let heroes = self.parseJSON(safeData) {
                        self.delegate?.didSuccess(self, heroes: heroes)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON (_ heroData: Data) -> [HeroData]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([HeroData].self, from: heroData)
            return decodeData
        } catch {
            print("error at heromanager \(error) ")

            delegate?.didFail(error: error)
            return nil
        }
        
    }
    
}
