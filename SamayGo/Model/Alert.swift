//
//  Alert.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 11/07/26.
//

import Foundation
import SwiftUI

enum AlertSeverity {
    case low        // azul - información/leve (por debajo del rango)
    case high        // rojo - crítico (por encima del rango / riesgo alto)
    case warning     // naranja - advertencia (movimiento, ruido, cuna, posición)

    var color: Color {
        switch self {
        case .low: return Color(hex: "#0A84FF")
        case .high: return Color(hex: "#FF453A")
        case .warning: return Color(hex: "#FF9F0A")
        }
    }
}

struct MonitorAlert: Identifiable {
    let id = UUID()
    let category: MonitorCategory
    let title: String
    let value: String
    let subtitle: String
    let date: Date
    let severity: AlertSeverity

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy; h:mm a"
        formatter.locale = Locale(identifier: "es_PE")
        return formatter.string(from: date).lowercased()
    }
}
