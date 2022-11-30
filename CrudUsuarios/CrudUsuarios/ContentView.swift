//
//  ContentView.swift
//  CrudUsuarios
//
//  Created by CCDM23 on 30/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let CoreDM: CoreDataManager
    @State var id=""
    @State var nombre=""
    @State var apellido=""
    @State var rolid=""
    @State var username=""
    @State var activo=""
    @State var seleccionado:Usuario?
    @State var usArray=[Usuario]()
    
    var body: some View {
        VStack{
            TextField("Id", text: $id).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Nombre", text: $nombre).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Apellido", text: $apellido).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Rolid", text: $rolid).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Activo", text: $activo).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save"){
                if(seleccionado != nil){
                    seleccionado?.id=id
                    seleccionado?.nombre=nombre
                    seleccionado?.apellido=apellido
                    seleccionado?.rolid=rolid
                    seleccionado?.username=username
                    seleccionado?.activo=activo
                    CoreDM.actualizaraUsuario(usuario: seleccionado!)
                }else{
                    CoreDM.guardarUsuario(id: id, nombre: nombre, apellido: apellido, rolid: rolid, username: username, activo: activo)
                }
                mostrarUsuario()
                id=""
                nombre=""
                apellido=""
                rolid=""
                username=""
                seleccionado=nil
            }
            List{
                ForEach(usArray,id: \.self){
                    us in
                    VStack{
                        Text(us.id ?? "")
                        Text(us.nombre ?? "")
                        Text(us.apellido ?? "")
                        Text(us.rolid ?? "")
                        Text(us.username ?? "")
                    }.onTapGesture{
                        seleccionado=us
                        id=us.id ?? ""
                        nombre=us.nombre ?? ""
                        apellido=us.apellido ?? ""
                        rolid=us.rolid ?? ""
                        username=us.username ?? ""
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    indexSet.forEach({index in let usuario=usArray[index]
                        CoreDM.borrarUsuario(usuario: usuario)
                        mostrarUsuario()
                    })
                })
            }
            Spacer()
        }.padding()
            .onAppear(perform:{
                        mostrarUsuario()
            })
    }
    func mostrarUsuario(){
        usArray=CoreDM.leerTodosLosUsuarios()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(CoreDM:CoreDataManager())
    }
}
