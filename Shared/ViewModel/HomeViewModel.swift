//
//  HomeViewModel.swift
//  Reminisce (iOS)
//
//  Created by Teruya Hasegawa on 2021/11/27.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    // Lock Status
    @Published var showAlert: Bool = false
    @Published var alertMsg: String = ""
    

    @Published var isUnlocked: Bool = false
    
    @AppStorage("isLocked") var isLockEnabled: Bool = false
    @AppStorage("lockPassword") var password: String = ""
    
    
    // To Avoid asking password immediatly after setting password....
    @Published var firstTimeCheck: Bool = false
    let hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    
    func verifyPassword(){
                
        alertTF(message: "ロックを解除するにはパスワードを入力してください。", title: "Enter Password", hint: "123456") {[self] txt in
            
            if txt == password{
                
                if firstTimeCheck{
                    alertMsg = "Postsへようこそ。\n思い出をたくさん記録しましょう！"
                    showAlert.toggle()
                    hapticImpact.impactOccurred()
                }
                
                withAnimation{isUnlocked = true}
            }
            else{
                alertMsg = "正しいパスワードを入力してください。"
                showAlert.toggle()
            }
        }
    }
    
    func turnOnPassword(){
        
        if isLockEnabled{
            isLockEnabled = false
            isUnlocked = false
            password = ""
            alertMsg = "ロックを解除しました！"
            showAlert.toggle()
        }
        else{
            setPassword()
        }
    }
    
    func setPassword(){
        
        alertTF(message: "パスワードを設定してください。", title: "Set Password", hint: "123456") {[self] txt in
            
            if txt == ""{
                alertMsg = "パスワードを設定できませんでした。"
                showAlert.toggle()
            }
            else{
                password = txt
                isLockEnabled = true
                firstTimeCheck = true
            }
        }
    }
    
    func alertTF(message: String,title: String,hint: String,completion: @escaping (String)->()){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { txt in
            txt.placeholder = hint
            txt.isSecureTextEntry = (title == "Enter Password")
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            let text = alert.textFields?[0].text ?? ""
            
            completion(text)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        guard let app = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return
        }
        
        guard let controller = app.windows.last?.rootViewController else{
            return
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
}
