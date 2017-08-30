//
//  Pokemon.swift
//  pokedex3
//
//  Created by John Yockey on 6/22/17.
//  Copyright © 2017 PracticeRuns. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    private var _description: String!
    private var _defense: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nxtEvolutionTxt: String!
    private var _nxtEvolutionName: String!
    private var _nxtEvolutionID: String!
    private var _nxtEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionTxt: String {
    
        if _nxtEvolutionTxt == nil {
            _nxtEvolutionTxt = ""
        }
        return _nxtEvolutionTxt
    }
    
    var nxtEvolutionName: String {
        
        if _nxtEvolutionName == nil {
            _nxtEvolutionName = ""
        }
        return _nxtEvolutionName
    }
    
    var nxtEvolutionID: String {
        
        if _nxtEvolutionID == nil {
            _nxtEvolutionID = ""
        }
        return _nxtEvolutionID
    }
    
    var nxtEvolutionLevel: String {
        
        if _nxtEvolutionLevel == nil {
            _nxtEvolutionLevel = ""
        }
        return _nxtEvolutionLevel
    }


    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }

    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }

    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
    }

    var type: String {
        
        if _type == nil {
            _type = ""
        }
        return _type
    }

    var defense: String {
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var description: String {
        
        if _description == nil {
            _description = ""
        }
        return _description
    }

    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }

                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    
                    for index in 1..<types.count {
                        
                        if let name = types[index]["name"] {
                            self._type! += "/\(name.capitalized)"
                        }
        
                    }
                } else {
                    self._type = ""
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0 {
                    
                    if let url = descriptions[0]["resource_uri"] {
                        
                         let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "pokemon")
                                    
                                    self._description = newDescription
                                    print(description)
                                }
                                
                            }
                            completed()
                        })
                            
                    }
                   
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nxtEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nxtEvolutionID = nextEvoId
                            }
                            
                            if let lvlExist = evolutions[0]["level"] {
                                
                                if let lvl = lvlExist as? Int {
                                    
                                    self._nxtEvolutionLevel = "\(lvl)"
                                    
                                } else {
                                    
                                     self._nxtEvolutionLevel = ""
                                }
                                
                            }
                            
                        }
                        
                    }
                    print(self.nxtEvolutionID)
                    print(self.nxtEvolutionName)
                    print(self.nxtEvolutionLevel)
 
                }
            

            completed()
            
            }
        
        }
        
    }
    
}
