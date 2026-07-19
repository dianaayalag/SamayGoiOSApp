//
//  CategoryChip.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 11/07/26.
//

import SwiftUI

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(isSelected ? Color(hex: "#1D192B") : Color(hex: "#79747E"))
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(isSelected ? Color(hex: "#E8DEF8") : Color.clear)
                )
                .overlay(
                    Capsule()
                        .stroke(Color(hex: "#79747E").opacity(isSelected ? 0 : 0.6), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

enum MonitorCategory: String, CaseIterable, Identifiable  {
    case temperature = "Temperatura"
    case movement = "Movimiento"
    case noise = "Ruido"
    case presence = "Presencia en cuna"
    case position = "Posición"
    
    var id: String { rawValue }
}
