//
//  ContentView.swift
//  LightsController
//
//  Created by Eric Johns on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Colors"
    
    var body: some View {
        VStack {
            Text("LEDs Controller")
                .fontWeight(.bold)
                .font(.system(size: 48.0))
        }
        .padding()
        
        VStack {
            TabView(selection: $selectedTab) {
                VStack {
                    Text("Solid Color Selection")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    List(LightsControllerApp.getDataItems(dataType: .color), id: \.id) { dataRow in
                        Button(action: {
                            print("Tapped color: " + dataRow.textField)
                            LightsControllerApp.requestController(urlArgs: dataRow.urlArgs)
                        }) {
                            DataItemRow(dataItem: dataRow)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(10.0)
                    }
                }
                .tabItem {
                    Label("Colors", systemImage: "star")
                }
                
                VStack {
                    Text("Palette Selection")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    List(LightsControllerApp.getDataItems(dataType: .palette), id: \.id) { dataRow in
                        Button(action: {
                            print("Tapped palette: " + dataRow.textField)
                            LightsControllerApp.requestController(urlArgs: dataRow.urlArgs)
                        }) {
                            DataItemRow(dataItem: dataRow)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(10.0)
                    }
                }
                .tabItem {
                    Label("Palettes", systemImage: "circle")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
