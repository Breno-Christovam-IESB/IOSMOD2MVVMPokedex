//
//  PokemonManager.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

import Foundation

// Gerenciador de Pokémons responsável por obter dados relacionados aos Pokémons
class PokemonManager {
    
    // Obtém a lista de Pokémons a partir de um arquivo JSON local
    func getPokemon() -> [Pokemon] {
        // Decodifica os dados do arquivo JSON "pokemon.json" usando a extensão de Bundle
        let data: PokemonPage = Bundle.main.decode(file: "pokemon.json")
        // Obtém a lista de Pokémons da estrutura PokemonPage
        let pokemon: [Pokemon] = data.results
        
        return pokemon
    }
    
    // Obtém detalhes específicos de um Pokémon com base no ID
    func getDetailedPokemon(id: Int, _ completion: @escaping (DetailPokemon) -> ()) {
        // Realiza uma solicitação de rede para obter detalhes do Pokémon usando a extensão de Bundle
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon.self) { data in
            // Chama a cláusula de conclusão passando os detalhes do Pokémon
            completion(data)
            // Imprime os detalhes do Pokémon (para fins de depuração)
            print(data)
        } failure: { error in
            // Manipula falhas na solicitação de rede, imprimindo o erro (para fins de depuração)
            print(error)
        }
    }
}

