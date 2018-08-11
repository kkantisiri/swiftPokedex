//
//  DetailsViewController.swift
//  pokedex
//
//  Created by UCode on 7/21/18.
//  Copyright © 2018 UCode. All rights reserved.
//

import Foundation
import UIKit

//TODO:
//-custom table cells are broken
//-API request for move data (type, PP, etc.)

class DetailsViewController: UIViewController {
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonHeight: UILabel!
    @IBOutlet var pokemonWeight: UILabel!
    @IBOutlet var pokemonTypes: UILabel!
    @IBOutlet var pokemonMoves: UILabel!
    @IBOutlet var imagePokemon: UIImageView!
    @IBOutlet var pokemonMove1: UILabel!
    @IBOutlet var pokemonMove2: UILabel!
    @IBOutlet var pokemonMove3: UILabel!
    @IBOutlet var pokemonMove4: UILabel!
    @IBOutlet var pokemonChain: UILabel!
    @IBOutlet weak var collectionView:UICollectionView!
    
    var responseJSON:Any?
    
    var moveList:[[String:Any]] = []
    var data: Any?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width/2, height: self.collectionView.bounds.height/2)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
        
        collectionView.register(PokemonMoveCell.self, forCellWithReuseIdentifier: "pokemonMove")
        
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
                for (index, move) in moves.enumerated() {
                    if let versionGroup = move["version_group_details"] as? [[String:Any]]
                    {
                        for version in versionGroup {
                            if let v = version["version_group"] as? [String:Any]{
                                if let m = move["move"] as? [String:Any]{
                                    moveList.append(m);
                                }
                                // if ((v["name"] as? String) == "sun-moon"){
//                                    if let m = move["move"] as? [String:Any]{
//                                        switch(index){
//                                            case 1:
//                                                print(m["name"])
//                                                pokemonMove1.text = m["name"] as? String;
//                                                pokemonMove1.sizeToFit()
//                                                break;
//                                            case 2:
//                                                pokemonMove2.text = m["name"] as? String;
//                                                pokemonMove2.sizeToFit()
//                                                break;
//                                            case 3:
//                                                pokemonMove3.text = m["name"] as? String;
//                                                pokemonMove3.sizeToFit()
//                                                break;
//                                            case 4:
//                                                pokemonMove4.text = m["name"] as? String;
//                                                pokemonMove4.sizeToFit()
//                                                break;
//                                            default:
//                                                break;
//                                        }
//                                    }
                                }
                            }
                        }
                    }
            }
            if let species = data["species"] as? [[String:Any]] {
                
            }

        }
        
//            if let move1 = data["moves"] as? [[String:Any]] {
//
//            }
        }
    
    func makeRequest(_ requestURL:String){
            //
        let url = URL(string: requestURL)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else{
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            self.responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    


extension DetailsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonMove", for: indexPath) as! PokemonMoveCell
        print(moveList[0])
//        cell.pokemonMove.text = String(describing: moveList[0]["name"]!)
//        cell.pokemonMovePP.text = String(describing: moveList[0]["pp"])
//        let type = moveList[indexPath.row + 1]["type"] as? [String:Any]
//        cell.pokemonMoveType.text = String(describing: type!["name"])
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}

