//
//  DetailsViewController.swift
//  pokedex
//
//  Created by UCode on 7/21/18.
//  Copyright © 2018 UCode. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonHeight: UILabel!
    @IBOutlet var pokemonWeight: UILabel!
    @IBOutlet var pokemonTypes: UILabel!
    @IBOutlet var pokemonMoves: UILabel!
    var data: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let data = self.data as? [String:Any]{
            
            if let name = data["name"] as? String {
                pokemonName.text = name
            }
            if let height = data["height"] as? String {
                pokemonHeight.text = height
            }
            if let weight = data["weight"] as? String {
                pokemonWeight.text = weight
            }
        }
        
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
