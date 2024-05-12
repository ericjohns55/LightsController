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

    static func getDataItems(dataType: DataType) -> [DataItem] {
        var dataItems: [DataItem] = []
        
        if dataType == DataType.color {
            dataItems.append(DataItem(textField: "Toggle Lights", urlArgs: "*T=2", gradient: gradientBuilder(colorValues: [255, 0, 0, 255, 0, 0, 0, 255, 0, 0, 255, 0])))
            dataItems.append(DataItem(textField: "Red", urlArgs: "*FX=0*R=255*G=0*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 0, 0])))
            dataItems.append(DataItem(textField: "Orange", urlArgs: "*FX=0*R=255*G=100*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 100, 0])))
            dataItems.append(DataItem(textField: "Yellow", urlArgs: "*FX=0*R=255*G=200*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 200, 0])))
            dataItems.append(DataItem(textField: "Green", urlArgs: "*FX=0*R=8*G=255*B=0*T=1", gradient: gradientBuilder(colorValues: [8, 255, 0])))
            dataItems.append(DataItem(textField: "Cyan", urlArgs: "*FX=0*R=05*G=255*B=200*T=1", gradient: gradientBuilder(colorValues: [0, 255, 255])))
            dataItems.append(DataItem(textField: "Blue", urlArgs: "*FX=0*R=0*G=0*B=255*T=1", gradient: gradientBuilder(colorValues: [0, 0, 255])))
            dataItems.append(DataItem(textField: "Pink", urlArgs: "*FX=0*R=255*G=0*B=255*T=1", gradient: gradientBuilder(colorValues: [255, 0, 255])))
            dataItems.append(DataItem(textField: "Natural Light", urlArgs: "*FX=0*R=255*G=197*B=147*T=1", gradient: gradientBuilder(colorValues: [255, 197, 147])))
            dataItems.append(DataItem(textField: "White", urlArgs: "*FX=0*R=255*G=255*B=255*T=1", gradient: gradientBuilder(colorValues: [255, 255, 255]), last: true))
        } else if dataType == DataType.effect {
            dataItems.append(DataItem(textField: "Aurora", urlArgs: "*FX=38*FP=4*SX=16*IX=255*CL=16711680*C2=16711935*C3=16762880*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .warm))))
            dataItems.append(DataItem(textField: "Blends", urlArgs: "*FX=115*FP=35*SX=73*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .fire))))
            dataItems.append(DataItem(textField: "Bouncing Balls", urlArgs: "*FX=91*FP=26*SX=80*IX=128*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .beach)))) 
            dataItems.append(DataItem(textField: "Chase", urlArgs: "*FX=28*FP=26*SX=80*IX=128*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .beach)))) 
            dataItems.append(DataItem(textField: "Colortwinkles", urlArgs: "*FX=74*FP=43*SX=17*IX=65*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .yelblu)))) 
            dataItems.append(DataItem(textField: "Fireworks", urlArgs: "*FX=89*FP=49*SX=0*IX=128*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .sakura)))) 
            dataItems.append(DataItem(textField: "Lake", urlArgs: "*FX=75*FP=30*SX=66*IX=128*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .drywet)))) 
            dataItems.append(DataItem(textField: "Plasma", urlArgs: "*FX=97*FP=41*SX=93*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .magred)))) 
            dataItems.append(DataItem(textField: "Pride 2015", urlArgs: "*FX=63*FP=11*SX=0*IX=190*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .rainbow)))) 
            dataItems.append(DataItem(textField: "Rainbow", urlArgs: "*FX=9*FP=11*SX=8*IX=128*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .rainbow)))) 
            dataItems.append(DataItem(textField: "Ripple", urlArgs: "*FX=99*FP=61*SX=64*IX=64*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .pink_candy)))) 
            dataItems.append(DataItem(textField: "Saw", urlArgs: "*FX=16*FP=13*SX=80*IX=128*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .sunset)))) 
            dataItems.append(DataItem(textField: "Shadows ", urlArgs: "*FX=112*FP=56*SX=112*IX=128*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .retro_clown)), last: true))
        } else if dataType == DataType.palette {
            dataItems.append(DataItem(textField: "Beach", urlArgs: "*FP=26*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .beach))))
            dataItems.append(DataItem(textField: "Biflag", urlArgs: "*FP=4*CL=14090353*C2=10243735*C3=13738*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .biflag))))
            dataItems.append(DataItem(textField: "Clouds", urlArgs: "*FP=7*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .cloud))))
            dataItems.append(DataItem(textField: "Fire", urlArgs: "*FP=35*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .fire))))
            dataItems.append(DataItem(textField: "Hult", urlArgs: "*FP=28*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .hult))))
            dataItems.append(DataItem(textField: "Magred", urlArgs: "*FP=41*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .magred))))
            dataItems.append(DataItem(textField: "Ocean", urlArgs: "*FP=9*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .ocean))))
            dataItems.append(DataItem(textField: "Pastel", urlArgs: "*FP=20*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .pastel))))
            dataItems.append(DataItem(textField: "Pink Candy", urlArgs: "*FP=61*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .pink_candy))))
            dataItems.append(DataItem(textField: "Rainbow", urlArgs: "*FP=11*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .rainbow))))
            dataItems.append(DataItem(textField: "Rainbow Bands", urlArgs: "*FP=12*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .rainbow_bands))))
            dataItems.append(DataItem(textField: "Retro Clown", urlArgs: "*FP=56*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .retro_clown))))
            dataItems.append(DataItem(textField: "Sakura", urlArgs: "*FP=49*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .sakura))))
            dataItems.append(DataItem(textField: "Sunset", urlArgs: "*FP=13*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .sunset))))
            dataItems.append(DataItem(textField: "Sunset 2", urlArgs: "*FP=21*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .sunset2))))
            dataItems.append(DataItem(textField: "Temperature", urlArgs: "*FP=54*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .temperature))))
            dataItems.append(DataItem(textField: "Warm", urlArgs: "*FP=4*CL=16711680*C2=16711935*C3=16762880*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .warm))))
            dataItems.append(DataItem(textField: "Yelblu", urlArgs: "*FP=43*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .yelblu))))
            dataItems.append(DataItem(textField: "Yelmag", urlArgs: "*FP=42*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .yelmag)), last: true))
        } else if dataType == DataType.testData {
            dataItems.append(DataItem(textField: "Sunset", urlArgs: "*FP=13*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .sunset))))
            dataItems.append(DataItem(textField: "Rainbow Bands", urlArgs: "*FP=12*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .rainbow_bands))))
            dataItems.append(DataItem(textField: "Retro Clown", urlArgs: "*FP=20*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .retro_clown))))
            dataItems.append(DataItem(textField: "Fire", urlArgs: "*FP=35*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .fire))))
            dataItems.append(DataItem(textField: "Pink Candy", urlArgs: "*FP=61*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .pink_candy))))
            dataItems.append(DataItem(textField: "Yelmag", urlArgs: "*FP=42*CL=0*C2=0*C3=0*T=1", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .yelmag)), last: true))
        }
        
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
        
        // append first value again for smooth gradient
        // colorList.append(colorList[0])
        
        return Gradient(colors: colorList)
    }
}

#Preview {
    DataItemRow(dataItem: DataItemRow.getDataItems(dataType: DataType.testData)[0])
}
