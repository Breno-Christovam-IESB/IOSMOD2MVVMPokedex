//
//  ViewModel.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

import Foundation
import SwiftUI

// ViewModel que gerencia o estado da aplicação relacionado aos Pokémons
class ViewModel: ObservableObject {
    // Instância de PokemonManager para obter dados dos Pokémons
    private let pokemonManager = PokemonManager()

    // Array publicado para armazenar a lista de Pokémons
    @Published var pokemonList = [Pokemon]()
    
    // Detalhes do Pokémon atualmente selecionado
    @Published var pokemonDetails: DetailPokemon?
    
    // Texto usado para filtrar os Pokémons na lista
    @Published var searchText = ""
    
    // Array publicado para armazenar os Pokémons favoritos
    @Published var favorites: [Pokemon] = []

    // Array filtrado com base no texto de pesquisa
    var filteredPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    // Inicialização do ViewModel
    init() {
        // Obtém a lista de Pokémons usando o PokemonManager
        self.pokemonList = pokemonManager.getPokemon()
    }
    
    // Adiciona ou remove um Pokémon dos favoritos
    func toggleFavorite(pokemon: Pokemon) {
        if favorites.contains(pokemon) {
            favorites.removeAll(where: { $0 == pokemon })
        } else {
            favorites.append(pokemon)
        }
    }

    // Obtém o índice de um Pokémon na lista
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }

    // Obtém detalhes do Pokémon, incluindo altura e peso
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        
        // Define detalhes inicialmente como valores padrão
        self.pokemonDetails = DetailPokemon(id: 0, height: 0, weight: 0)
        
        // Obtém detalhes reais do Pokémon usando o PokemonManager
        pokemonManager.getDetailedPokemon(id: id) { data in
            // Atualiza os detalhes do Pokémon na fila principal
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }

    // Formata o valor de altura e peso para exibição
    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)
        
        return string
    }
}

