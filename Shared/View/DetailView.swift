//
//  DetailView.swift
//  Reminisce
//
//  Created by Teruya Hasegawa on 2021/11/27.
//

import SwiftUI

struct DetailView: View {
    var memory: Memory
    var body: some View {
        
        
        
        
        
        
        
        
        
        
        List{
            if let image = memory.image,!image.isEmpty{
                Section{
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .listRowBackground(Color.clear)
                   
                    
                }
                .listRowBackground(Color.clear)
            }
            Section {
                Text(memory.timestamp ?? Date(),style: .date)
                
            } header: {
                Text("Date")
                    .fontWeight(.bold)
                    .italic()
            }
            
            
            Section {
                
                Text(memory.content ?? "")
                    .lineSpacing(1)
                
            } header: {
                Text("Moment")
                    .fontWeight(.bold)
                    .italic()
            }
            
            
            
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(memory.title ?? ""))
        
    }
}
