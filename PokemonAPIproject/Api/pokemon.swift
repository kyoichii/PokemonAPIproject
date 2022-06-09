//
//  pokemon.swift
//  PokemonAPIproject
//
//  Created by 田野恭一 on 2022/05/19.
//
//https://pokeapi.co/api/v2/pokemon?limit=898

import Foundation

//MARK: 前ポケモンの情報を取得してくるAPI
struct Pokemon: Codable{
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable{
    let id = UUID()
    var name: String
    var url: String
}

class Pokeapi{
    func getData(completion: @escaping([PokemonEntry]) -> ()){
        //どれだけのポケモンをサーチするかの設定
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=898")else{
            return
        }
        
        //JSONデコード
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else{ return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            //非同期処理
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
            
        }.resume()
    }
}


