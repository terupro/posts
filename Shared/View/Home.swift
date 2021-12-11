//
//  Home.swift
//  Home
//
//  Created by Teruya Hasegawa on 2021/11/27.
//

import SwiftUI
import CoreData
import PhotosUI
import LocalAuthentication

struct Home: View {
    
    @Environment(\.colorScheme) var scheme
    @State var createMemory = false
    
    // Memories.....
    @FetchRequest(entity: Memory.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Memory.timestamp, ascending: false)], animation: .easeInOut) var results : FetchedResults<Memory>
    
    @Environment(\.managedObjectContext) var context
    
    @State var currentMemory: Memory?

    @EnvironmentObject var homeData: HomeViewModel
    
    // Lock Status
    @AppStorage("isLocked") var isLockEnabled: Bool = false
    let hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                
                ForEach(results){memory in
                    
                    CardView(memory: memory)
                        .contextMenu {
                            
                            Button("Delete"){
                                context.delete(memory)
                                try? context.save()
                            }
                            Button("Edit"){
                                currentMemory = memory
                                createMemory.toggle()
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(MotionAnimationView().edgesIgnoringSafeArea(.all))
        .background(Color.primary.opacity(0.05))
        
        .toolbar(content: {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button {
                    hapticImpact.impactOccurred()
                    homeData.turnOnPassword()
                    
                } label: {
                    Image(systemName: !isLockEnabled ? "lock.open.fill" : "lock.fill")
                }
            }
        })
        .overlay(
        
            Button(action: {
                hapticImpact.impactOccurred()
                createMemory.toggle()
                
                
            }, label: {
                
                Image(systemName: "goforward.plus")
                    .font(.title)
                    .padding(13)
                    .background(Color.primary)
                    .clipShape(Circle())
                    .foregroundColor(scheme == .dark ? .black : .white)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
            })
            .padding()
            
            ,alignment: .bottomTrailing
        )
        .sheet(isPresented: $createMemory) {
            currentMemory = nil
        } content: {
            
            CreateMemory(close: $createMemory, memory: $currentMemory)
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
