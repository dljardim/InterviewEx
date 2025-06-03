//
//  ContentView.swift
//  InterviewEx
//
//  Created by Damian Jardim on 5/27/25.
//

import SwiftUI

//enum ex :

struct ContentView: View {
    var body: some View {
        VStack {
            
//            LightBulbView()
        }
        .padding()
    }
}


struct LightBulbView: View {
    @StateObject var lightBulb:LightBulbViewModel
    
    var body: some View{
        Text("isOn: \(lightBulb.isOn)")
        
        Button("toggle"){
            lightBulb.isOn.toggle()
        }
    }
}

class LightBulbViewModel:ObservableObject{
    @Published var id: UUID
    @Published var isOn:Bool
    init(id: Int, isOn: Bool) {
        self.id = UUID()
        self.isOn = false
    }
}

/*  struct w/ initializer
struct Student: Identifiable {
    let id:UUID
    let name: String
    
    init(name: String){
        self.id = UUID()
        self.name = name
    }
}
*/

#Preview {
    ContentView()
}
