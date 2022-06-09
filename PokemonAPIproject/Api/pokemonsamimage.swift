//
//  pokemonsamimage.swift
//  PokemonAPIproject
//
//  Created by 田野恭一 on 2022/05/24.
//

import Foundation

//MARK: ポケモンのサムネ画像を取得してくるAPI
struct Pokemonimg: Codable{
    var sprites: Pokemonsamimg
    var weight: Int
}

struct Pokemonsamimg: Codable{
    var front_default: String
}

class PokemonSelectedsamapi{
    func getData(url: String, completion: @escaping((Pokemonsamimg) -> ())){
        //どれだけのポケモンをサーチするかの設定
        guard let url = URL(string: url)else{ return }
        
        //JSONデコード
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else{ return }
            
            let pokemonSprite = try! JSONDecoder().decode(Pokemonimg.self, from: data)
            
            //非同期処理
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)
            }
            
        }.resume()
    }
}

