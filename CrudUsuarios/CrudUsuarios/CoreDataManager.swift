//
//  CoreDataManager.swift
//  CrudUsuarios
//
//  Created by CCDM23 on 30/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    init(){
        persistentContainer = NSPersistentContainer(name: "Usuario")
        persistentContainer.loadPersistentStores(completionHandler: {
            (descripcion, error) in
            if let error = error {
                fatalError("core data failed to inicialice \(error.localizedDescription)")
            }
        })
    }
    
    func guardarUsuario(id:String, nombre:String, apellido:String, rolid:String, username:String, activo:String){
        let usuario = Usuario(context : persistentContainer.viewContext)
        usuario.id = id
        usuario.nombre=nombre
        usuario.apellido=apellido
        usuario.rolid=rolid
        usuario.username = username
        usuario.activo = activo
        
        do{
            try persistentContainer.viewContext.save()
            print("usuario guardado")
        }
        catch{
            print("failed to  save error en \(error)")
        }
    }
    
    func leerTodosLosUsuarios()-> [Usuario]{
        let fetchRequest:NSFetchRequest<Usuario>=Usuario.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    
    func leerUsuario(id:String)->Usuario?{
        let fetchRequest:NSFetchRequest<Usuario>=Usuario.fetchRequest()
        let predicate = NSPredicate(format:"id=%@",id)
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }
        catch{
            print("failed to  save error en \(error)")
        }
        return nil
        
    }
    
    func actualizaraUsuario(usuario:Usuario){
        //var ped=persistentContainer.viewContext.updatedObjects([pedido])
        let fetchRequest:NSFetchRequest<Usuario>=Usuario.fetchRequest()
        let predicate = NSPredicate(format:"id=%@",usuario.id ?? "")
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let u=datos.first
            u?.nombre=usuario.nombre
            u?.apellido=usuario.apellido
            u?.rolid=usuario.rolid
            u?.id=usuario.id
            u?.username=usuario.username
            try persistentContainer.viewContext.save()
            print("usuario guardado")
        }
        catch{
            print("failed to  save error en \(error)")
        }
        
    }
    
    func borrarUsuario(usuario: Usuario){
        persistentContainer.viewContext.delete(usuario)
        
        do{
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
}
