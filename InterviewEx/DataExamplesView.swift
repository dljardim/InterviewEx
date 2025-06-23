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


/**********************************************************************************************************************/


/*
 // Create a shared view model using @EnvironmentObject that’s injected once at the top level, and used across two child views to read/write shared state.
 Reuse (or create) a view model that conforms to ObservableObject:
 Add @Published var counter: Int = 0
 Create:
 A Parent View that uses .environmentObject() to inject the view model
 Two Child Views:
 One view should have a button to increment the counter.
 The other should display the current counter value.
 Use @EnvironmentObject in both child views to access the same data.
 💡 Example Behavior:
 Pressing the button in Child A increases the counter.
 The text in Child B updates live with the new count.
 */

final class Ex4MyCounterViewModel:ObservableObject{
    @Published var id:UUID = UUID()
    @Published var counter:Int = 0
    
    init(id:UUID = UUID(), count: Int) {
        self.counter = count
    }
}

struct Ex4MyParent:View {
    @StateObject var myCounterViewModel: Ex4MyCounterViewModel = Ex4MyCounterViewModel(count:0)
    
    var body: some View {
        VStack{
            Text("MyParent")
            Text("Count: \(myCounterViewModel.counter)")
            Divider()
            Ex4ChildA()
            Divider()
            Ex4ChildB()
        }.environmentObject(myCounterViewModel)
    }
    
}

// 1 child to increment the counter
struct Ex4ChildA:View {
    @EnvironmentObject var myCounterViewModel: Ex4MyCounterViewModel
    var body: some View {
        VStack{
            Text("Ex4ChildA - Increment the counter")
            Button("Increment the counter"){
                myCounterViewModel.counter += 1
            }
        }.padding()
    }
}

// 1 child to display the current counter value
struct Ex4ChildB:View {
    @EnvironmentObject var myCounterViewModel: Ex4MyCounterViewModel
    var body: some View {
        VStack{
            Text("Ex4ChildB - Display the current counter value")
            Text("Count: \(myCounterViewModel.counter)")
        }.padding()
    }
}

/**********************************************************************************************************************/


/**********************************************************************************************************************/
// ex5 - begin

// Using @State with a Model Struct
//🧩 Goal:
//Work with a value type (a struct) inside a @State variable and modify its properties.
//📦 Requirements:
//Create a struct called Profile with:
//var name: String
//var age: Int
//In a view:
//Declare a @State private var profile = Profile(name: "Alice", age: 30)
//Display the name and age.
//Add a TextField to edit the name.
//Add a Stepper to change the age.
//💡 Example Behavior:
//As the user types a new name or steps the age, the profile updates immediately.


struct Ex5Profile{
    var name: String
    var age: Int
}

struct Ex5ProfileView:View {
    @State private var ex5Profile = Ex5Profile(name: "Alice", age: 30)
    
    var body: some View {
        VStack{
            Text("Name: \(ex5Profile.name)")
            Text("Age: \(ex5Profile.age)")
            
            Divider()
            
            TextField("Name", text: $ex5Profile.name)
                .textFieldStyle(.roundedBorder)
            
            Stepper{
                Text("\(ex5Profile.age)")
            }onIncrement: {
                ex5Profile.age += 1
            }onDecrement: {
                ex5Profile.age -= 1
            }
            
        }.padding()
    }
}

// ex5 - end
/**************************************************************************************************************/

/**************************************************************************************************************/
// ex6 - start

struct Address{
    var street:String
    var city: String
}

struct User{
    var name:String
    var address: Address
}

struct Ex6UserAddressView:View{
    
    @State private var user:User = User(
        name: "Joe",
        address: Address(street: "Joes street", city: "Joe city")
    )
    
    var body: some View {
        Text("Ex6UserAddressView")
        
        TextField("Name",
                  text:Binding(get:{user.name}, set: {user.name = $0})
        ).textFieldStyle(.roundedBorder)
        
        TextField(
            "Street",
            text:Binding(get: {user.address.street}, set: {user.address.street = $0})
        ).textFieldStyle(.roundedBorder)
        
        TextField(
            "City",
            text:Binding(get: {user.address.city}, set: {user.address.city = $0})
        ).textFieldStyle(.roundedBorder)
        
    }
}

// ex6 - end
/**************************************************************************************************************/

/**************************************************************************************************************/
// ex7 - start
// summary / challenge:

//🧩 Goal:
//Split your form into parent and child views, and pass a Binding to the child view so it can edit a portion of the parent’s @State data.
//This is common when building reusable forms, editors, or modular views.
//🛠 Scenario:
//You already have a User with a nested Address. Now you'll:
//Keep @State private var user in the parent view.
//Create a child view (e.g., AddressEditor) that receives a Binding<Address> and edits the address fields.
//📦 Requirements:
//struct AddressEditor: View {
//    @Binding var address: Address
//
//    var body: some View {
//        // TextFields to edit street and city
//    }
//}
//
//struct Ex7UserEditor: View {
//    @State private var user = User(name: "Sally", address: Address(street: "123 Main", city: "Springfield"))
//
//    var body: some View {
//        // TextField for user.name
//        // Pass $user.address into AddressEditor
//    }
//}
//🎯 Goal:
//When the user edits name/street/city, changes reflect in the user stored in the parent.
//Child doesn't own the state — it only binds to a slice of it.


struct Ex7Address{
    var street:String
    var city: String
}

struct Ex7User{
    var name:String
    var address: Ex7Address
}

// private @state child
struct Ex7ParentView:View{
    @State private var user:Ex7User = Ex7User(
        name: "Damian",
        address: Ex7Address(street: "dStreet", city: "dCity")
    )
    var body: some View {
        VStack{
            Text("ParentView")
            Text("name: \(user.name)")
            Text("street: \(user.address.street)")
            Text("city: \(user.address.city)")
            
            ThickDivider()
            
            Ex7AddressEditor(ex7AddressChild: $user.address)
        }
    }
}

struct ThickDivider: View {
    var color: Color = .gray
    var height: CGFloat = 2
    
    var body: some View {
        VStack{
            Rectangle()
                .fill(color.opacity(0.50))
                .frame(height: height)
                .edgesIgnoringSafeArea(.horizontal)
        }.padding()
    }
}

struct Ex7AddressEditor: View {
    
    @Binding var ex7AddressChild:Ex7Address
    
    var body: some View {
        VStack{
            TextField(
                "Street",
                text:Binding(
                    get: {ex7AddressChild.street
                    },
                    set: {ex7AddressChild.street = $0})
            ).textFieldStyle(.roundedBorder)
            
            TextField(
                "City",
                text:Binding(
                    get: {ex7AddressChild.city
                    },
                    set: {ex7AddressChild.city = $0})
            ).textFieldStyle(.roundedBorder)
        }
    }
}

struct Ex7UserEditor: View {
    @State private var user = Ex7User(name: "Sally", address: Ex7Address(street: "123 Main", city: "Springfield"))
    
    var body: some View {
        TextField("Name", text:Binding(get:{user.name}, set:{user.name = $0}))
        
        Ex7AddressEditor(ex7AddressChild: $user.address)
    }
}

// ex7 - end
/**************************************************************************************************************/




#Preview {
//    exValidation1().preferredColorScheme(.dark)
}
