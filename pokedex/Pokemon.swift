//
//  Pokemon.swift
//  pokedex
//
//  Created by UCode on 7/14/18.
//  Copyright © 2018 UCode. All rights reserved.
//

import Foundation

class Pokemon{
    var name: String = "";
    var types: String;
    var height: Int;
    var moves: String;
    
    init(n:String, t:String, h:Int, m:String) {
        name = n;
        types = t;
        height = h;
        moves = m;
    }
}
