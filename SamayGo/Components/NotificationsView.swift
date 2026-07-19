//
//  NotificationsView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 11/07/26.
//

import SwiftUI

struct NotificationsView: View {
    
    @State private var fromDate: Date?
    @State private var toDate: Date?
    
    @State private var selectedCategory: MonitorCategory?
    
    @State private var alerts: [MonitorAlert] = NotificationsView.mockAlerts
    
    private var filteredAlerts: [MonitorAlert] {
        guard let selectedCategory else { return alerts }
        return alerts.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        
        ZStack {
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
            
            VStack(spacing: 10) {
                dateFilters
                    .padding(.horizontal)
                    .padding(.top)
                filtersStrip
                alertsTable
                Spacer()
            }
        }
        .background(Color(hex: "#FCFDFF"))
        
    }
    
    var dateFilters: some View {
        HStack {
            DateFilterField(placeholder:"Desde", date: $fromDate)
            DateFilterField(placeholder:"Hasta", date: $toDate)
        }
    }
    
    var filtersStrip: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(MonitorCategory.allCases) { category in
                    CategoryChip(
                        title: category.rawValue,
                        isSelected: selectedCategory == category
                    ) {
                        if selectedCategory == category {
                            selectedCategory = nil
                        } else {
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    var alertsTable: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Hoy")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color(hex: "#322222"))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                ForEach(filteredAlerts) { alert in
                    AlertCardView(alert: alert)
                        .padding(.horizontal, 20)
                }
            }
            .padding(.bottom, 30)
        }
    }
    
    static let mockAlerts: [MonitorAlert] = [
        MonitorAlert(category: .temperature, title: "Temperatura ambiental", value: "19 °C",
                     subtitle: "Por debajo del rango recomendado (20 °C–22 °C)",
                     date: Date(), severity: .low),
        MonitorAlert(category: .temperature, title: "Temperatura ambiental", value: "24 °C",
                     subtitle: "Por encima del rango recomendado (20 °C–22 °C)",
                     date: Date(), severity: .high),
        MonitorAlert(category: .movement, title: "Movimiento", value: "Inusual",
                     subtitle: "Verifica el estado del bebé",
                     date: Date(), severity: .warning),
        MonitorAlert(category: .noise, title: "Ruido", value: "Ruido elevado",
                     subtitle: "Verifica el estado del bebé",
                     date: Date(), severity: .warning),
        MonitorAlert(category: .presence, title: "Presencia en cuna", value: "Fuera de la cuna",
                     subtitle: "Verifica la ubicación del bebé",
                     date: Date(), severity: .warning),
        MonitorAlert(category: .position, title: "Posición", value: "Posición de riesgo",
                     subtitle: "Reacomoda al bebé para una posición segura",
                     date: Date(), severity: .warning)
    ]
}
