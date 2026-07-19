//
//  BabyMonitorView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 9/07/26.
//

import SwiftUI
import AVFoundation

struct BabyMonitorView: View {
    
    let baseURL = SamayGoApp.baseUrl
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#FCFDFF"), Color(hex: "#CFDDF7")]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
            
            HStack(spacing: 16){
                CameraMonitorView()
                    .frame(width: 250, height: 250)
                    .cornerRadius(12)
                    .shadow(radius: 12)
                
                VStack(spacing: 16) {
                    SmallButtonView(text: "Mecer", altText: "Meciendo...", iconName: "CraddleIcon", onTap: { button in
                        
                        guard let url = URL(string: "\(baseURL)/toggleRocking") else { return }
                        URLSession.shared.dataTask(with: url) { data, _, _ in
                            if let data = data,
                               let json = try? JSONSerialization.jsonObject(with: data) as? [String: String],
                               let state = json["rockingMode"] {
                                button.state = state == "ON"
                                
                            }
                        }.resume()
                    })
                    .shadow(radius: 12)
                    SmallButtonView(text: "Música", altText: "Sonando...", iconName: "MusicIcon", onTap: { button in
                        if button.state {
                            button.state = false
                            stopSound()
                        } else {
                            button.state = true
                            playSound(button: button)
                        }
                    })
                    .shadow(radius: 12)
                }
            }
            .toast(isShowing: $showToast, message: toastMessage)
        }
    }
    
    func playSound(button: SmallButtonView) {
        guard let asset = NSDataAsset(name: "babySong") else {
            withAnimation(.spring()) {
                showToast = true
                toastMessage = "No se encontró el archivo de audio"
            }
            button.state = false
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(data: asset.data, fileTypeHint: "mp3")
            audioPlayer?.play()
            
            button.state = true
        } catch {
            withAnimation(.spring()) {
                showToast = true
                toastMessage = "Error al reproducir el audio: \(error.localizedDescription)"
            }
            button.state = false
            return
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil // libera el reproductor por completo
        
        // Opcional: desactiva la sesión de audio si ya no vas a reproducir nada más
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}
