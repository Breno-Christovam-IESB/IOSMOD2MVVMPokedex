//
//  IOSMOD2MVVMPokedexApp.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

import SwiftUI

@main
struct IOSMOD2MVVMPokedexApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
