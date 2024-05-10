//
//  ApplicationData.swift
//  LightsController
//
//  Created by Eric Johns on 5/10/24.
//

import Foundation

enum Palette {
    case cloud, ocean, rainbow, rainbow_bands, sunset, pastel, sunset2, beach, hult, drywet, fire, magred, yelmag, yelblu, sakura, temperature, retro_clown, pink_candy
}

class ApplicationData {
    static func getPaletteColors(palette: Palette) -> [Int] {
        switch (palette) {
            case .cloud:
                return [255, 255, 255, 127, 127, 127, 0, 0, 0, 127, 127, 127]
            default:
                return [0, 0, 0]
        }
    }
}
