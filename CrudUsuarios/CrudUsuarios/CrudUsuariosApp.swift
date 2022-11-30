//
//  CrudUsuariosApp.swift
//  CrudUsuarios
//
//  Created by CCDM23 on 30/11/22.
//

import SwiftUI

@main
struct CrudUsuariosApp: App {
    

    var body: some Scene {
        WindowGroup {
            ContentView(CoreDM: CoreDataManager())
            
        }
    }
}
