//
//  Constant.swift
//  FastlaneRunner
//
//  Created by Su Ho on 22/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

enum Constant {

    // MARK: - App Store

    static let testFlightTesterGroups = ["<#group1#>", "<#group2#>"]

    // MARK: - Firebase

    static let stagingFirebaseAppId = "1:394751167018:ios:7670aacd2a018cd5b21153"
    static let productionFirebaseAppId = "1:394751167018:ios:8ab5165fcff843c5b21153"
    static let firebaseTesterGroups = "nimble"

    // MARK: - Match

    static let appleStagingUserName = "dev@nimblehq.co"
    static let appleStagingTeamId = "4TWS7E2EPE"
    static let appleProductionUserName = "dev@nimblehq.co"
    static let appleProductionTeamId = "4TWS7E2EPE"
    static let keychainName = "github_action_keychain"
    static let matchURL = "git@github.com:nimblehq/match-certificates.git"

    // MARK: - Path

    static let outputPath = "./Output"
    static let buildPath = "\(outputPath)/Build"
    static let derivedDataPath = "\(outputPath)/DerivedData"
    static let projectPath: String = "./\(projectName).xcodeproj"
    static let testOutputDirectoryPath = "./fastlane/test_output"
    static let infoPlistPath = "\(projectName)/Configurations/Plists/Info.plist"

    // MARK: Platform

    static var platform: PlatformType {
        if EnvironmentParser.bool(key: "CM_BRANCH") {
            return .codeMagic
        } else if EnvironmentParser.bool(key: "BITRISE_IO") {
            return .bitrise
        } else if EnvironmentParser.bool(key: "GITHUB_ACTIONS") {
            return .gitHubActions
        }
        return .unknown
    }

    // MARK: - Project

    static let stagingBundleId = "co.nimblehq.ios.templates.staging"
    static let productionBundleId = "co.nimblehq.ios.templates"
    static let projectName = "iOSTemplate"

    // MARK: - Symbol

    static let uploadSymbolsBinaryPath: String = "./Pods/FirebaseCrashlytics/upload-symbols"
    static let dSYMSuffix: String = ".dSYM.zip"

    // MARK: - Build and Version

    static let manualVersion: String = ""

    // MARK: - Device

    static let devices = ["iPhone 12 Pro Max"]

    // MARK: - Test

    static let testTarget: String = "\(projectName)Tests"
    static let kifUITestTarget: String = "\(projectName)KIFUITests"
}

extension Constant {

    enum Environment: String {

        case staging = "Staging"
        case production = "Production"

        var productName: String { "\(Constant.projectName) \(rawValue)".trimmed }

        var scheme: String {
            switch self {
            case .staging: return "\(Constant.projectName) \(rawValue)".trimmed
            case .production: return Constant.projectName.trimmed
            }
        }

        var bundleId: String {
            switch self {
            case .staging: return Constant.stagingBundleId
            case .production: return Constant.productionBundleId
            }
        }

        var firebaseAppId: String {
            switch self {
            case .staging: return Constant.stagingFirebaseAppId
            case .production: return Constant.productionFirebaseAppId
            }
        }

        var gspPath: String {
            let infoName = "GoogleService-Info.plist"
            let googleServiceFolder = "./\(Constant.projectName)/Configurations/Plists/GoogleService"
            switch self {
            case .staging: return "\(googleServiceFolder)/Staging/\(infoName)"
            case .production: return "\(googleServiceFolder)/Production/\(infoName)"
            }
        }

        var dsymPath: String {
            let outputDirectoryURL = URL(fileURLWithPath: Constant.outputPath)
            return outputDirectoryURL.appendingPathComponent(productName + ".app" + Constant.dSYMSuffix).relativePath
        }
        
        var appleUsername: String {
            switch self {
            case .staging: return Constant.appleStagingUserName
            case .production: return Constant.appleProductionUserName
            }
        }
        
        var appleTeamId: String {
            switch self {
            case .staging: return Constant.appleStagingTeamId
            case .production: return Constant.appleProductionTeamId
            }
        }
    }

    enum BuildType: String {

        case development
        case adHoc = "ad-hoc"
        case appStore = "app-store"

        var value: String { return rawValue }
        
        var match: String {
            switch self {
            case .development: return "development"
            case .adHoc: return "adhoc"
            case .appStore: return "appstore"
            }
        }
        
        var configuration: String {
            switch self {
            case .development: return "Debug"
            case .adHoc, .appStore: return "Release"
            }
        }
        
        var codeSignIdentity: String {
            switch self {
            case .development: return "iPhone Developer"
            case .adHoc, . appStore: return "iPhone Distribution"
            }
        }
        
        var method: String {
            switch self {
            case .development: return "Development"
            case .adHoc: return "AdHoc"
            case .appStore: return "AppStore"
            }
        }
    }

    enum PlatformType {

        case gitHubActions, bitrise, codeMagic, unknown
    }
}

extension String {

    fileprivate var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
}
