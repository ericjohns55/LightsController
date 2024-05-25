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
    case color, effect, palette, testData
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
            dataItems.append(DataItem(textField: "Toggle Lights", urlArgs: "*T=2", gradient: gradientBuilder(colorValues: [255, 0, 0, 255, 0, 0, 0, 255, 0, 0, 255, 0])))
            dataItems.append(DataItem(textField: "Red", urlArgs: "*FX=0*R=255*G=0*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 0, 0])))
            dataItems.append(DataItem(textField: "Orange", urlArgs: "*FX=0*R=255*G=100*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 100, 0])))
            dataItems.append(DataItem(textField: "Yellow", urlArgs: "*FX=0*R=255*G=200*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 200, 0])))
            dataItems.append(DataItem(textField: "Green", urlArgs: "*FX=0*R=8*G=255*B=0*T=1", gradient: gradientBuilder(colorValues: [8, 255, 0])))
            dataItems.append(DataItem(textField: "Cyan", urlArgs: "*FX=0*R=0*G=255*B=255*T=1", gradient: gradientBuilder(colorValues: [0, 255, 255])))
            dataItems.append(DataItem(textField: "Blue", urlArgs: "*FX=0*R=0*G=0*B=255*T=1", gradient: gradientBuilder(colorValues: [0, 0, 255])))
            dataItems.append(DataItem(textField: "Pink", urlArgs: "*FX=0*R=255*G=0*B=255*T=1", gradient: gradientBuilder(colorValues: [255, 0, 255])))
            dataItems.append(DataItem(textField: "Natural Light", urlArgs: "*FX=0*R=255*G=197*B=147*T=1", gradient: gradientBuilder(colorValues: [255, 197, 147])))
            dataItems.append(DataItem(textField: "White", urlArgs: "*FX=0*R=255*G=255*B=255*T=1", gradient: gradientBuilder(colorValues: [255, 255, 255])))
        } else if dataType == DataType.effect {
            for effect in ApplicationData.effects {
                dataItems.append(DataItem(textField: effect.name, urlArgs: "*FX=\(effect.effectID)", gradient: gradientBuilder(colorValues: [255, 255, 255]), hasGradient: false))
            }
        } else if dataType == DataType.palette {
            for palette in ApplicationData.palettes {
                dataItems.append(DataItem(textField: palette.name, urlArgs: "*FP=\(palette.paletteID)*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: palette.gradient)))
            }
        } else if dataType == DataType.testData {
            dataItems.append(DataItem(textField: "Sunset", urlArgs: "*FP=13*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .sunset))))
            dataItems.append(DataItem(textField: "Rainbow Bands", urlArgs: "*FP=12*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .rainbow_bands))))
            dataItems.append(DataItem(textField: "Retro Clown", urlArgs: "*FP=20*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .retro_clown))))
            dataItems.append(DataItem(textField: "Fire", urlArgs: "*FP=35*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .fire))))
            dataItems.append(DataItem(textField: "Pink Candy", urlArgs: "*FP=61*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .pink_candy))))
            dataItems.append(DataItem(textField: "Yelmag", urlArgs: "*FP=42*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .yelmag)), last: true))
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
    DataItemRow(dataItem: DataItemRow.getDataItems(dataType: DataType.effect)[0])
}
