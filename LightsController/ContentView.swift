//
//  ContentView.swift
//  LightsController
//
//  Created by Eric Johns on 5/2/24.
//

import SwiftUI

enum Page {
    case colors, effects, palettes, adjustments, presets
}

struct ContentView: View {
    @State private var selectedTab: Page = .colors
    @State private var inSetup: Bool = false
    
    @State private var lastPalette: String = "(None)"
    @State private var lastEffect: String = "(None)"
    
    @State public var brightness: Float = 128
    @State public var effectSpeed: Float = 128
    @State public var effectIntensity: Float = 128
    
    @State private var selectedConfig: AvailableStrip
    @State private var stripConfig: StripConfig
    
    @State private var serverConfig: ServerConfig
    @State private var primaryIP: String
    @State private var primaryIsServer: Bool
    @State private var secondaryIP: String
    @State private var secondaryIsServer: Bool
    
    init() {
        primaryIP = ApplicationData.primaryIP
        primaryIsServer = ApplicationData.primaryServer
        secondaryIP = ApplicationData.secondaryIP
        secondaryIsServer = ApplicationData.secondaryServer
        
        selectedConfig = ApplicationData.selectedConfig
        stripConfig = ApplicationData.stripConfig
        serverConfig = ApplicationData.serverConfig
    }
        
    var body: some View {
        VStack {
            Text("LED Lights")
                .fontWeight(.bold)
                .underline()
                .font(.system(size: 48.0))
                .padding(.bottom, 20)
                .gesture(LongPressGesture().onEnded({ _ in
                    if ((serverConfig == .primary && primaryIsServer) || (serverConfig == .secondary && secondaryIsServer)) {
                        print("Toggling bedroom lights")
                        LightsControllerApp.requestController(urlArgs: ApplicationData.toggle_lights)
                    }
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
                            if (dataRow.textField != "Toggle Lights") {
                                lastEffect = "Solid Color"
                                lastPalette = "\(dataRow.textField) (Solid Color)"
                            }
                            
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
                }.tag(Page.colors)
                
                VStack {
                    Text("Effect Selection")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    Text("Current Effect: " + lastEffect)
                        .italic()
                        .font(.system(size: 16.0))
                    
                    List(DataItemRow.getDataItems(dataType: .effect), id: \.id) { dataRow in
                        Button(action: {
                            lastEffect = dataRow.textField
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
                }.tag(Page.effects)
                
                VStack {
                    Text("Palette Selection")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    Text("Current Palette: " + lastPalette)
                        .italic()
                        .font(.system(size: 16.0))
                    
                    List(DataItemRow.getDataItems(dataType: .palette), id: \.id) { dataRow in
                        Button(action: {
                            lastPalette = dataRow.textField
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
                }.tag(Page.palettes)
                
                VStack {
                    if (!inSetup) {
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
                        
                        if ((serverConfig == .primary && primaryIsServer) || (serverConfig == .secondary && secondaryIsServer)) {
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
                                    ApplicationData.selectedConfig = selectedConfig
                                    ApplicationData.updateSavedData()
                                })
                            
                            Picker("Physical Config", selection: $stripConfig) {
                                Text("Left Strip").tag(StripConfig.left)
                                Text("Full Strip").tag(StripConfig.full)
                                Text("Right Strip").tag(StripConfig.right)
                            }.pickerStyle(.segmented)
                                .padding(10)
                                .onChange(of: stripConfig, {
                                    ApplicationData.stripConfig = stripConfig
                                    ApplicationData.updateSavedData()
                                })
                            
                            Spacer()
                        }
                        
                        Button(action: {
                            inSetup = true
                        }) {
                            Text("Server Settings")
                        }.padding(20)
                    } else {
                        Text("Server Config")
                            .fontWeight(.bold)
                            .font(.system(size: 32.0))
                            .padding(.bottom, 20)
                        
                        Color(uiColor: UIColor.separator).frame(height: 1.0 / UIScreen.main.scale)
                        
                        Text("Active Config")
                            .fontWeight(.bold)
                            .font(.system(size: 24.0))
                        
                        Picker("Server Config", selection: $serverConfig) {
                            Text("Primary").tag(ServerConfig.primary)
                            Text("Secondary").tag(ServerConfig.secondary)
                        }.pickerStyle(.segmented)
                            .padding(10)
                            .onChange(of: serverConfig, {
                                ApplicationData.serverConfig = serverConfig
                                ApplicationData.updateSavedData()
                            })
                        
                        Color(uiColor: UIColor.separator).frame(height: 1.0 / UIScreen.main.scale)
                        
                        Text("Primary Server")
                            .fontWeight(.bold)
                            .font(.system(size: 18.0))
                                    
                        LabeledContent {
                            TextField("XXX.XX.X.XXX:XXXX", text: $primaryIP)
                                .onSubmit {
                                    ApplicationData.primaryIP = primaryIP
                                    ApplicationData.updateSavedData()
                                }
                        } label: {
                            Text("Primary server IP: ")
                        }.padding(10)
                            
                        Toggle(isOn: $primaryIsServer, label: {
                            Text("Uses Raspberry PI Server")
                        }).padding(10)
                            .onChange(of: primaryIsServer, {
                                ApplicationData.primaryServer = primaryIsServer
                                ApplicationData.updateSavedData()
                            })
                                            
                        Color(uiColor: UIColor.separator).frame(height: 1.0 / UIScreen.main.scale)
                        
                        Text("Secondary Server")
                            .fontWeight(.bold)
                            .font(.system(size: 18.0))
                        
                        LabeledContent {
                            TextField("XXX.XX.X.XXX:XXXX", text: $secondaryIP)
                                .onSubmit {
                                    ApplicationData.secondaryIP = secondaryIP
                                    ApplicationData.updateSavedData()
                                }
                        } label: {
                            Text("Secondary server IP: ")
                        }.padding(10)
                            
                        Toggle(isOn: $secondaryIsServer, label: {
                            Text("Uses Raspberry PI Server")
                        }).padding(10)
                            .onChange(of: secondaryIsServer, {
                                ApplicationData.secondaryServer = secondaryIsServer
                                ApplicationData.updateSavedData()
                            })
                                            
                        Color(uiColor: UIColor.separator).frame(height: 1.0 / UIScreen.main.scale)
                        
                        Spacer()
                                                
                        Button(action: {
                            inSetup = false
                        }) {
                            Text("Return to Adjustments Page")
                        }.padding(20)
                    }
                    
                }
                .tabItem {
                    Label("Adjustments", systemImage: "dial.high")
                }.tag(Page.adjustments)
                
                VStack {
                    Text("Presets")
                        .fontWeight(.bold)
                        .font(.system(size: 32.0))
                    
                    Spacer()
                    
                    // https://developer.apple.com/tutorials/app-dev-training/persisting-data
                }
                .tabItem {
                    Label("Presets", systemImage: "star")
                }.tag(Page.presets)
            }
        }
    }
}

#Preview {
    ContentView()
}
