//
//  Pokemondetailview.swift
//  PokemonAPIproject
//
//  Created by 田野恭一 on 2022/05/24.
//

import SwiftUI

//MARK: ポケモンの詳細情報を表示するView
struct Pokemondetailview: View {
    @State var polekemonname:String
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        VStack{
            //非同期で画像の読み込み
            AsyncImage(url: URL(string: pokemonSprite))
                .frame(width: 350, height: 350)
                .onAppear{
                    let loadedData = UserDefaults.standard.string(forKey: imageLink)
                    
                    if loadedData == nil {
                        getSprite(url: imageLink)
                        UserDefaults.standard.set(imageLink, forKey: imageLink)
                    } else {
                        getSprite(url: loadedData!)
                    }
                }
                .padding()
                .foregroundColor(Color.gray.opacity(0.60))
                .scaledToFit()
            Spacer().frame(height: 75)
            Text(polekemonname)
                .padding()
                .font(.system(size: 27))
        }
    }
    
    func getSprite(url: String) {
        var tempSprite: String?
        PokemonSelectedApi().getData(url: url){ sprite in
            tempSprite = sprite.other.officialartwork.front_default
            self.pokemonSprite = tempSprite ?? "placeholder"
            print("kkkkk" + self.pokemonSprite)
        }
        
    }
}

struct Pokemondetailview_Previews: PreviewProvider {
    static var previews: some View {
        Pokemondetailview(polekemonname: "ポケモンの名前", imageLink: "ポケモンのurl")
    }
}
