//
//  Pokemonimage.swift
//  PokemonAPIproject
//
//  Created by 田野恭一 on 2022/05/24.
//

import SwiftUI

//MARK: ポケモンのサムネ画像を読み込ませるView
struct Pokemonimage: View {
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        //非同期で画像の読み込み
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 75, height: 75)
            .onAppear{
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                
                if loadedData == nil {
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                } else {
                    getSprite(url: loadedData!)
                }
            }
            .clipShape(Circle())
            .foregroundColor(Color.gray.opacity(0.60))
            .scaledToFit()
    }
    
    func getSprite(url: String) {
        var tempSprite: String?
        PokemonSelectedsamapi().getData(url: url){ sprite in
            tempSprite = sprite.front_default
            self.pokemonSprite = tempSprite ?? "placeholder"
        }
        
    }

}

struct Pokemonimage_Previews: PreviewProvider {
    static var previews: some View {
        Pokemonimage()
    }
}
