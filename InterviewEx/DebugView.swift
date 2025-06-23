//
//  DebugView.swift
//  InterviewEx
//
//  some examples where view hierarchy can help find the issue
//
//  Created by Damian Jardim on 6/16/25.
//

import SwiftUI

struct VanishingTextView: View {
    var body: some View {
        VStack {
            Text("Welcome to Debugville")
                .font(.title)
            
            VStack {
                Text("This should be visible")
//                    .padding()
                
                Text("This is missing...")
//                    .padding()
            }
            .background(Color.green)
            .frame(maxHeight: 0) // 👀 Ohhh boy.
            
            Text("Still here!")
        }
        .padding()
    }
}



#Preview {
    VanishingTextView()
}
