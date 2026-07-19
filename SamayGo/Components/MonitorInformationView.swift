//
//  MonitorInformationView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 9/07/26.
//

import SwiftUI

struct MonitorInformationView: View {
    let imageName: String
    let title: String
    let value: String
    let subtitle: String
    let color: String
    let isLoading: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
                .frame(height: 100)
            HStack(spacing: 16){
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: isLoading ? "#E6E6E6" : color))
                        .frame(width: 48, height: 48)
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                    Text(isLoading ? "Cargando..." : value)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    if subtitle != "" && !isLoading {
                        Text(subtitle)
                            .font(.system(size: 11))
                            .fontWeight(.light)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 40)
    }
}
