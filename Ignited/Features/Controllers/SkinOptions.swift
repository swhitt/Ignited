//
//  SkinOptions.swift
//  Ignited
//
//  Created by Chris Rittenhouse on 5/2/23.
//  Copyright © 2023 LitRitt. All rights reserved.
//

import SwiftUI

import Features

enum SkinBackgroundColor: String, CaseIterable, CustomStringConvertible
{
    case none = "None"
    case theme = "Theme"
    case custom = "Custom"
    
    var description: String {
        return self.rawValue
    }
    
    var uiColor: UIColor {
        switch self {
        case .none: return .black
        case .theme: return Settings.userInterfaceFeatures.theme.color.uiColor
        case .custom: return UIColor(Settings.controllerFeatures.skin.backgroundColor)
        }
    }
}

extension SkinBackgroundColor: LocalizedOptionValue
{
    var localizedDescription: Text {
        return Text(self.description)
    }
}

struct SkinOptions
{
    @Option(name: "Background Color Mode",
            description: "Choose which color to use for the controller skin background.",
            values: SkinBackgroundColor.allCases)
    var colorMode: SkinBackgroundColor = .none
    
    @Option(name: "Custom Background Color",
            description: "Select a custom color to use as the controller skin background.",
            detailView: { value in
        ColorPicker("Custom Background Color", selection: value, supportsOpacity: false)
            .displayInline()
    })
    var backgroundColor: Color = .black
    
    @Option(name: "Show With Controller",
            description: "Always show the controller skin, even if there's a physical controller connected.")
    var alwaysShow: Bool = false
    
    @Option(name: "Opacity", description: "Change the opacity of supported controller skins.", detailView: { value in
        VStack {
            HStack {
                Text("Opacity: \(value.wrappedValue * 100, specifier: "%.f")%")
                Spacer()
            }
            HStack {
                Text("0%")
                Slider(value: value, in: 0.0...1.0, step: 0.05)
                Text("100%")
            }
        }.displayInline()
    })
    var opacity: Double = 0.7
    
    @Option(name: "Restore Defaults",
            description: "Reset all options to their default values.",
            detailView: { _ in
        Button("Restore Defaults") {
            PowerUserOptions.resetFeature(.skin)
        }
        .font(.system(size: 17, weight: .bold, design: .default))
        .foregroundColor(.red)
        .displayInline()
    })
    var reset: Bool = false
}
