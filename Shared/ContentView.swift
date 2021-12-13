//
//  ContentView.swift
//  Shared
//
//  Created by Teruya Hasegawa on 2021/11/27.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {

    // Lock Status...
    @AppStorage("isLocked") var isLockEnabled: Bool = false
    @StateObject var homeData = HomeViewModel()

    var body: some View {
 
        ZStack{
            
            NavigationView{
                
                Home()
                    .environmentObject(homeData)
                    .navigationTitle("Posts")

            }
            
            .navigationViewStyle(.stack)
            
            if isLockEnabled && !homeData.isUnlocked{
                
                Group{
                    
                    BlurView(style: .systemUltraThinMaterial)
                        .ignoresSafeArea()
                    
                    Button {
                        homeData.verifyPassword()
           
                    } label: {
                        Label {
                            Text("Unlock")
                        } icon: {
                            Image(systemName: "lock.open.fill")
                        }
                        .font(.title2.bold())
                    }

                }
                
                .onAppear {
                    homeData.verifyPassword()
                }
            }
            
        }

        .alert(isPresented: $homeData.showAlert) {
            
            Alert(title: Text("Message"), message: Text(homeData.alertMsg), dismissButton: .destructive(Text("OK"), action: {
                
                if homeData.alertMsg == "正しいパスワードを入力してください！"{
                    homeData.verifyPassword()
                }
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

