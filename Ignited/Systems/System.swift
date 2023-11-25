//
//  System.swift
//  Ignited
//
//  Created by Riley Testut on 4/30/17.
//  Copyright © 2017 Riley Testut. All rights reserved.
//

import DeltaCore

import SNESDeltaCore
import GBADeltaCore
import GBCDeltaCore
import NESDeltaCore
import N64DeltaCore
import MelonDSDeltaCore
import Systems

// Legacy Cores
import struct DSDeltaCore.DS

enum System: CaseIterable
{
    case nes
    case genesis
    case snes
    case n64
    case gb
    case gbc
    case gba
    case ds
    
    static var registeredSystems: [System] {
        let systems = System.allCases.filter { Delta.registeredCores.keys.contains($0.gameType) }
        return systems
    }
    
    static var allCores: [DeltaCoreProtocol] {
        return [NES.core, SNES.core, N64.core, GB.core, GBC.core, GBA.core, DS.core, MelonDS.core, GPGX.core]
    }
}

extension System
{
    var localizedName: String {
        switch self
        {
        case .nes: return NSLocalizedString("Nintendo", comment: "")
        case .snes: return NSLocalizedString("Super Nintendo", comment: "")
        case .n64: return NSLocalizedString("Nintendo 64", comment: "")
        case .gb: return NSLocalizedString("Game Boy", comment: "")
        case .gbc: return NSLocalizedString("Game Boy Color", comment: "")
        case .gba: return NSLocalizedString("Game Boy Advance", comment: "")
        case .ds: return NSLocalizedString("Nintendo DS", comment: "")
        case .genesis: return NSLocalizedString("Sega Genesis", comment: "")
        }
    }
    
    var localizedShortName: String {
        switch self
        {
        case .nes: return NSLocalizedString("NES", comment: "")
        case .snes: return NSLocalizedString("SNES", comment: "")
        case .n64: return NSLocalizedString("N64", comment: "")
        case .gb: return NSLocalizedString("GB", comment: "")
        case .gbc: return NSLocalizedString("GBC", comment: "")
        case .gba: return NSLocalizedString("GBA", comment: "")
        case .ds: return NSLocalizedString("DS", comment: "")
        case .genesis: return NSLocalizedString("GEN", comment: "")
        }
    }
    
    var year: Int {
        switch self
        {
        case .nes: return 1985
        case .snes: return 1990
        case .n64: return 1996
        case .gb: return 1997 // 1989
        case .gbc: return 1998
        case .gba: return 2001
        case .ds: return 2004
        case .genesis: return 2005 // 1989
        }
    }
}

extension System
{
    var deltaCore: DeltaCoreProtocol {
        switch self
        {
        case .nes: return NES.core
        case .snes: return SNES.core
        case .n64: return N64.core
        case .gb: return GB.core
        case .gbc: return GBC.core
        case .gba: return GBA.core
        case .ds: return Settings.preferredCore(for: .ds) ?? MelonDS.core
        case .genesis: return GPGX.core
        }
    }
    
    var gameType: DeltaCore.GameType {
        switch self
        {
        case .nes: return .nes
        case .snes: return .snes
        case .n64: return .n64
        case .gb: return .gb
        case .gbc: return .gbc
        case .gba: return .gba
        case .ds: return .ds
        case .genesis: return .genesis
        }
    }
    
    init?(gameType: DeltaCore.GameType)
    {
        switch gameType
        {
        case GameType.nes: self = .nes
        case GameType.snes: self = .snes
        case GameType.n64: self = .n64
        case GameType.gb: self = .gb
        case GameType.gbc: self = .gbc
        case GameType.gba: self = .gba
        case GameType.ds: self = .ds
        case GameType.genesis: self = .genesis
        default: return nil
        }
    }
}

extension DeltaCore.GameType
{
    init?(fileExtension: String)
    {
        switch fileExtension.lowercased()
        {
        case "nes": self = .nes
        case "smc", "sfc", "fig": self = .snes
        case "n64", "z64": self = .n64
        case "gb": self = .gb
        case "gbc": self = .gbc
        case "gba": self = .gba
        case "ds", "nds": self = .ds
        case "gen", "bin", "md", "smd", "sms", "gg", "sg", "mdx", "m3u", "chd": self = .genesis
        default: return nil
        }
    }
}
