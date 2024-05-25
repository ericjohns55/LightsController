//
//  ApplicationData.swift
//  LightsController
//
//  Created by Eric Johns on 5/10/24.
//

import Foundation
import SwiftUI

enum Palette_OLD {
    case cloud, ocean, rainbow, rainbow_bands, sunset, pastel, sunset2, beach, hult, drywet, fire, magred, yelmag, yelblu, sakura, temperature, retro_clown, pink_candy, biflag, warm
}

struct Palette {
    var name: String
    var paletteID: Int
    var gradient: [Int]
}

struct Effect {
    var name: String
    var effectID: Int
}

class ApplicationData {
    static let toggle_lights: String = "TOGGLE_LIGHTS"
    
    static var palettes: [Palette] = []
    static var effects: [Effect] = []
    
    static var primaryIP: String = ""
    static var primaryServer: Bool = true
    static var secondaryIP: String = ""
    static var secondaryServer: Bool = false
    
    static var selectedConfig: AvailableStrip = .all
    static var stripConfig: StripConfig = .full
    static var serverConfig: ServerConfig = .primary
    
    static func setup() {
        populateArrays()
        loadSavedData()
    }
    
    static func loadSavedData() {
        let userDefaults = UserDefaults.standard
        
        primaryIP = userDefaults.string(forKey: "primaryIP") ?? "XXX.XX.X.XXX:XXXX"
        primaryServer = userDefaults.bool(forKey: "primaryServer")
        secondaryIP = userDefaults.string(forKey: "secondaryIP") ?? "XXX.XX.X.XXX:XXXX"
        secondaryServer = userDefaults.bool(forKey: "secondaryServer")
        
        selectedConfig = AvailableStrip.convert(identifier: userDefaults.integer(forKey: "selectedConfig"))
        stripConfig = StripConfig.convert(identifier: userDefaults.integer(forKey: "stripConfig"))
        serverConfig = ServerConfig.convert(identifier: userDefaults.integer(forKey: "serverConfig"))
        
        print("Loaded data: \(primaryIP) - \(String(primaryServer)); \(secondaryIP) - \(String(secondaryServer))")
        print("selectedConfig: \(selectedConfig); stripConfig: \(stripConfig); serverConfig - \(serverConfig)")
    }
    
    static func updateSavedData() {
        UserDefaults.standard.setValue(primaryIP, forKey: "primaryIP")
        UserDefaults.standard.setValue(primaryServer, forKey: "primaryServer")
        UserDefaults.standard.setValue(secondaryIP, forKey: "secondaryIP")
        UserDefaults.standard.setValue(secondaryServer, forKey: "secondaryServer")
        
        UserDefaults.standard.setValue(selectedConfig.rawValue, forKey: "selectedConfig")
        UserDefaults.standard.setValue(stripConfig.rawValue, forKey: "stripConfig")
        UserDefaults.standard.setValue(serverConfig.rawValue, forKey: "serverConfig")
    }
    
