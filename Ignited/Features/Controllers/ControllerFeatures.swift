//
//  ControllerFeatures.swift
//  Ignited
//
//  Created by Chris Rittenhouse on 6/28/23.
//  Copyright © 2023 LitRitt. All rights reserved.
//

import Features

struct ControllerFeatures: FeatureContainer
{
    static let shared = ControllerFeatures()
    
    @Feature(name: "Skin Options",
             description: "Change the look of controller skins.",
             options: SkinOptions(),
             permanent: true)
    var skin
    
    @Feature(name: "Controller Options",
             description: "Change how the app responds to controller inputs.",
             options: ControllerOptions(),
             permanent: true)
    var controller
    
    @Feature(name: "Background Blur",
             description: "Use a blurred game screen as the background of skins.",
             options: BackgroundBlurOptions(),
             pro: true)
    var backgroundBlur
    
    @Feature(name: "AirPlay Skins",
             description: "Customize the appearance of games when AirPlaying to your TV.",
             options: AirPlaySkinsOptions(),
             hidden: true)
    var airPlaySkins
    
    @Feature(name: "Show Screen During AirPlay",
             description: "Enable to show the main game screen on your device while AirPlaying.")
    var airPlayKeepScreen
    
    private init()
    {
        self.prepareFeatures()
    }
}
