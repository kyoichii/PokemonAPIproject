//
//  ContentView.swift
//  PokemonAPIproject
//
//  Created by 田野恭一 on 2022/05/19.
//

import SwiftUI

//MARK: ポケモン図鑑の表紙View
struct ContentView: View {
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""
    
    var body: some View{
        NavigationView{
            List {
                ForEach(searchText == "" ? pokemon: pokemon.filter( {$0.name.contains(searchText.lowercased())} )) {
                    entry in
                    
                    HStack {
                        Pokemonimage(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        
                        NavigationLink("\(entry.name)".capitalized, destination: Pokemondetailview(polekemonname: "\(entry.name)", imageLink: "\(entry.url)"))
                    }
                }
                
            }
            .onAppear{
                Pokeapi().getData(){ pokemon in
                    self.pokemon = pokemon
                }
                
            }
            .searchable(text: $searchText)
            .navigationTitle("ポケモン図鑑")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
