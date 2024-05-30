//
//  LightsControllerApp.swift
//  LightsController
//
//  Created by Eric Johns on 5/2/24.
//

import SwiftUI

enum AvailableStrip: Int {
    case all = 0
    case main = 1
    case tapestry = 2
    
    static func convert(identifier: Int) -> AvailableStrip {
        if (identifier == 0) { return .all }
        else if (identifier == 1) { return .main }
        else { return .tapestry }
    }
}

enum StripConfig: Int {
    case left = 0
    case right = 1
    case full = 2
    
    static func convert(identifier: Int) -> StripConfig {
        if (identifier == 0) { return .left }
        else if (identifier == 1) { return .right }
        else { return .full }
    }
}

enum ServerConfig: Int {
    case primary = 0
    case secondary = 1
    
    static func convert(identifier: Int) -> ServerConfig {
        return (identifier == 0) ? .primary : .secondary
    }
}

@main
struct LightsControllerApp: App {
    init() {
        ApplicationData.setup()
    }
    
    var body: some Scene {
        // https://stackoverflow.com/questions/68952701/passing-variables-between-views-swiftui
        
        WindowGroup {
            ControllerView()
        }
    }
    
    static func requestController(urlArgs: String) {
        var fullURLString: String
        
        let serverIP = (ApplicationData.serverConfig == .primary) ? ApplicationData.primaryIP : ApplicationData.secondaryIP
        
        if ((ApplicationData.serverConfig == .primary && ApplicationData.primaryServer) || (ApplicationData.serverConfig == .secondary && ApplicationData.secondaryServer)) {
            
            if (urlArgs == ApplicationData.toggle_lights) {
                fullURLString = "\(serverIP)/?lights=0"
            } else {
                var physicalConfig: Int = 0
                
                if (ApplicationData.selectedConfig == .main) {
                    physicalConfig = 1
                } else if (ApplicationData.selectedConfig == .tapestry) {
                    physicalConfig = 2
                }
                
                var stripSide: String = ""
                
                if (ApplicationData.stripConfig == .left) {
                    stripSide = "*S=0*S2=300"
                } else if (ApplicationData.stripConfig == .right) {
                    stripSide = "*S=300*S2=600"
                } else {
                    stripSide = "*S=0*S2=600"
                }
                
                fullURLString = "\(serverIP)/?strip_num=\(physicalConfig)&data=(\(urlArgs)\(stripSide))"
            }
        } else {
            fullURLString = "\(serverIP)/win\(urlArgs.replacingOccurrences(of: "*", with: "&"))"
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
        var brightness: Float = 128
        
        for item in urlArgs.split(separator: "*") {
            if (item.starts(with: "SX=")) {
                speed = Float(item.replacingOccurrences(of: "SX=", with: "")) ?? 128
                ApplicationData.lastSpeed = speed
            } else if (item.starts(with: "IX=")) {
                intensity = Float(item.replacingOccurrences(of: "IX=", with: "")) ?? 128
                ApplicationData.lastIntensity = intensity
            } else if (item.starts(with: "A=")) {
                brightness = Float(item.replacingOccurrences(of: "A=", with: "")) ?? 128
                ApplicationData.lastBrightness = brightness
            }
        }
        
        ApplicationData.updateSavedData()
        
        return [speed, intensity, brightness]
    }
}
