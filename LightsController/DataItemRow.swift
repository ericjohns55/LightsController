//
//  DataItemRow.swift
//  LightsController
//
//  Created by Eric Johns on 5/2/24.
//

import SwiftUI

struct DataItem {
    let id = UUID()
    var textField: String
    var urlArgs: String
    var gradient: Gradient
}

enum DataType {
    case color, effect, palette
}

struct DataItemRow: View {
    var dataItem: DataItem
    
    var body: some View {
        HStack {
            Group {
                Text("")
                
                Circle()
                    .frame(width: 64.0, height: 64.0)
                    .foregroundStyle(AngularGradient(gradient: dataItem.gradient, center: .center))
                    .padding(10.0)
            }
            
            Text(dataItem.textField)
                .font(.system(size: 24.0))
                .padding(10.0)
            
            Spacer()
        }
    }
}

#Preview {
    DataItemRow(dataItem: LightsControllerApp.getDataItems(dataType: DataType.palette)[0])
}
