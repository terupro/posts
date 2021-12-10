//
//  CardView.swift
//  Reminisce
//
//  Created by Teruya Hasegawa on 2021/11/27.
//

import SwiftUI

struct CardView: View {
    
    var memory: Memory
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        
        NavigationLink(destination: DetailView(memory: memory)) {
            
            VStack(alignment: .leading,spacing: 10){
                
                Text(memory.title ?? "")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Rectangle()
                      .foregroundColor(Color.primary.opacity(0.05))
                      .frame(height: 2)
                
                Text(memory.timestamp ?? Date(),style: .date)
                    .font(.system(.footnote, design: .default))
            }
            .foregroundColor(.primary)
            .padding()
            .frame(maxWidth: .infinity,alignment: .leading)
            .background(scheme == .dark ? Color.gray.opacity(0.6) : Color.white)
            .cornerRadius(10)
            .frame(maxWidth: .infinity,alignment: .leading)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
        }
    }
}
