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
    var imageName: String = ""
    var circleColor: Color = Color(red: 0.0, green: 0.0, blue: 0.0)
    var dataType: DataType = .color
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
                
                if dataItem.dataType == .color {
                    Circle()
                        .frame(width: 64.0, height: 64.0)
                        .foregroundStyle(dataItem.circleColor)
                        .padding(10.0)
                } else if dataItem.dataType == .effect {
                    Circle()
                        .frame(width: 64.0, height: 64.0)
                        .foregroundStyle(AngularGradient(gradient: LightsControllerApp.gradientBuilder(colorValues: [227, 101, 3, 194, 18, 19, 92, 8, 192]), center: .center))
                        .padding(10.0)
                    
                }
            }
            
            Text(dataItem.textField)
                .font(.system(size: 24.0))
                .padding(10.0)
            
            Spacer()
        }
    }
}

#Preview {
    DataItemRow(dataItem: LightsControllerApp.getDataItems(dataType: DataType.effect)[0])
}
