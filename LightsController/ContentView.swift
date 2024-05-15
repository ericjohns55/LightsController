//
//  ContentView.swift
//  LightsController
//
//  Created by Eric Johns on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Colors"
    
    @State public var brightness: Float = 128
    @State public var effectSpeed: Float = 128
    @State public var effectIntensity: Float = 128
    
    @State public var selectedConfig: AvailableStrip = .all
    @State private var stripConfig: StripConfig = .full
        
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
                            
                            let response = LightsControllerApp.extractModifiers(urlArgs: dataRow.urlArgs)
                            effectSpeed = response[0]
                            effectIntensity = response[1]
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
                    Text("Strip Modifiers")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    Slider(value: $brightness, in: 0...255, step: 1) {
                        Text("Brightness")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    } onEditingChanged: { editing in
                        if (!editing) {
                            LightsControllerApp.requestController(urlArgs: "*A=\(Int(brightness))")
                        }
                    }.padding(10)
                    Text("Brightness: \(Int(brightness))")
                    
                    Slider(value: $effectSpeed, in: 0...255, step: 1) {
                        Text("Effect Speed")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    } onEditingChanged: { editing in
                        if (!editing) {
                            LightsControllerApp.requestController(urlArgs: "*SX=\(Int(effectSpeed))")
                        }
                    }.padding(10)
                    Text("Effect Speed: \(Int(effectSpeed))")
                    
                    Slider(value: $effectIntensity, in: 0...255, step: 1) {
                        Text("Effect Intensity")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    } onEditingChanged: { editing in
                        if (!editing) {
                            LightsControllerApp.requestController(urlArgs: "*IX=\(Int(effectIntensity))")
                        }
                    }.padding(10)
                    Text("Effect Intensity: \(Int(effectIntensity))")
                    
                    Spacer()
                    
                    
                    Text("Strip Config")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    Picker("Lights Config", selection: $selectedConfig) {
                        Text("All Lights").tag(AvailableStrip.all)
                        Text("Main Lights").tag(AvailableStrip.main)
                        Text("Tapestry Lights").tag(AvailableStrip.tapestry)
                    }.pickerStyle(.segmented)
                        .padding(10)
                        .onChange(of: selectedConfig, {
                            LightsControllerApp.selectedConfig = selectedConfig
                        })
                    
                    Picker("Physical Config", selection: $stripConfig) {
                        Text("Left Strip").tag(StripConfig.left)
                        Text("Full Strip").tag(StripConfig.full)
                        Text("Right Strip").tag(StripConfig.right)
                    }.pickerStyle(.segmented)
                        .padding(10)
                        .onChange(of: stripConfig, {
                            LightsControllerApp.stripConfig = stripConfig
                        })
                    
                    Spacer()
                    
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
