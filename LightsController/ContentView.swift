//
//  ContentView.swift
//  LightsController
//
//  Created by Eric Johns on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Colors"
    @State private var increment: Int = 0
    
    var body: some View {
        VStack {
            Text("LED Lights")
                .fontWeight(.bold)
                .underline()
                .font(.system(size: 48.0))
                .padding(.bottom, 20)
                .gesture(LongPressGesture().onEnded({ _ in
                    print("Toggling bedroom lights")
                    LightsControllerApp.requestController(urlArgs: ApplicationData.toggle_lights)
                }))
        }
        .padding()
        
        VStack {
            TabView(selection: $selectedTab) {
                VStack {
                    Text("Solid Color Selection")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    List(DataItemRow.getDataItems(dataType: .color), id: \.id) { dataRow in
                        Button(action: {
                            print("Tapped color: " + dataRow.textField)
                            LightsControllerApp.requestController(urlArgs: dataRow.urlArgs)
                        }) {
                            DataItemRow(dataItem: dataRow)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(10.0)
                        .listRowSeparator(.hidden)
                        .gesture(LongPressGesture().onEnded({ _ in
                            print("YOUR MOM")
                        }))
                        
                        if !dataRow.last {
                            Color(uiColor: UIColor.separator).frame(height: 1.0 / UIScreen.main.scale)
                        }
                        
                    }
                    
                }
                .tabItem {
                    Label("Colors", systemImage: "rainbow")
                }
                
                VStack {
                    Text("Effect Selection")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    List(DataItemRow.getDataItems(dataType: .effect), id: \.id) { dataRow in
                        Button(action: {
                            print("Tapped effect: " + dataRow.textField)
                            LightsControllerApp.requestController(urlArgs: dataRow.urlArgs)
                        }) {
                            DataItemRow(dataItem: dataRow)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(10.0)
                        .listRowSeparator(.hidden)
                        
                        if !dataRow.last {
                            Color(uiColor: UIColor.separator).frame(height: 1.0 / UIScreen.main.scale)
                        }
                    }
                }
                .tabItem {
                    Label("Effects", systemImage: "wand.and.rays")
                }
                
                VStack {
                    Text("Palette Selection")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    List(DataItemRow.getDataItems(dataType: .palette), id: \.id) { dataRow in
                        Button(action: {
                            print("Tapped palette: " + dataRow.textField)
                            LightsControllerApp.requestController(urlArgs: dataRow.urlArgs)
                        }) {
                            DataItemRow(dataItem: dataRow)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(10.0)
                        .listRowSeparator(.hidden)
                        
                        if !dataRow.last {
                            Color(uiColor: UIColor.separator).frame(height: 1.0 / UIScreen.main.scale)
                        }
                    }
                }
                .tabItem {
                    Label("Palettes", systemImage: "paintpalette")
                }
                
                VStack {
                    
                }
                .tabItem {
                    Label("Adjustments", systemImage: "dial.high")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
