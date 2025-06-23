import SwiftData
import Foundation
import SwiftUI




// 1. create (singular) datamodel - using swiftdata
@Model
class Note {
    var id:UUID
    var title: String
    var content: String
    var createdDate: Date
    var updatedDate: Date
    
    // default values added in init()
    init(id: UUID = UUID(), title: String = "", content: String = "", createdDate: Date = .now, updatedDate: Date = .now) {
        self.id = id
        self.title = title
        self.content = content
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}

// 2. @main app starting point add your model
// @Model class Note --->   .modelContainer(for: Note.self)
@main
struct NotesApp: App {
    var body: some Scene {
        WindowGroup{
            //            ContentView()
            NotesListView()
        }
        .modelContainer(for: Note.self)
    }
}

// 3. @Environment and @Query
struct NotesListView: View {
    @Environment(\.modelContext) var context
    @Query private var notes: [Note]
    @State private var path = NavigationPath()
    @State private var searchText = ""
    @State private var isKeyboardVisible = false
    
    var filteredNotes: [Note] {
        if(searchText.isEmpty){
            return notes
        } else {
            return notes.filter{
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        print("deletenote")
        for index in offsets {
            context.delete(notes[index])
        }
    }
    
    func doNothing(){
        print("doNothing called")
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(filteredNotes) { note in
                    NavigationLink(value: note) {
                        NotesListItem(note: note)
                    }
                }
                .onDelete(perform: deleteNote)
            }
            
            .navigationTitle("My Notes")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Button{print("View as Gallery")}label:{
                            Text("View as Gallery")
                            Spacer()
                            Image(systemName: "swift")
                        }
                        Divider()
                        Button{print("View Attachments")}label:{
                            Text("View as Gallery")
                            Spacer()
                            Image(systemName: "swift")
                        }
                    }label: {
                        Image(systemName: "ellipsis.circle").tint(.orange)
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationDestination(for: Note.self) { note in
                NotesDetailView(note: note)
            }
            
            
            
            
            // bottom row
            if !isKeyboardVisible{
                HStack{
                    Spacer()
                    Text("\(notes.count) Notes").font(.footnote).foregroundStyle(.white)
                    Spacer()
                    Button{
                        let newNote = Note(title: "", content: "")
                        context.insert(newNote)
                        path.append(newNote)
                    }label:{
                        Image(systemName: "square.and.pencil")
                            .tint(.orange)
                    }
                }.padding()
            }
                
        }.onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                isKeyboardVisible = true
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                isKeyboardVisible = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                print("Now safe to inspect view hierarchy 👀")
            }
        }
        .onDisappear{
            NotificationCenter.default.removeObserver(self)
        }
        
        
        
        
    }
}


struct NotesListItem: View {
    var note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(note.title)
                .font(.headline)
            Text(note.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            Text(note.createdDate.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

struct NotesDetailView: View {
    @Bindable var note: Note
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var scrollOffset: CGFloat = 0
    
    var formattedDate: String {
        note.createdDate.formatted(date: .abbreviated, time: .shortened)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: ScrollOffsetKey.self, value: geo.frame(in: .named("scroll")).minY)
                }
                .frame(height: 0)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Pull-down date
                    if scrollOffset > 20 {
                        let _ = print("scrollOffset > 20")
                        Text(formattedDate)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .transition(.opacity)
                    }
                    
                    // Title field
                    TextField("", text: $note.title)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    
                    // Content field
                    TextEditor(text: $note.content)
                        .foregroundColor(.white)
                        .font(.body)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal)
                        .frame(minHeight: 400)
                }
                .padding(.top, 40)
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                scrollOffset = value
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    try? context.save()
                    dismiss()
                }
            }
        }
    }
}

// PreferenceKey for scroll offset tracking
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}



struct preview: PreviewProvider {
    static var previews: some View {
        NotesListView().preferredColorScheme(.light)
    }
}
