//
//  CardView.swift
//  Reminisce
//
//  Created by Teruya Hasegawa on 2021/11/27.
//

import SwiftUI

struct CardView: View {
    
    var memory: Memory

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
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                } //: ZSTACK
                VStack(alignment: .leading,spacing: 5){
                    Text(memory.title ?? "")
                        .font(.system(.callout, design: .default))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
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
            .background(Color.gray.opacity(0.6))
            .cornerRadius(10)
            .frame(maxWidth: .infinity,alignment: .leading)
            
        }
    }
}
