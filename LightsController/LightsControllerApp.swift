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
}
