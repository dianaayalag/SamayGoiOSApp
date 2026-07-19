//
//  CameraMonitorView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 9/07/26.
//

import SwiftUI

struct CameraMonitorView: View {
    @State private var cameraImage: UIImage? = nil
    @State private var showFullScreen = false
    
    let baseURL = SamayGoApp.baseUrl
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                if let uiImage = cameraImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipped()
                        .cornerRadius(12)
                        .shadow(radius: 5)
                } else {
                    VStack(alignment: .center, spacing: 16) {
                        Image("WifiIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                        Text("Cargando...")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 250, height: 250)
                    .background(Color.black)
                    .cornerRadius(12)
                }
            }
            
            Button {
                showFullScreen = true
            } label: {
                Image("FullScreenButton")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipped()
                    .cornerRadius(12)
                    .padding()
            }
        }
        .fullScreenCover(isPresented: $showFullScreen) {
            FullScreenCameraView(cameraImage: cameraImage)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                loadCameraImage()
            }
        }
    }
    
    func loadCameraImage() {
        guard let url = URL(string: "\(baseURL)/capture") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.cameraImage = image
                }
            }
        }.resume()
    }
}

struct FullScreenCameraView: View {
    var cameraImage: UIImage?
    let items = ["24˚C", "Movimiento inusual", "Ruido elevado", "Fuera de la cuna", "Posición de riesgo"]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            if let uiImage = cameraImage {
                ZStack(alignment: .bottom) {
                    VStack {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack(alignment: .leading) {
                        FlowLayout(spacing: 8) {
                            ForEach(items, id: \.self) { item in
                                HStack(spacing: 8) {
                                    Image("WarningIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                    Text(item)
                                        .foregroundStyle(Color(hex: "#F5F5F5"))
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color(hex: "#2C2C2C"))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.bottom, 55)
                    }
                    .padding(.horizontal, 5)
                }
                
            } else {
                VStack(alignment: .center, spacing: 16) {
                    Image("WifiIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                    Text("Cargando...")
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
            }
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
