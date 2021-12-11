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
        
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                if let image = memory.image,!image.isEmpty{
                    Group{
                        Image(uiImage: UIImage(data: image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                
                VStack(alignment: .leading, spacing: 16){
                    VStack(alignment: .leading, spacing: 10) {
                        Text("#date ")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .italic()
                            .underline()
                        Text(memory.timestamp ?? Date(),style: .date)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("#comment ")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .italic()
                            .underline()
                        
                        Text(memory.content ?? "")
                            .lineSpacing(1)
                    }
                } //: VSTACK
                .padding(.leading)
                .frame(maxWidth:.infinity, alignment: .leading)
            } //: VSTACK
            .navigationBarTitle(Text(memory.title ?? ""),displayMode: .inline)
            
        } //: SCROLL
        .background(MotionAnimationView().edgesIgnoringSafeArea(.all))
        .background(Color.primary.opacity(0.05))
    }
}
