//
//  DataExamplesView.swift
//  InterviewEx
//
//  Created by Damian Jardim on 6/2/25.
//

import SwiftUI

// simple @State private variable
struct DataExamplesView: View {
    
    @State private var count = 0
    
    var body: some View {
        VStack{
            Text("Count: \(count)")
            
            Button("Tap Me"){
                count += 1
            }
        }
        .padding()
    }
}

// binding example - parent to child
struct Ex2Parent: View {
    
    @State private var isOn:Bool = false
    var body: some View {
        VStack(spacing:20){
            Text("isOn: \(isOn)").font(.headline)
            Divider()
            Ex2Child(isOn: $isOn)
        }.padding()
    }
}

struct Ex2Child: View {
    @Binding var isOn:Bool
    
    var body: some View {
        VStack{
            Text("Ex2Child")
            Toggle(isOn: $isOn){
                Text("isOn")
            }
        }
    }
}


//Exercise 3: @ObservedObject, ObservableObject, and @Published
// Ex3OwnsObject() owns the vm using @stateObject
class UserViewModel:ObservableObject{
    
    @Published var id:UUID = UUID()
    @Published var userName: String = ""
    
    init(id:UUID = UUID(), userName:String){
        self.id = id
        self.userName = userName
    }
}

// view that displays the viewmodels current username
struct Ex3View: View{
    
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack{
            Text("userName: \(viewModel.userName)")
            TextField("userName", text:$viewModel.userName)
        }
    }
}

struct Ex3OwnsObject: View {
    @StateObject var vm:UserViewModel = UserViewModel(userName: "John")
    
    var body: some View{
        VStack{
            Ex3View(viewModel: vm)
        }
    }
}





#Preview {
    Ex3OwnsObject()
}
