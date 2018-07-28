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
    @IBOutlet var imagePokemon: UIImageView!
    var data: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        if let data = self.data as? [String:Any]{
            
            if let name = data["name"] as? String {
                pokemonName.text = name
            }
            if let height = data["height"] as? Int {
                pokemonHeight.text = String(height)
            }
            if let weight = data["weight"] as? Int {
                pokemonWeight.text = String(weight)
            }
            if let types = data["types"] as? [[String:Any]] {
                var typeString = ""
                for (index, type) in types.enumerated(){
                    var t = type as? [String:Any]
                    var typeName = t!["type"] as? [String:Any]
                    typeString += "\(typeName!["name"]!)"
                    if(index < types.count - 1){
                        typeString += ", "
                    }
                    print(typeString)
                }
                pokemonTypes.text = typeString
                pokemonTypes.sizeToFit()
            }
            if let sprites = data["sprites"] as? [String:Any]
            {
                
                do{
                    let imageUrl = URL(string: sprites["front_default"] as! String)
                    let imageData = try Data(contentsOf: imageUrl!)
                    DispatchQueue.main.async {
                        self.imagePokemon.image = UIImage(data: imageData)
                        print(sprites["front_default"])
                    }
                } catch {
                    print(error)
                }
            }
            
            if let moves = data["moves"] as? [[String:Any]]{
                var moveList = ""
                for (index, move) in moves.enumerated() {
                    if let versionGroup = move["version_group_details"] as? [[String:Any]]
                    {
                        for version in versionGroup {
                            if let v = version["version_group"] as? [String:Any]{
                                if ((v["name"] as? String) == "sun-moon"){
                                    if let m = move["move"] as? [String:Any]{
                                        moveList += (m["name"] as? String)!
                                        if(index < moves.count){
                                            moveList += ", "
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                pokemonMoves.text = moveList
            }
        }
        
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
