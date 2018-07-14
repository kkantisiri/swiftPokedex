//
//  ViewController.swift
//  pokedex
//
//  Created by UCode on 7/14/18.
//  Copyright © 2018 UCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var pokemonImage:UIImageView!
    @IBOutlet var searchBar:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchPokemon(){
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/" + searchBar.text!)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else{
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String:Any]{
               // print("\(responseJSON) is a cool pokemon")
                if let species = responseJSON["species"] as? [String:Any] {
                    print(species["name"])
                    
                }
                if let sprites = responseJSON["sprites"] as? [String:Any]
                {
                    
                    do{
                        let imageUrl = URL(string: sprites["front_default"] as! String)
                        let imageData = try Data(contentsOf: imageUrl!)
                        DispatchQueue.main.async {
                            self.pokemonImage.image = UIImage(data: imageData)
                            print(sprites["front_default"])
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            
            
            
        }
        task.resume()
        
        
    }
}

