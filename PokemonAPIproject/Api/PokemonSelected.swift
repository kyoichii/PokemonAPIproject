//
//  PokemonSelected.swift
//  PokemonAPIproject
//
//  Created by 田野恭一 on 2022/05/24.
//

import Foundation

//MARK: ポケモンの詳細画像を取得してくるAPI
struct PokemonSelected: Codable{
    var sprites: PokemonSprites
    var weight: Int
}

struct PokemonSprites: Codable{
    var other: Pokemondetailimage
}

struct Pokemondetailimage: Codable{
    var officialartwork: Pokemonimageurl

    enum CodingKeys : String, CodingKey {
            case officialartwork = "official-artwork"
        }
}

struct Pokemonimageurl: Codable{
    var front_default: String

}

//ポケモン図鑑詳細情報のポケモン画像
class PokemonSelectedApi{
    func getData(url: String, completion: @escaping((PokemonSprites) -> ())){
        //どれだけのポケモンをサーチするかの設定
        guard let url = URL(string: url)else{ return }
        
        //JSONデコード
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else{ return }
            
            let pokemonSprite = try! JSONDecoder().decode(PokemonSelected.self, from: data)
            
            //非同期処理
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)
            }
            
        }.resume()
    }
}
