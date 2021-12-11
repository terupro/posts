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
            
            HStack(alignment: .center,spacing: 10) {
                ZStack{
                    if let image = memory.image,!image.isEmpty{
                        Section {
                            Image(uiImage: UIImage(data: image)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width:100, height: 80)
                                .cornerRadius(9)
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 9, x: 1, y: 1)
                        
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                       
                    }
                } //: ZSTACK
                
                VStack(alignment: .leading,spacing: 5){
                    
                    Text(memory.title ?? "")
                        .font(.system(.callout, design: .default))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 1, x: 2, y: 2)
                    Rectangle()
                          .foregroundColor(Color.primary.opacity(0.05))
                          .frame(height: 2)
                    Text(memory.timestamp ?? Date(),style: .date)
                        .font(.system(.footnote, design: .default))
                        .foregroundColor(Color.primary.opacity(0.5))
                        .italic()
  
                } //: VSTACK
            } //: VSTACK
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
