//
//  MonitorSectionView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 8/07/26.
//

import SwiftUI

struct MonitorSectionView: View {
    
    let baseURL = SamayGoApp.baseUrl
    
    @State var temperature: String = String()
    @State var isBabyQuiet = true
    @State var isEnvNoisy = false
    @State var isBabyInCradle = true
    @State var isPositionSafe = true
    
    @State var isLoadingTemperature = true
    @State var isLoadingMovement = true
    @State var isLoadingNoise = true
    @State var isLoadingCradlePresence = true
    @State var isLoadingPosition = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Monitoreo")
                .font(.system(size: 22))
                .foregroundStyle(Color(hex: "#322222"))
                .padding(.horizontal, 40)
            MonitorInformationView(imageName: "TemperatureIcon",
                                   title: "Temperatura ambiental",
                                   value: temperature,
                                   subtitle: "Dentro del rango recomendado (20 °C–22 °C)",
                                   color: "#cff7d3",
                                   isLoading: isLoadingTemperature)
            MonitorInformationView(imageName: "SleepingIcon",
                                   title: "Movimiento",
                                   value: isBabyQuiet ? "Tranquilo" : "Inusual",
                                   subtitle: isBabyQuiet ? "" : "Verifica el estado del bebé",
                                   color: isBabyQuiet ? "#cff7d3" : "#E8B931",
                                   isLoading: isLoadingMovement)
            MonitorInformationView(imageName: "NoiseIcon",
                                   title: "Ruido",
                                   value: isEnvNoisy ? "Ruido elevado" : "Tranquilo",
                                   subtitle: isEnvNoisy ? "Verifica el estado del bebé" : "",
                                   color: isEnvNoisy ? "#cff7d3" : "#E8B931",
                                   isLoading: isLoadingNoise)
            MonitorInformationView(imageName: "CraddleIcon",
                                   title: "Presencia en cuna",
                                   value: isBabyInCradle ? "En la cuna" : "Fuera de la cuna",
                                   subtitle: "",
                                   color: isBabyInCradle ? "#cff7d3" : "#E8B931",
                                   isLoading: isLoadingCradlePresence)
            MonitorInformationView(imageName: "PositionIcon",
                                   title: "Posición",
                                   value: isPositionSafe ? "Segura" : "Posición de riesgo",
                                   subtitle: isPositionSafe ? "" : "Reacomoda al bebé para una posición segura",
                                   color: "#cff7d3",
                                   isLoading: isLoadingPosition)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            await fetchTemperature()
        }
        .task {
            await fetchMovement()
        }
        .task {
            await fetchNoiseMock()
        }
        .task {
            await fetchCradlePresenceMock()
        }
        .task {
            await fetchPositionMock()
        }
    }
    
    private func fetchTemperature() async {
        guard let url = URL(string: "\(baseURL)/getTemperature") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: String],
               let temp = json["temperature"] {
                self.temperature = temp
                self.isLoadingTemperature = false
            }
        } catch {
            self.isLoadingTemperature = false
            print("Error fetching temperature: \(error)")
        }
    }
    private func fetchMovement() async {
        guard let url = URL(string: "\(baseURL)/getMovement") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: String] {
                self.isBabyQuiet = json["isBabyQuiet"] == "yes"
                self.isLoadingMovement = false
            }
        } catch {
            self.isLoadingMovement = false
            print("Error fetching movement: \(error)")
        }
    }
    
    private func fetchNoiseMock() async {
        let delay = Double.random(in: 1...3)
        try? await Task.sleep(for: .seconds(delay))
        
        self.isEnvNoisy = Bool.random()
        self.isLoadingNoise = false
    }
    
    private func fetchCradlePresenceMock() async {
        let delay = Double.random(in: 1...3)
        try? await Task.sleep(for: .seconds(delay))
        
        self.isBabyInCradle = Bool.random()
        self.isLoadingCradlePresence = false
    }
    
    private func fetchPositionMock() async {
        let delay = Double.random(in: 1...3)
        try? await Task.sleep(for: .seconds(delay))
        
        self.isPositionSafe = Bool.random()
        self.isLoadingPosition = false
    }
    
    
}
