//
//  LightsControllerApp.swift
//  LightsController
//
//  Created by Eric Johns on 5/2/24.
//

import SwiftUI

@main
struct LightsControllerApp: App {
    static let serverIP: String = "http://172.31.1.138:8081"
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    static func getDataItems(dataType: DataType) -> [DataItem] {
        var dataItems: [DataItem] = []
        
        if dataType == DataType.color {
            dataItems.append(DataItem(textField: "Turn off Strip", urlArgs: "*T=0", gradient: gradientBuilder(colorValues: [0, 0, 0])))
            dataItems.append(DataItem(textField: "Red", urlArgs: "*FX=0*R=255*G=0*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 0, 0])))
            dataItems.append(DataItem(textField: "Orange", urlArgs: "*FX=0*R=255*G=100*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 100, 0])))
            dataItems.append(DataItem(textField: "Yellow", urlArgs: "*FX=0*R=255*G=200*B=0*T=1", gradient: gradientBuilder(colorValues: [255, 200, 0])))
            dataItems.append(DataItem(textField: "Green", urlArgs: "*FX=0*R=8*G=255*B=0*T=1", gradient: gradientBuilder(colorValues: [8, 255, 0])))
            dataItems.append(DataItem(textField: "Cyan", urlArgs: "*FX=0*R=05*G=255*B=200*T=1", gradient: gradientBuilder(colorValues: [0, 255, 255])))
            dataItems.append(DataItem(textField: "Blue", urlArgs: "*FX=0*R=0*G=0*B=255*T=1", gradient: gradientBuilder(colorValues: [0, 0, 255])))
            dataItems.append(DataItem(textField: "Pink", urlArgs: "*FX=0*R=255*G=0*B=255*T=1", gradient: gradientBuilder(colorValues: [255, 0, 255])))
            dataItems.append(DataItem(textField: "Natural Light", urlArgs: "*FX=0*R=255*G=197*B=147*T=1", gradient: gradientBuilder(colorValues: [255, 197, 147])))
            dataItems.append(DataItem(textField: "White", urlArgs: "*FX=0*R=255*G=255*B=255*T=1", gradient: gradientBuilder(colorValues: [255, 255, 255])))
        } else if dataType == DataType.palette {
            dataItems.append(DataItem(textField: "Retro Clown", urlArgs: "&fire", gradient: gradientBuilder(colorValues: ApplicationData.getPaletteColors(palette: .cloud))))
            // https://github.com/Aircoookie/WLED/blob/main/wled00/palettes.h
        }
        
        return dataItems
    }
    
    static func requestController(urlArgs: String) {
        let fullURLString: String = "\(serverIP)/?strip_num=0&data=(\(urlArgs))"
        let url = URL(string: fullURLString)!
        
        print("Requesting url: \"\(fullURLString)\"")
        
        let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let responseCode = response as? HTTPURLResponse {
                if responseCode.statusCode == 200 {
                    print("Success.")
                }
            }
        }
        
        request.resume()
    }
    
    static func gradientBuilder(colorValues: [Int]) -> Gradient {
        if (colorValues.count % 3 != 0 || colorValues.count == 0) {
            return Gradient(colors: [Color.black])
        }
        
        var colorList: [Color] = []
        
        for i in 0..<(colorValues.count / 3) {
            print("Generating gradient: [\(colorValues[i * 3]), \(colorValues[i * 3 + 1]), \(colorValues[i * 3 + 2])]")
            colorList.append(Color(red: Double(colorValues[i * 3])/255.0, green: Double(colorValues[(i * 3) + 1])/255.0, blue: Double(colorValues[(i * 3) + 2])/255.0))
        }
        
        // append first value again for smooth gradient
        colorList.append(colorList[0])
        
        return Gradient(colors: colorList)
    }
}
