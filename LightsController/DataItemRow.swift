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
    var last: Bool = false
    var hasGradient: Bool = true
}

enum DataType {
    case color, effect, palette
}

struct DataItemRow: View {
    var dataItem: DataItem
    
    var body: some View {
        HStack {
            VStack {
                Text(dataItem.textField)
                    .font(.system(size: 24))
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if (dataItem.hasGradient) {
                    HStack {
                        GeometryReader { metrics in
                            Rectangle()
                                .frame(width: metrics.size.width, height: metrics.size.height * 0.25)
                                .foregroundStyle(LinearGradient(gradient: dataItem.gradient, startPoint: .leading, endPoint: .trailing))
                        }
                    }
                }
            }
        }
    }

    static func getDataItems(dataType: DataType) -> [DataItem] {
        var dataItems: [DataItem] = []
        
        if dataType == DataType.color {
            for color in ApplicationData.solidColors {
                
                var urlArgs = "*FX=0*R=\(color.gradient[0])*G=\(color.gradient[1])*B=\(color.gradient[2])*T=1"
                
                if (color.name == "Toggle Lights") {
                    urlArgs = "*T=2"
                }
                    
                dataItems.append(DataItem(textField: color.name, urlArgs: urlArgs, gradient: gradientBuilder(colorValues: color.gradient)))
            }
        } else if dataType == DataType.effect {
            for effect in ApplicationData.effects {
                dataItems.append(DataItem(textField: effect.name, urlArgs: "*FX=\(effect.effectID)*T=1", gradient: gradientBuilder(colorValues: [255, 255, 255]), hasGradient: false))
            }
        } else if dataType == DataType.palette {
            for palette in ApplicationData.palettes {
                dataItems.append(DataItem(textField: palette.name, urlArgs: "*FP=\(palette.paletteID)*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: palette.gradient)))
            }
        }        

        dataItems[dataItems.count - 1].last = true
        
        return dataItems
    }

    static func gradientBuilder(colorValues: [Int]) -> Gradient {
        if (colorValues.count % 3 != 0 || colorValues.count == 0) {
            return Gradient(colors: [Color.black])
        }
        
        var colorList: [Color] = []
        
        for i in 0..<(colorValues.count / 3) {
            colorList.append(Color(red: Double(colorValues[i * 3])/255.0, green: Double(colorValues[(i * 3) + 1])/255.0, blue: Double(colorValues[(i * 3) + 2])/255.0))
        }
        
        return Gradient(colors: colorList)
    }
}

#Preview {
    DataItemRow(dataItem: DataItemRow.getDataItems(dataType: DataType.palette)[0])
}
