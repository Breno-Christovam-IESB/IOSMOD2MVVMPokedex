//
//  PokemonModel.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

import Foundation

// Estrutura que representa uma página de Pokémon retornada pela API
struct PokemonPage: Codable {
    let count: Int          // Número total de Pokémons disponíveis
    let next: String        // URL para a próxima página de Pokémons (se houver)
    let results: [Pokemon]  // Lista de Pokémons nesta página
}

// Estrutura que representa um Pokémon individual
struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()         // Identificador exclusivo para o Pokémon
    let name: String        // Nome do Pokémon
    let url: String         // URL da API para obter mais detalhes do Pokémon
    
    // Pokémon de exemplo usado para pré-visualizações e testes
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

// Estrutura que representa detalhes específicos de um Pokémon
struct DetailPokemon: Codable {
    let id: Int             // ID único do Pokémon
    let height: Int         // Altura do Pokémon
    let weight: Int         // Peso do Pokémon
}

