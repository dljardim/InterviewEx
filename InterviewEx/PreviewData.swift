//
//  PreviewData.swift
//  InterviewEx
//
//  Created by Damian Jardim on 6/13/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
struct PreviewData {
    static let container: ModelContainer = {
        let schema = Schema([Note.self])  // Add other models here if needed
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [config])
        
        let context = container.mainContext
        sampleNotes.forEach { context.insert($0) }
        
        return container
    }()
    
    static let sampleNotes: [Note] = [
        Note(title: "Shopping List", content: "Milk, Eggs, Bread, Butter"),
        Note(title: "Meeting Notes", content: "Discuss Q3 roadmap, budget updates"),
        Note(title: "Ideas", content: "Build a note app with SwiftData!")
    ]
}


/*
 
 You can now reuse it in any preview:
 
 #Preview {
 NotesListView()
 .modelContainer(PreviewData.container)
 }
 Or for a detail view:
 
 #Preview {
 NoteDetailView(note: PreviewData.sampleNotes[0])
 .modelContainer(PreviewData.container)
 }
 
 - If You Add More Models Later
 Just update the schema:
 let schema = Schema([Note.self, Tag.self, User.self])

 
 */
