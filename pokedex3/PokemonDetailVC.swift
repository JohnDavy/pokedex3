//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by John Yockey on 7/25/17.
//  Copyright © 2017 PracticeRuns. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var pokeType: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var defenseLbl: UILabel!
    
    @IBOutlet weak var pokedexLbl: UILabel!
    
    @IBOutlet weak var baseAttackLbl: UILabel!
    
    @IBOutlet weak var evolutionLbl: UILabel!
    
    @IBOutlet weak var leftBottomImage: UIImageView!
    
    @IBOutlet weak var rightBottomImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            nameLabel.text = pokemon.name
        
            pokemon.downloadPokemonDetails() {
                
            // Only called after network call is complete
            print("Arrived Here")
            self.mainImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
            self.leftBottomImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
                
            self.updateUI()
                
            // RESET
            //self.pokemon.nxtEvolutionID = ""
            //self.reloadInputViews()
        }
    }
    
    func updateUI() {
        
        
        descriptionLbl.text = pokemon.description
        pokeType.text = pokemon.type
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        defenseLbl.text = pokemon.defense
        pokedexLbl.text = "\(pokemon.pokedexId)"
        baseAttackLbl.text = pokemon.attack
        
        // if something with evolution label
        if pokemon.nxtEvolutionID == "" {
            evolutionLbl.text = "No Further Evolutions"
            rightBottomImage.isHidden = true
            
        } else  {
            evolutionLbl.text = "Next Evolution: \(pokemon.nxtEvolutionName) lvl \(pokemon.nxtEvolutionLevel)"
            self.rightBottomImage.image = UIImage(named: "\(self.pokemon.nxtEvolutionID)")
        }
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}
