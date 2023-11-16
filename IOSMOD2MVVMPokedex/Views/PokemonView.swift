//
//  PokemonView.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

import Foundation
import SwiftUI

struct PokemonView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: Pokemon
    let dimensions: Double = 140
    
    var body: some View {
        // Um contêiner de visualização vertical
        VStack {
            // Exibição de imagem assíncrona carregada a partir de uma URL
            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(vm.getPokemonIndex(pokemon: pokemon)).png")) { image in
                // Verifica se a imagem não é nula antes de exibi-la
                if image != nil {
                    // Modificações na exibição da imagem
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: dimensions, height: dimensions)
                }
            } placeholder: {
                // Exibição de um indicador de progresso enquanto a imagem está sendo carregada
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
            }
            // Adiciona um plano de fundo fino à imagem
            .background(.thinMaterial)
            // Modela a imagem como um círculo
            .clipShape(Circle())

            // Exibição do nome do Pokémon capitalizado
            Text("\(pokemon.name.capitalized)")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .padding(.bottom, 20)
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        // Pré-visualização do PokemonView com um Pokemon de exemplo e um ViewModel
        PokemonView(pokemon: Pokemon.samplePokemon)
            .environmentObject(ViewModel())
    }
}

