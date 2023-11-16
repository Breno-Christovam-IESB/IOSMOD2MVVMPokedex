//
//  ContentView.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

//import CoreData
import SwiftUI

struct ContentView: View {
    // StateObject que gerencia o estado da visualização (como ViewModel)
    @StateObject var vm = ViewModel()
    
    // Configuração de colunas adaptáveis para a grade
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        // Contêiner de navegação que gerencia a hierarquia de visualizações
        NavigationView {
            // Contêiner de rolagem para permitir a rolagem do conteúdo
            ScrollView {
                // Grade de visualizações Pokémon usando colunas adaptáveis
                LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                    ForEach(vm.filteredPokemon) { pokemon in
                        // Navegação para a tela de detalhes do Pokémon quando tocado
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            // Exibição da visualização do Pokémon
                            PokemonView(pokemon: pokemon)
                        }
                    }
                }
                // Animação para transições suaves quando o número de Pokémons filtrados muda
                .animation(.easeInOut(duration: 0.3), value: vm.filteredPokemon.count)
                // Título da barra de navegação
                .navigationTitle("Pokedex")
                // Define o modo de exibição do título da barra de navegação
                .navigationBarTitleDisplayMode(.inline)
                // Adiciona itens à barra de navegação (ícone de favoritos)
                .navigationBarItems(trailing:
                    NavigationLink(destination: FavoritesListView()) {
                        Image(systemName: "star.fill") // Ícone representativo de favoritos
                            .imageScale(.large)
                            .padding()
                    }
                )
            }
            // Adiciona pesquisa ao conteúdo
            .searchable(text: $vm.searchText)
        }
        // Injeta o objeto ViewModel no ambiente para ser compartilhado entre as visualizações
        .environmentObject(vm)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Pré-visualização da ContentView
        ContentView()
    }
}



//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
