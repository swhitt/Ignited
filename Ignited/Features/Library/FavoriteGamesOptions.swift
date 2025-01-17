//
//  FavoriteGamesOptions.swift
//  Ignited
//
//  Created by Chris Rittenhouse on 6/3/23.
//  Copyright © 2023 LitRitt. All rights reserved.
//

import UIKit
import SwiftUI

import Features

enum FavoriteArtworkStyle: String, CaseIterable, CustomStringConvertible
{
    case none = "Default"
    case theme = "Theme"
    case custom = "Custom"
    
    var description: String {
        return self.rawValue
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .none: return Settings.libraryFeatures.artwork.style.backgroundColor
        case .theme: return Settings.userInterfaceFeatures.theme.color.favoriteColor
        case .custom: return Settings.libraryFeatures.favorites.backgroundColorMode == .custom ? UIColor(Settings.libraryFeatures.favorites.backgroundColor) : Settings.userInterfaceFeatures.theme.color.favoriteColor
        }
    }
    
    var borderColor: UIColor? {
        switch self {
        case .none: return Settings.libraryFeatures.artwork.style.borderColor
        case .theme: return Settings.userInterfaceFeatures.theme.color.favoriteColor
        case .custom: return Settings.libraryFeatures.favorites.borderColorMode == .custom ? UIColor(Settings.libraryFeatures.favorites.borderColor) : Settings.userInterfaceFeatures.theme.color.favoriteColor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .custom: return UIColor(Settings.libraryFeatures.favorites.textColor)
        default: return Settings.libraryFeatures.artwork.style.textColor
        }
    }
    
    var shadowColor: UIColor? {
        switch self {
        case .custom: return UIColor(Settings.libraryFeatures.favorites.shadowColor)
        default: return Settings.libraryFeatures.artwork.style.shadowColor
        }
        
    }
    
    var cornerRadius: Double {
        switch self {
        case .custom: return Settings.libraryFeatures.favorites.cornerRadius
        default: return Settings.libraryFeatures.artwork.style.cornerRadius
        }
    }
    
    var borderWidth: Double {
        switch self {
        case .custom: return Settings.libraryFeatures.favorites.borderWidth
        default: return Settings.libraryFeatures.artwork.style.borderWidth
        }
    }
    
    var shadowOpacity: Double {
        switch self {
        case .custom: return Settings.libraryFeatures.favorites.shadowOpacity
        default: return Settings.libraryFeatures.artwork.style.shadowOpacity
        }
    }
    
    var shadowRadius: Double {
        switch self {
        case .custom: return Settings.libraryFeatures.favorites.shadowRadius
        default: return Settings.libraryFeatures.artwork.style.shadowRadius
        }
    }
}

extension FavoriteArtworkStyle: LocalizedOptionValue
{
    var localizedDescription: Text {
        return Text(self.description)
    }
}

struct FavoriteGamesOptions
{
    @Option
    var sortFirst: Bool = true
    
    @Option(name: "Show Star Icon", description: "Enable to show a star icon on your favorite games' artwork.")
    var showStarIcon: Bool = true
    
    @Option(name: "Style",
            description: "Choose the style to use for favorite game artwork. Custom options require Ignited Pro.",
            values: Settings.proFeaturesEnabled ? FavoriteArtworkStyle.allCases : [.none, .theme])
    var style: FavoriteArtworkStyle = .theme
    
    @Option(name: "Background Color Mode",
            description: "Choose which background color to use with the custom style option.",
            pro: true,
            values: ArtworkCustomColor.allCases)
    var backgroundColorMode: ArtworkCustomColor = .custom
    
    @Option(name: "Custom Background Color",
            description: "Choose the color to use for the custom background color mode.",
            pro: true,
            detailView: { value in
        ColorPicker(selection: value, supportsOpacity: true) {
            Text("Custom Background Color").addProLabel()
        }.displayInline()
    })
    var backgroundColor: Color = .orange
    
