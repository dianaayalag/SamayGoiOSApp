//
//  ContentView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 8/07/26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            homeView
                .tabItem {
                    Label("Inicio", systemImage: "house.fill")
                }
            notificationsView
                .tabItem {
                    Label("Notificaciones", systemImage: "bell.badge")
                }
            profileView
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
        }
        
    }
    
    var homeView: some View {
        ScrollView {
            VStack {
                BabyMonitorView()
                    .padding(.vertical)
                MonitorSectionView()
                Spacer()
            }
            .background(Color(hex: "#f8f8f8"))
        }
    }
    
    var notificationsView: some View {
        ScrollView {
            VStack {
                NotificationsView()
            }
            .background(Color(hex: "#f8f8f8"))
        }
    }
    
    var profileView: some View {
        VStack {
            MiPerfilView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#f8f8f8"))
    }
}