    static func populateArrays() {
        palettes.removeAll()
        effects.removeAll()
        
        print("Generating palettes...")
        
        palettes.append(Palette(name: "Analogous", paletteID: 18, gradient: [3, 0, 255, 23, 0, 255, 67, 0, 255, 142, 0, 45, 255, 0, 0]))
        palettes.append(Palette(name: "April Night", paletteID: 46, gradient: [1, 5, 45, 1, 5, 45, 5, 169, 175, 1, 5, 45, 1, 5, 45, 45, 175, 31, 1, 5, 45, 1, 5, 45, 249, 150, 5, 1, 5, 45, 1, 5, 45, 255, 92, 0, 1, 5, 45, 1, 5, 45, 223, 45, 72, 1, 5, 45, 1, 5, 45]))
        palettes.append(Palette(name: "Aqua Flash", paletteID: 63, gradient: [0, 0, 0, 57, 227, 233, 255, 255, 8, 255, 255, 255, 255, 255, 8, 57, 227, 233, 0, 0, 0]))
        palettes.append(Palette(name: "Atlantica", paletteID: 51, gradient: [0, 28, 112, 32, 96, 255, 0, 243, 45, 12, 95, 82, 25, 190, 95, 40, 170, 80]))
        palettes.append(Palette(name: "Aurora", paletteID: 50, gradient: [1, 5, 45, 0, 200, 23, 0, 255, 0, 0, 243, 45, 0, 135, 7, 1, 5, 45]))
        palettes.append(Palette(name: "Aurora 2", paletteID: 55, gradient: [17, 177, 13, 121, 242, 5, 25, 173, 121, 250, 77, 127, 171, 101, 221]))
        palettes.append(Palette(name: "Autumn", paletteID: 39, gradient: [26, 1, 1, 67, 4, 1, 118, 14, 1, 137, 152, 52, 113, 65, 1, 133, 149, 59, 137, 152, 52, 113, 65, 1, 139, 154, 46, 113, 13, 1, 55, 3, 1, 17, 1, 1, 17, 1, 1]))
        palettes.append(Palette(name: "Beach", paletteID: 22, gradient: [255, 252, 214, 255, 252, 214, 255, 252, 214, 190, 191, 115, 137, 141, 52, 112, 255, 205, 51, 246, 214, 17, 235, 226, 2, 193, 199, 0, 156, 174, 1, 101, 115, 1, 59, 71, 7, 131, 170, 1, 90, 151, 0, 56, 133]))
        palettes.append(Palette(name: "Beech", paletteID: 26, gradient: [1, 5, 0, 32, 23, 1, 161, 55, 1, 229, 144, 1, 39, 142, 74, 1, 4, 1]))
        palettes.append(Palette(name: "Blink Red", paletteID: 67, gradient: [1, 1, 1, 4, 1, 11, 10, 1, 3, 161, 4, 29, 255, 86, 123, 125, 16, 160, 35, 13, 223, 18, 2, 18]))
        palettes.append(Palette(name: "Breeze", paletteID: 15, gradient: [1, 6, 7, 1, 99, 111, 144, 209, 255, 0, 73, 82]))
        palettes.append(Palette(name: "C9", paletteID: 48, gradient: [184, 4, 0, 184, 4, 0, 144, 44, 2, 144, 44, 2, 4, 96, 2, 4, 96, 2, 7, 7, 88, 7, 7, 88]))
        palettes.append(Palette(name: "C9 2", paletteID: 52, gradient: [6, 126, 2, 6, 126, 2, 4, 30, 114, 4, 30, 114, 255, 5, 0, 255, 5, 0, 196, 57, 2, 196, 57, 2, 137, 85, 2, 137, 85, 2]))
        palettes.append(Palette(name: "C9 New", paletteID: 53, gradient: [255, 5, 0, 255, 5, 0, 196, 57, 2, 196, 57, 2, 6, 126, 2, 6, 126, 2, 4, 30, 114, 4, 30, 114]))
        palettes.append(Palette(name: "Candy", paletteID: 57, gradient: [229, 227, 1, 227, 101, 3, 40, 1, 80, 17, 1, 79, 0, 0, 45]))
        palettes.append(Palette(name: "Candy 2", paletteID: 70, gradient: [39, 33, 34, 4, 6, 15, 49, 29, 22, 224, 173, 1, 177, 35, 5, 4, 6, 15, 255, 114, 6, 224, 173, 1, 39, 33, 34, 1, 1, 1]))
        palettes.append(Palette(name: "Cloud", paletteID: 7, gradient: [0, 0, 255, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 255, 0, 0, 139, 135, 206, 235, 135, 206, 235, 173, 216, 230, 255, 255, 255, 173, 216, 230, 135, 206, 235]))
        palettes.append(Palette(name: "Cyane", paletteID: 37, gradient: [10, 85, 5, 29, 109, 18, 59, 138, 42, 83, 99, 52, 110, 66, 64, 123, 49, 65, 139, 35, 66, 192, 117, 98, 255, 255, 137, 100, 180, 155, 22, 121, 174]))
        palettes.append(Palette(name: "Departure", paletteID: 24, gradient: [8, 3, 0, 23, 7, 0, 75, 38, 6, 169, 99, 38, 213, 169, 119, 255, 255, 255, 135, 255, 138, 22, 255, 24, 0, 255, 0, 0, 136, 0, 0, 55, 0, 0, 55, 0]))
        palettes.append(Palette(name: "Drywet", paletteID: 30, gradient: [47, 30, 2, 213, 147, 24, 103, 219, 52, 3, 219, 207, 1, 48, 214, 1, 1, 111, 1, 7, 33]))
        palettes.append(Palette(name: "Fairy Reaf", paletteID: 59, gradient: [184, 1, 128, 1, 193, 182, 153, 227, 190, 255, 255, 255]))
        palettes.append(Palette(name: "Fire", paletteID: 35, gradient: [0, 0, 0, 18, 0, 0, 113, 0, 0, 142, 3, 1, 175, 17, 1, 213, 44, 2, 255, 82, 4, 255, 115, 4, 255, 156, 4, 255, 203, 4, 255, 255, 4, 255, 255, 71, 255, 255, 255]))
        palettes.append(Palette(name: "Forest", paletteID: 10, gradient: [0, 100, 0, 0, 100, 0, 85, 107, 47, 0, 100, 0, 0, 128, 0, 34, 139, 34, 107, 142, 35, 0, 128, 0, 46, 139, 87, 102, 205, 170, 50, 205, 50, 154, 205, 50, 144, 238, 144, 124, 252, 0, 102, 205, 170, 34, 139, 34]))
        palettes.append(Palette(name: "Grintage", paletteID: 32, gradient: [2, 1, 1, 18, 1, 0, 69, 29, 1, 167, 135, 10, 46, 56, 4]))
        palettes.append(Palette(name: "Hult", paletteID: 28, gradient: [247, 176, 247, 255, 136, 255, 220, 29, 226, 7, 82, 178, 1, 124, 109, 1, 124, 109]))
        palettes.append(Palette(name: "Hult 64", paletteID: 29, gradient: [1, 124, 109, 1, 93, 79, 52, 65, 1, 115, 127, 1, 52, 65, 1, 1, 86, 72, 0, 55, 45, 0, 55, 45]))
        palettes.append(Palette(name: "Icefire", paletteID: 36, gradient: [0, 0, 0, 0, 9, 45, 0, 38, 255, 3, 100, 255, 23, 199, 255, 100, 235, 255, 255, 255, 255]))
        palettes.append(Palette(name: "Jul", paletteID: 31, gradient: [194, 1, 1, 1, 29, 18, 57, 131, 28, 113, 1, 1]))
        palettes.append(Palette(name: "Landscape", paletteID: 25, gradient: [0, 0, 0, 2, 25, 1, 15, 115, 5, 79, 213, 1, 126, 211, 47, 188, 209, 247, 144, 182, 205, 59, 117, 250, 1, 37, 192]))
        palettes.append(Palette(name: "Lava", paletteID: 8, gradient: [0, 0, 0, 128, 0, 0, 0, 0, 0, 128, 0, 0, 139, 0, 0, 139, 0, 0, 128, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 255, 0, 0, 255, 165, 0, 255, 255, 255, 255, 165, 0, 255, 0, 0, 139, 0, 0]))
        palettes.append(Palette(name: "Light Pink", paletteID: 38, gradient: [19, 2, 39, 26, 4, 45, 33, 6, 52, 68, 62, 125, 118, 187, 240, 163, 215, 247, 217, 244, 255, 159, 149, 221, 113, 78, 188, 128, 57, 155, 146, 40, 123]))
        palettes.append(Palette(name: "Lite Light", paletteID: 65, gradient: [0, 0, 0, 1, 1, 1, 5, 5, 6, 5, 5, 6, 10, 1, 12, 0, 0, 0]))
        palettes.append(Palette(name: "Magenta", paletteID: 40, gradient: [0, 0, 0, 0, 0, 45, 0, 0, 255, 42, 0, 255, 255, 0, 255, 255, 55, 255, 255, 255, 255]))
        palettes.append(Palette(name: "Magred", paletteID: 41, gradient: [0, 0, 0, 42, 0, 45, 255, 0, 255, 255, 0, 45, 255, 0, 0]))
        palettes.append(Palette(name: "Ocean", paletteID: 9, gradient: [25, 25, 112, 0, 0, 139, 25, 25, 112, 0, 0, 128, 0, 0, 139, 0, 0, 205, 46, 139, 87, 0, 128, 128, 95, 158, 160, 0, 0, 255, 0, 139, 139, 100, 149, 237, 127, 255, 212, 46, 139, 87, 0, 255, 255, 135, 206, 250]))
        palettes.append(Palette(name: "Orange and Teal", paletteID: 44, gradient: [0, 150, 92, 0, 150, 92, 255, 72, 0, 255, 72, 0]))
        palettes.append(Palette(name: "Orangery", paletteID: 47, gradient: [255, 95, 23, 255, 82, 0, 223, 13, 8, 144, 44, 2, 255, 110, 17, 255, 69, 0, 158, 13, 11, 241, 82, 17, 213, 37, 4]))
        palettes.append(Palette(name: "Party", paletteID: 6, gradient: [85, 0, 171, 132, 0, 124, 181, 0, 75, 229, 0, 27, 232, 23, 0, 184, 71, 0, 171, 119, 0, 171, 171, 0, 171, 85, 0, 221, 34, 0, 242, 0, 14, 194, 0, 62, 143, 0, 113, 95, 0, 161, 47, 0, 208, 0, 7, 249]))
        palettes.append(Palette(name: "Pastel", paletteID: 20, gradient: [10, 62, 123, 56, 130, 103, 153, 225, 85, 199, 217, 68, 255, 207, 54, 247, 152, 57, 239, 107, 61, 247, 152, 57, 255, 207, 54, 255, 227, 48, 255, 248, 42]))
        palettes.append(Palette(name: "Pink Candy", paletteID: 61, gradient: [255, 255, 255, 7, 12, 255, 227, 1, 127, 227, 1, 127, 255, 255, 255, 227, 1, 127, 45, 1, 99, 255, 255, 255]))
        palettes.append(Palette(name: "Rainbow", paletteID: 11, gradient: [255, 0, 0, 213, 42, 0, 171, 85, 0, 171, 127, 0, 171, 171, 0, 86, 213, 0, 0, 255, 0, 0, 213, 42, 0, 171, 85, 0, 86, 170, 0, 0, 255, 42, 0, 213, 85, 0, 171, 127, 0, 129, 171, 0, 85, 213, 0, 43]))
        palettes.append(Palette(name: "Rainbow Bands", paletteID: 12, gradient: [255, 0, 0, 0, 0, 0, 171, 85, 0, 0, 0, 0, 171, 171, 0, 0, 0, 0, 0, 255, 0, 0, 0, 0, 0, 171, 85, 0, 0, 0, 0, 0, 255, 0, 0, 0, 85, 0, 171, 0, 0, 0, 171, 0, 85, 0, 0, 0]))
        palettes.append(Palette(name: "Red and Blue", paletteID: 16, gradient: [4, 1, 70, 55, 1, 30, 255, 4, 7, 59, 2, 29, 11, 3, 50, 39, 8, 60, 112, 19, 40, 78, 11, 39, 29, 8, 59]))
        palettes.append(Palette(name: "Red Flash", paletteID: 66, gradient: [0, 0, 0, 227, 1, 1, 249, 199, 95, 227, 1, 1, 0, 0, 0]))
        palettes.append(Palette(name: "Red Reaf", paletteID: 62, gradient: [3, 13, 43, 78, 141, 240, 255, 0, 0, 28, 1, 1]))
        palettes.append(Palette(name: "Red Shift", paletteID: 68, gradient: [31, 1, 27, 34, 1, 16, 137, 5, 9, 213, 128, 10, 199, 22, 1, 199, 9, 6, 1, 0, 1]))
        palettes.append(Palette(name: "Red Tide", paletteID: 69, gradient: [247, 5, 0, 255, 67, 1, 234, 88, 11, 234, 176, 51, 229, 28, 1, 113, 12, 1, 255, 225, 44, 113, 12, 1, 244, 209, 88, 255, 28, 1, 53, 1, 1]))
        palettes.append(Palette(name: "Retro Clown", paletteID: 56, gradient: [227, 101, 3, 194, 18, 19, 92, 8, 192]))
        palettes.append(Palette(name: "Rewhi", paletteID: 33, gradient: [113, 91, 147, 157, 88, 78, 208, 85, 33, 255, 29, 11, 137, 31, 39, 59, 33, 89]))
        palettes.append(Palette(name: "Rivendell", paletteID: 14, gradient: [1, 14, 5, 16, 36, 14, 56, 68, 30, 150, 156, 99, 150, 156, 99]))
        palettes.append(Palette(name: "Sakura", paletteID: 49, gradient: [196, 19, 10, 255, 69, 45, 223, 45, 72, 255, 82, 103, 223, 13, 17]))
        palettes.append(Palette(name: "Semi Blue", paletteID: 60, gradient: [0, 0, 0, 1, 1, 3, 8, 1, 22, 4, 6, 89, 2, 25, 216, 7, 10, 99, 15, 2, 31, 2, 1, 5, 0, 0, 0]))
        palettes.append(Palette(name: "Sherbet", paletteID: 27, gradient: [255, 33, 4, 255, 68, 25, 255, 7, 25, 255, 82, 103, 255, 255, 242, 42, 255, 22, 87, 255, 65]))
        palettes.append(Palette(name: "Splash", paletteID: 19, gradient: [126, 11, 255, 197, 1, 22, 210, 157, 172, 157, 3, 112, 157, 3, 112]))
        palettes.append(Palette(name: "Sunset", paletteID: 13, gradient: [120, 0, 0, 179, 22, 0, 255, 104, 0, 167, 22, 18, 100, 0, 103, 16, 0, 130, 0, 0, 160]))
        palettes.append(Palette(name: "Sunset 2", paletteID: 21, gradient: [110, 49, 11, 55, 34, 10, 22, 22, 9, 239, 124, 8, 220, 156, 27, 203, 193, 61, 33, 53, 56, 0, 1, 52]))
        palettes.append(Palette(name: "Temperature", paletteID: 54, gradient: [1, 27, 105, 1, 40, 127, 1, 70, 168, 1, 92, 197, 1, 119, 221, 3, 130, 151, 23, 156, 149, 67, 182, 112, 121, 201, 52, 142, 203, 11, 224, 223, 1, 252, 187, 2, 247, 147, 1, 237, 87, 1, 229, 43, 1, 171, 2, 2, 80, 3, 3, 80, 3, 3]))
        palettes.append(Palette(name: "Tertiary", paletteID: 34, gradient: [0, 1, 255, 3, 68, 45, 23, 255, 0, 100, 68, 1, 255, 1, 4]))
        palettes.append(Palette(name: "Tiamut", paletteID: 45, gradient: [1, 2, 14, 2, 5, 35, 13, 135, 92, 43, 255, 193, 247, 7, 249, 193, 17, 208, 39, 255, 154, 4, 213, 236, 39, 252, 135, 193, 213, 253, 255, 249, 255]))
        palettes.append(Palette(name: "Toxy Reaf", paletteID: 58, gradient: [1, 221, 53, 73, 3, 178]))
        palettes.append(Palette(name: "Vintage", paletteID: 23, gradient: [4, 1, 1, 16, 0, 1, 97, 104, 3, 255, 131, 19, 67, 9, 4, 16, 0, 1, 4, 1, 1, 4, 1, 1]))
        palettes.append(Palette(name: "Yelblu", paletteID: 43, gradient: [0, 0, 255, 0, 55, 255, 0, 255, 255, 42, 255, 45, 255, 255, 0]))
        palettes.append(Palette(name: "Yelblu Hot", paletteID: 64, gradient: [4, 2, 9, 16, 0, 47, 24, 0, 16, 144, 9, 1, 179, 45, 1, 220, 114, 2, 234, 237, 1]))
        palettes.append(Palette(name: "Yellowout", paletteID: 17, gradient: [188, 135, 1, 46, 7, 1]))
        palettes.append(Palette(name: "Yelmag", paletteID: 42, gradient: [0, 0, 0, 42, 0, 0, 255, 0, 0, 255, 0, 45, 255, 0, 255, 255, 55, 45, 255, 255, 0]))
        
        print("Generating effects...")
        
        effects.append(Effect(name: "Android", effectID: 27))
        effects.append(Effect(name: "Aurora", effectID: 38))
        effects.append(Effect(name: "BPM", effectID: 68))
        effects.append(Effect(name: "Blends", effectID: 115))
        effects.append(Effect(name: "Blink", effectID: 1))
        effects.append(Effect(name: "Blink Rainbow", effectID: 26))
        effects.append(Effect(name: "Bouncing Balls", effectID: 91))
        effects.append(Effect(name: "Breath", effectID: 2))
        effects.append(Effect(name: "Candle", effectID: 88))
        effects.append(Effect(name: "Candle Multi", effectID: 102))
        effects.append(Effect(name: "Chase", effectID: 28))
        effects.append(Effect(name: "Chase Flash", effectID: 31))
        effects.append(Effect(name: "Chase FlashRnd", effectID: 32))
        effects.append(Effect(name: "Chase Rainbow", effectID: 30))
        effects.append(Effect(name: "Chase Random", effectID: 29))
        effects.append(Effect(name: "Chunchun", effectID: 111))
        effects.append(Effect(name: "Circus", effectID: 52))
        effects.append(Effect(name: "Colorful", effectID: 34))
        effects.append(Effect(name: "Colorloop", effectID: 8))
        effects.append(Effect(name: "Colortwinkles", effectID: 74))
        effects.append(Effect(name: "Colorwaves", effectID: 67))
        effects.append(Effect(name: "Dissolve", effectID: 18))
        effects.append(Effect(name: "Drip", effectID: 96))
        effects.append(Effect(name: "Dual Scan", effectID: 11))
        effects.append(Effect(name: "Dynamic", effectID: 7))
        effects.append(Effect(name: "Fade", effectID: 12))
        effects.append(Effect(name: "Fill Noise", effectID: 69))
        effects.append(Effect(name: "Fire 2012", effectID: 66))
        effects.append(Effect(name: "Fire Flicker", effectID: 45))
        effects.append(Effect(name: "Fireworks", effectID: 42))
        effects.append(Effect(name: "Fireworks 1D", effectID: 90))
        effects.append(Effect(name: "Fireworks Star", effectID: 89))
        effects.append(Effect(name: "Flow", effectID: 110))
        effects.append(Effect(name: "Glitter", effectID: 87))
        effects.append(Effect(name: "Gradient", effectID: 46))
        effects.append(Effect(name: "Halloween Eyes", effectID: 82))
        effects.append(Effect(name: "Heartbeat", effectID: 100))
        effects.append(Effect(name: "ICU", effectID: 58))
        effects.append(Effect(name: "Juggle", effectID: 64))
        effects.append(Effect(name: "Lake", effectID: 75))
        effects.append(Effect(name: "Lighthouse", effectID: 41))
        effects.append(Effect(name: "Lightning", effectID: 57))
        effects.append(Effect(name: "Loading", effectID: 47))
        effects.append(Effect(name: "Meteor Smooth", effectID: 77))
        effects.append(Effect(name: "Meteor", effectID: 76))
        effects.append(Effect(name: "Multi Comet", effectID: 59))
        effects.append(Effect(name: "Noise Pal", effectID: 107))
        effects.append(Effect(name: "Noise1", effectID: 70))
        effects.append(Effect(name: "Noise2", effectID: 71))
        effects.append(Effect(name: "Noise3", effectID: 72))
        effects.append(Effect(name: "Noise4", effectID: 73))
        effects.append(Effect(name: "Oscillate", effectID: 62))
        effects.append(Effect(name: "Pacifica", effectID: 101))
        effects.append(Effect(name: "Palette", effectID: 65))
        effects.append(Effect(name: "Pattern", effectID: 83))
        effects.append(Effect(name: "Pattern Tri", effectID: 84))
        effects.append(Effect(name: "Percent", effectID: 98))
        effects.append(Effect(name: "Phased", effectID: 105))
        effects.append(Effect(name: "Phased Noise", effectID: 109))
        effects.append(Effect(name: "Plasma", effectID: 97))
        effects.append(Effect(name: "Popcorn", effectID: 95))
        effects.append(Effect(name: "Pride 2015", effectID: 63))
        effects.append(Effect(name: "Railway", effectID: 78))
        effects.append(Effect(name: "Rain", effectID: 43))
        effects.append(Effect(name: "Rainbow", effectID: 9))
        effects.append(Effect(name: "Rainbow Runner", effectID: 33))
        effects.append(Effect(name: "Random Colors", effectID: 5))
        effects.append(Effect(name: "Ripple Rainbow", effectID: 99))
        effects.append(Effect(name: "Ripple", effectID: 79))
        effects.append(Effect(name: "Running", effectID: 15))
        effects.append(Effect(name: "Running 2", effectID: 37))
        effects.append(Effect(name: "Saw", effectID: 16))
        effects.append(Effect(name: "Scan", effectID: 10))
        effects.append(Effect(name: "Scanner", effectID: 40))
        effects.append(Effect(name: "Scanner Dual", effectID: 60))
        effects.append(Effect(name: "Shadows", effectID: 112))
        effects.append(Effect(name: "Sine", effectID: 108))
        effects.append(Effect(name: "Sinelon", effectID: 92))
        effects.append(Effect(name: "Sinelon Dual", effectID: 93))
        effects.append(Effect(name: "Sinelon Rainbow", effectID: 94))
        effects.append(Effect(name: "Solid Glitter", effectID: 103))
        effects.append(Effect(name: "Sparkle", effectID: 20))
        effects.append(Effect(name: "Sparkle Dark", effectID: 21))
        effects.append(Effect(name: "Sparkle+", effectID: 22))
        effects.append(Effect(name: "Spots Fade", effectID: 86))
        effects.append(Effect(name: "Spots", effectID: 85))
        effects.append(Effect(name: "Stream", effectID: 39))
        effects.append(Effect(name: "Stream 2", effectID: 61))
        effects.append(Effect(name: "Strobe", effectID: 23))
        effects.append(Effect(name: "Strobe Mega", effectID: 25))
        effects.append(Effect(name: "Strobe Rainbow", effectID: 24))
        effects.append(Effect(name: "Sunrise", effectID: 104))
        effects.append(Effect(name: "Sweep", effectID: 6))
        effects.append(Effect(name: "Sweep Random", effectID: 36))
        effects.append(Effect(name: "TV Simulator", effectID: 116))
        effects.append(Effect(name: "Theater", effectID: 13))
        effects.append(Effect(name: "Theater Rainbow", effectID: 14))
        effects.append(Effect(name: "Traffic Light", effectID: 35))
        effects.append(Effect(name: "Tri Chase", effectID: 54))
        effects.append(Effect(name: "Tri Fade", effectID: 56))
        effects.append(Effect(name: "Tri Wipe", effectID: 55))
        effects.append(Effect(name: "Twinkle", effectID: 17))
        effects.append(Effect(name: "TwinkleUp", effectID: 106))
        effects.append(Effect(name: "Twinklecat", effectID: 81))
        effects.append(Effect(name: "Twinklefox", effectID: 80))
        effects.append(Effect(name: "Two Dots", effectID: 50))
        effects.append(Effect(name: "Washing Machine", effectID: 113))
        effects.append(Effect(name: "Wipe Random", effectID: 4))
        
        print("Done array generation.")
    }
    
