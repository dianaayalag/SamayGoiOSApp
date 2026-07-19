//
//  MiPerfilView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 10/07/26.
//

import SwiftUI

struct MiPerfilView: View {
    
    var body: some View {
        VStack {
            Text("Mi Perfil")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            MiPerfilBanner()
            DevicesBanner()
                .padding(.top)
            Spacer()
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.forward")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Cerrar Sesión")
                    .fontWeight(.medium)
            }
            .foregroundColor(Color(hex:"#624B8B"))
            .padding(.bottom)
        }
    }
}

struct MiPerfilBanner: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 400, height: 100)
            HStack(spacing: 10) {
                Image("UserPicture")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.leading)
                VStack(alignment: .leading) {
                    Text("Maria Galvez Torres")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("mgalvez@gmail.com")
                        .fontWeight(.light)
                        .foregroundStyle(Color.black)
                }
                Image("PenIcon")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing)
            }
        }
    }
}

struct DevicesBanner: View {
    @State private var activeSheet: ActiveSheet?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("1 dispositivo vinculado")
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 400, height: 180)
                VStack(alignment: .leading) {
                    Text("Samay cuna")
                        .fontWeight(.bold)
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 360, height: 55)
                                .shadow(radius: 0.5)
                            HStack {
                                Text("Configurar dispositivo")
                                    .fontWeight(.medium)
                                    .padding(.leading)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing)
                            }
                            .frame(width: 360, height: 55)
                        }
                        .onTapGesture {
                            activeSheet = .devices
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 360, height: 55)
                                .shadow(radius: 0.5)
                            HStack {
                                Text("Configurar alertas")
                                    .fontWeight(.medium)
                                    .padding(.leading)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing)
                            }
                            .frame(width: 360, height: 55)
                        }
                        .onTapGesture {
                            activeSheet = .alerts
                        }
                    }
                }
                .frame(alignment: .leading)
            }
            .sheet(item: $activeSheet) { sheet in
                Group {
                    switch sheet {
                    case .devices:
                        DevicesBottomSheet()
                            .presentationDetents([.fraction(0.45)])
                    case .alerts:
                        AlertsBottomSheet()
                            .presentationDetents([.fraction(0.35)])
                    }
                }
                .presentationDragIndicator(.visible)
                .presentationBackground(Color(hex: "#F7F2FA"))
            }
        }
        .frame(alignment: .leading)
    }
        
}

enum ActiveSheet: Identifiable {
    case devices
    case alerts
    
    var id: Int { hashValue }
}

struct DevicesBottomSheet: View {
    
    var body: some View {
        VStack(spacing: 20) {
            DevicesBottomSheetRow(name: "ShareIcon", title: "Compartir dispositivo", subtitle: "")
            DevicesBottomSheetRow(name: "EditIcon", title: "Editar nombre", subtitle: "")
            DevicesBottomSheetRow(name: "LinkIcon", title: "Desvincular", subtitle: "")
            DevicesBottomSheetRow(name: "WifiIcon2", title: "Red Wifi", subtitle: "Red Casa_02")
        }
    }
}

struct DevicesBottomSheetRow: View {
    @State var name: String
    @State var title: String
    @State var subtitle: String
    
    var body: some View {
        HStack {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 20))
                if subtitle != "" {
                    Text(subtitle)
                        .font(.system(size: 14))
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct AlertsBottomSheet: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Configuración de alertas")
                .fontWeight(.bold)
            VStack(spacing: 10) {
                ForEach(MonitorCategory.allCases) { category in
                    AlertsBottomSheetRow(name: category.rawValue)
                }
            }
        }
        .frame(alignment: .leading)
    }
}

struct AlertsBottomSheetRow: View {
    @State var name: String
    
    var body: some View {
        HStack {
            Toggle(isOn: .constant(true)) {
                Text(name)
            }
        }
        .padding(.horizontal, 30)
    }
}
