//
//  LightsControllerApp.swift
//  LightsController
//
//  Created by Eric Johns on 5/2/24.
//

import SwiftUI

enum AvailableStrip {
    case all, main, tapestry
}

enum StripConfig {
    case left, right, full
}

enum ServerConfig {
    case primary, secondary
}

@main
struct LightsControllerApp: App {
    static let serverIP: String = "http://172.31.1.138:8081"
    
    static var selectedConfig: AvailableStrip = .all
    static var stripConfig: StripConfig = .full
    static var serverConfig: ServerConfig = .primary
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    static func requestController(urlArgs: String) {
        var fullURLString: String
        
        if (urlArgs == ApplicationData.toggle_lights) {
            fullURLString = "\(serverIP)/?lights=0"
        } else {
            var physicalConfig: Int = 0
            
            if (selectedConfig == .main) {
                physicalConfig = 1
            } else if (selectedConfig == .tapestry) {
                physicalConfig = 2
            }
            
            var stripSide: String = ""
            
            if (stripConfig == .left) {
                stripSide = "*S=0*S2=300"
            } else if (stripConfig == .right) {
                stripSide = "*S=300*S2=600"
            } else {
                stripSide = "*S=0*S2=600"
            }
            
            fullURLString = "\(serverIP)/?strip_num=\(physicalConfig)&data=(\(urlArgs)\(stripSide)"
        }
        
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
    
    static func extractModifiers(urlArgs: String) -> [Float] {
        var speed: Float = 128
        var intensity: Float = 128
        
        for item in urlArgs.split(separator: "*") {
            if (item.starts(with: "SX=")) {
                speed = Float(item.replacingOccurrences(of: "SX=", with: "")) ?? 128
            } else if (item.starts(with: "IX=")) {
                intensity = Float(item.replacingOccurrences(of: "IX=", with: "")) ?? 128
            }
        }
        
        return [speed, intensity]
    }
}