    static func getGradientFromPalette(paletteName: String) -> Gradient {
        if (paletteName == "(None)") {
            return getGradientFromPalette(paletteName: "Party")
        }
        
        for palette in palettes {
            if (palette.name == paletteName) {
                return DataItemRow.gradientBuilder(colorValues: palette.gradient)
            }
        }
        
        return DataItemRow.gradientBuilder(colorValues: [255, 255, 255])
    }
    
    static func getPaletteColors(palette: Palette_OLD) -> [Int] {
        switch (palette) {
            case .cloud:
                return [0, 0, 255, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 139, 0, 0, 255, 0, 0, 139, 135, 206, 235, 135, 206, 235, 173, 216, 230, 255, 255, 255, 173, 216, 230, 135, 206, 235]
            case .ocean:
                return [25, 25, 112, 0, 0, 139, 25, 25, 112, 0, 0, 128, 0, 0, 139, 0, 0, 205, 46, 139, 87, 0, 128, 128, 95, 158, 160, 0, 0, 255, 0, 139, 139, 100, 149, 237, 127, 255, 212, 46, 139, 87, 0, 255, 255, 135, 206, 250]
            case .rainbow:
                return [255, 0, 0, 213, 42, 0, 171, 85, 0, 171, 127, 0, 171, 171, 0, 86, 213, 0, 0, 255, 0, 0, 213, 42, 0, 171, 85, 0, 87, 170, 0, 0, 255, 42, 0, 213, 85, 0, 171, 127, 0, 129, 171, 0, 85, 213, 0, 43]
            case .rainbow_bands:
                return [255, 0, 0, 0, 0, 0, 171, 85, 0, 0, 0, 0, 171, 171, 0, 0, 0, 0, 0, 255, 0, 0, 0, 0, 0, 171, 85, 0, 0, 0, 0, 0, 255, 0, 0, 0, 85, 0, 171, 0, 0, 0, 171, 0, 85, 0, 0, 0]
            case .sunset:
                return [120, 0, 0, 179, 22, 0, 255, 104, 0, 167, 22, 18, 100, 0, 103, 16, 0, 130, 0, 0, 160]
            case .pastel:
                return [10, 62, 123, 56, 130, 103, 153, 225, 85, 199, 217, 68, 255, 207, 54, 247, 152, 57, 239, 107, 61, 247, 152, 57, 255, 207, 54, 255, 227, 48, 255, 248, 42]
            case .sunset2:
                return [110, 49, 11, 55, 34, 10, 22, 22, 9, 239, 124, 8, 220, 156, 27, 203, 193, 61, 33, 53, 56, 0, 1, 52]
            case .beach:
                return [1, 5, 0, 32, 23, 1, 161, 55, 1, 229, 144, 1, 39, 142, 74, 1, 4, 1]
            case .hult:
                return [247, 176, 247, 255, 136, 255, 220, 29, 226, 7, 82, 178, 1, 124, 109, 1, 124, 109]
            case .drywet:
                return [47, 30, 2, 213, 147, 24, 103, 219, 52, 3, 219, 207, 1, 48, 214, 1, 1, 111, 1, 7, 33]
            case .fire:
                return [0, 0, 0, 18, 0, 0, 113, 0, 0, 142, 3, 1, 175, 17, 1, 213, 44, 2, 255, 82, 4, 255, 115, 4, 255, 156, 4, 255, 203, 4, 255, 255, 4, 255, 255, 71, 255, 255, 255]
            case .magred:
                return [0, 0, 0, 42, 0, 45, 255, 0, 255, 255, 0, 45, 255, 0, 0]
            case .yelmag:
                return [0, 0, 0, 42, 0, 0, 255, 0, 0, 255, 0, 45, 255, 0, 255, 255, 55, 45, 255, 255, 0]
            case .yelblu:
                return [0, 0, 255, 0, 55, 255, 0, 255, 255, 42, 255, 45, 255, 255, 0]
            case .sakura:
                return [196, 19, 10, 255, 69, 45, 223, 45, 72, 255, 82, 103, 223, 13, 17]
            case .temperature:
                return [1, 27, 105, 1, 40, 127, 1, 70, 168, 1, 92, 197, 1, 119, 221, 3, 130, 151, 23, 156, 149, 67, 182, 112, 121, 201, 52, 142, 203, 11, 224, 223, 1, 252, 187, 2, 247, 147, 1, 237, 87, 1, 229, 43, 1, 171, 2, 2, 80, 3, 3, 80, 3, 3]
            case .retro_clown:
                return [227, 101, 3, 194, 18, 19, 92, 8, 192]
            case .pink_candy:
                return [255, 255, 255, 7, 12, 255, 227, 1, 127, 227, 1, 127, 255, 255, 255, 227, 1, 127, 45, 1, 99, 255, 255, 255];
            case .biflag:
                return [215, 0, 113, 156, 78, 151, 0, 53, 170]
            case .warm:
                return [255, 0, 0, 255, 0, 255, 255, 200, 0]
        }
    }
}
