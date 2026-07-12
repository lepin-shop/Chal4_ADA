//
//  OrderSegment.swift
//  Chal4_ADA
//
//  Created by Olifian Lepin on 11/07/26.
//

import SwiftUI

enum OrderPageSegment: String, CaseIterable {
    case myOrder = "Diproses"
    case done = "Selesai"
    
    var id: Self { self }
}

struct OrderSegmentControl: View {
    @Binding var currentOrderFilter: OrderPageSegment

    var body: some View {
        VStack {
            Picker("Your Posts Filter", selection: $currentOrderFilter) {
                Text("Diproses").tag(OrderPageSegment.myOrder)
                Text("Selesai").tag(OrderPageSegment.done)
            }
            .pickerStyle(.segmented)
        }
    }
}
