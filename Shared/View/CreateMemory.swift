//
//  CreateMemory.swift
//  Reminisce
//
//  Created by Teruya Hasegawa on 2021/11/27.
//

import SwiftUI
import KeyboardObserving

struct CreateMemory: View{
    
    @Binding var close: Bool
    @Binding var memory: Memory?
    @Environment(\.managedObjectContext) var context
    @Environment(\.colorScheme) var scheme
    
    @State var title = ""
    @State var content = ""
    @State var date: Date = Date()
    
    @State var isImage = false
    @State var showImagePicker = false
    @State var imageData : Data = Data(count: 0)
    
    @State var alertMsg = ""
    @State var showAlert = false
    let hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View{
        
        NavigationView{
            
            List{
            
                if memory == nil{
                    
                    Section {
                        
                        DatePicker("", selection: $date)
                            .labelsHidden()
                        
                        
                    } header: {
                        
                        Text("Date")
                            .fontWeight(.bold)
                            .italic()
                        
                    }
                    
                }
                
                
                Section {
                    
                    if isImage{
                        
                        Button {
                            hapticImpact.impactOccurred()
                            showImagePicker.toggle()
                            
                            
                        } label: {
                            
                            ZStack{
                                
                                if imageData.isEmpty{
                                        Image(systemName: "plus")
                                            .font(.largeTitle)
                                            .frame(width: 100, height: 100, alignment: .center)
                                            .background(scheme == .dark ? Color.gray.opacity(0.2) : Color.white)
                                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
                                            .cornerRadius(10)
                                            .foregroundColor(.primary)
                                         
                                         
                                }
                                else{
                                    Image(uiImage: UIImage(data: imageData)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(10)
                                }
                                
                            }
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.top,8)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 3, x: 2, y: 2)
                        }
                        .frame(maxWidth: .infinity,alignment: .center)
                        
                    }
                    
                } header: {
                    
                    Toggle(isOn: $isImage) {
                        Text("Do you want to add a photo？")
                            .fontWeight(.bold)
                            .italic()
                        
                    }
                }
                .listRowBackground(Color.clear)
                
                Section {

                    TextField("....", text: $title)
             
                } header: {
                    
                    Text("Title")
                        .fontWeight(.bold)
                        .italic()
                }
                
                Section {
                    
                    TextEditor(text: $content)
                        .background(
                            Text("....")
                                .foregroundColor(.gray)
                                .opacity(content == "" ? 0.7 : 0)
                                .offset(x: 2)
                            ,alignment: .leading
                        )
                     
                    
                } header: {
                    
                    Text("Comment")
                        .fontWeight(.bold)
                        .italic()
                    
                }
                
            }
            .keyboardObserving()
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("投稿画面")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button("Close"){
                        close.toggle()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button("Post"){
                        saveData()
                    }
                    .disabled(checkDisabled())
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(imageData: $imageData, picker: $showImagePicker)
        }
        .alert(isPresented: $showAlert) {
            
            Alert(title: Text("Message"), message: Text(alertMsg), dismissButton: .destructive(Text("OK")))
        }
        .onChange(of: isImage, perform: { newValue in
            if !isImage{imageData = Data(count: 0)}
        })
        .onAppear {
            
            guard let editMemory = memory else{return}
            
            title = editMemory.title ?? ""
            content = editMemory.content ?? ""
            date = editMemory.timestamp ?? Date()
            imageData = editMemory.image ?? Data(count: 0)
            if !imageData.isEmpty{
                isImage = true
            }
        }
    }
    
    func checkDisabled()->Bool{
        return title == "" || content == "" || (isImage && imageData.isEmpty)
    }
    
    func saveData(){
        
        if memory != nil{
            
            memory?.title = title
            memory?.content = content
            memory?.image = imageData
        }
        else{
            let memory = Memory(context: context)
            memory.title = title
            memory.timestamp = date
            memory.content = content
            memory.image = imageData
        }
        
        do{
            try context.save()
            close.toggle()
        }
        catch{
            alertMsg = error.localizedDescription
            showAlert.toggle()
        }
    }
}
