//
//  PokemonDetailView.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

import Foundation
import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: Pokemon

    var body: some View {
        // Um contêiner de visualização vertical principal
        VStack {
            // Incorpora a visualização PokemonView para exibir a imagem e o nome do Pokémon
            PokemonView(pokemon: pokemon)

            // Contêiner vertical secundário com informações detalhadas sobre o Pokémon
            VStack(spacing: 10) {
                // Exibe o ID do Pokémon obtido do ViewModel (vm.pokemonDetails)
                Text("**ID**: \(vm.pokemonDetails?.id ?? 0)")
                // Exibe o peso do Pokémon formatado em KG
                Text("**Peso**: \(vm.formatHW(value: vm.pokemonDetails?.weight ?? 0)) KG")
                // Exibe a altura do Pokémon formatada em metros
                Text("**Altura**: \(vm.formatHW(value: vm.pokemonDetails?.height ?? 0)) M")

                // Botão para adicionar ou remover o Pokémon dos favoritos
                Button(action: {
                    vm.toggleFavorite(pokemon: pokemon)
                }) {
                    // Texto do botão condicional com base na presença do Pokémon nos favoritos
                    if vm.favorites.contains(pokemon) {
                        Text("Remover dos Favoritos")
                    } else {
                        Text("Adicionar aos Favoritos")
                    }
                }
            }
            // Adiciona um preenchimento ao redor do contêiner secundário
            .padding()
        }
        // Executa ação quando a visualização aparece na tela
        .onAppear {
            // Obtém detalhes adicionais do Pokémon quando a visualização aparece
            vm.getDetails(pokemon: pokemon)
        }
    }
}