    @Option(name: "Border Color Mode",
            description: "Choose which border color to use with the custom style option.",
            pro: true,
            values: ArtworkCustomColor.allCases)
    var borderColorMode: ArtworkCustomColor = .custom
    
    @Option(name: "Custom Border Color",
            description: "Choose the color to use for the custom border color mode.",
            pro: true,
            detailView: { value in
        ColorPicker(selection: value, supportsOpacity: false) {
            Text("Custom Border Color").addProLabel()
        }.displayInline()
    })
    var borderColor: Color = .orange
    
    @Option(name: "Text Color Mode",
            description: "Choose which text color to use with the custom style option.",
            pro: true,
            values: ArtworkCustomColor.allCases)
    var textColorMode: ArtworkCustomColor = .theme
    
    @Option(name: "Custom Text Color",
            description: "Choose the color to use for the custom text color mode.",
            pro: true,
            detailView: { value in
        ColorPicker(selection: value, supportsOpacity: false) {
            Text("Custom Text Color").addProLabel()
        }.displayInline()
    })
    var textColor: Color = .black
    
    @Option(name: "Shadow Color Mode",
            description: "Choose which shadow color to use with the custom style option.",
            pro: true,
            values: ArtworkCustomColor.allCases)
    var shadowColorMode: ArtworkCustomColor = .theme
    
    @Option(name: "Custom Shadow Color",
            description: "Choose the color to use for the custom shadow color mode.",
            pro: true,
            detailView: { value in
        ColorPicker(selection: value, supportsOpacity: false) {
            Text("Custom Shadow Color").addProLabel()
        }.displayInline()
    })
    var shadowColor: Color = .white
    
    @Option(name: "Custom Shadow Radius",
            description: "Change the shadow radius to use with the custom style option.",
            pro: true,
            detailView: { value in
        VStack {
            HStack {
                Text("Custom Shadow Radius: \(value.wrappedValue, specifier: "%.f")pt").addProLabel()
                Spacer()
            }
            HStack {
                Text("0pt")
                Slider(value: value, in: 0.0...10.0, step: 0.5)
                Text("10pt")
            }
        }.displayInline()
    })
    var shadowRadius: Double = 5
    
    @Option(name: "Custom Shadow Opacity",
            description: "Change the shadow opacity to use with the custom style option.",
            pro: true,
            detailView: { value in
        VStack {
            HStack {
                Text("Custom Shadow Opacity: \(value.wrappedValue * 100, specifier: "%.f")%").addProLabel()
                Spacer()
            }
            HStack {
                Text("0%")
                Slider(value: value, in: 0.0...1.0, step: 0.1)
                Text("100%")
            }
        }.displayInline()
    })
    var shadowOpacity: Double = 0.5
    
    @Option(name: "Custom Corner Radius",
            description: "Change the corner radius to use with the custom style option.",
            pro: true,
            detailView: { value in
        VStack {
            HStack {
                Text("Custom Corners Radius: \(value.wrappedValue * 100, specifier: "%.f")%").addProLabel()
                Spacer()
            }
            HStack {
                Text("0%")
                Slider(value: value, in: 0.0...0.25, step: 0.01)
                Text("25%")
            }
        }.displayInline()
    })
    var cornerRadius: Double = 0.15
    
    @Option(name: "Custom Border Width",
            description: "Change the border witdh to use with the custom style option.",
            pro: true,
            detailView: { value in
        VStack {
            HStack {
                Text("Custom Border Width: \(value.wrappedValue, specifier: "%.1f")pt").addProLabel()
                Spacer()
            }
            HStack {
                Text("0pt")
                Slider(value: value, in: 0.0...3.0, step: 0.5)
                Text("3pt")
            }
        }.displayInline()
    })
    var borderWidth: Double = 2
    
    @Option(name: "Restore Defaults",
            description: "Reset all options to their default values.",
            detailView: { _ in
        Button("Restore Defaults") {
            PowerUserOptions.resetFeature(.favoriteGames)
        }
        .font(.system(size: 17, weight: .bold, design: .default))
        .foregroundColor(.red)
        .displayInline()
    })
    var reset: Bool = false
}
