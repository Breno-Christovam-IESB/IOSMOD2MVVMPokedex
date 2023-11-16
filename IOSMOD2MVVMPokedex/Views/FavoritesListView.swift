//
//  FavoritesListView.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

import Foundation
import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        NavigationView {
            // Lista de favoritos
            List(vm.favorites) { favoritePokemon in
                // Navegação para a tela de detalhes do Pokémon quando tocado
                NavigationLink(destination: PokemonDetailView(pokemon: favoritePokemon)) {
                    // Exibição de texto mostrando o nome do Pokémon favorito
                    Text(favoritePokemon.name)
                }
            }
            // Título da barra de navegação na tela de favoritos
            .navigationBarTitle("Favoritos")
        }
    }
}

