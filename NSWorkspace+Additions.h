//
//  NSWorksapce+Additions.h
//  CocoaCategories
//
//  Created by vincent on 8/25/10.
//  Copyright 2010 Ortery Technologies, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// inspired by GDKit

/**
 * Macro definition of a string you can pass to openSystemPreference,
 * for universal access.
 */
#define kSCSystemPrefencesAccounts @"Accounts.prefPane"
#define kSCSystemPrefencesAppearance @"Appearance.prefPane"
#define kSCSystemPrefencesBluetooth @"Bluetooth.prefPane"
#define kSCSystemPrefencesDateAndTime @"DateAndTime.prefPane"
#define kSCSystemPrefencesDesktopScreenEffectsPref @"DesktopScreenEffectsPref.prefPane"
#define kSCSystemPrefencesDigiHubDiscs @"DigiHubDiscs.prefPane"
#define kSCSystemPrefencesDisplays @"Displays.prefPane"
#define kSCSystemPrefencesDock @"Dock.prefPane"
#define kSCSystemPrefencesEnergySaver @"EnergySaver.prefPane"
#define kSCSystemPrefencesExpose @"Expose.prefPane"
#define kSCSystemPrefencesFibreChannel @"FibreChannel.prefPane"
#define kSCSystemPrefencesInk @"Ink.prefPane"
#define kSCSystemPrefencesKeyboard @"Keyboard.prefPane"
#define kSCSystemPrefencesLocalization @"Localization.prefPane"
#define kSCSystemPrefencesMobileMe @"MobileMe.prefPane"
#define kSCSystemPrefencesMouse @"Mouse.prefPane"
#define kSCSystemPrefencesNetwork @"Network.prefPane"
#define kSCSystemPrefencesParentalControls @"ParentalControls.prefPane"
#define kSCSystemPrefencesPrintAndFax @"PrintAndFax.prefPane"
#define kSCSystemPrefencesSecurity @"Security.prefPane"
#define kSCSystemPrefencesSharingPref @"SharingPref.prefPane"
#define kSCSystemPrefencesSoftwareUpdate @"SoftwareUpdate.prefPane"
#define kSCSystemPrefencesSound @"Sound.prefPane"
#define kSCSystemPrefencesSpeech @"Speech.prefPane"
#define kSCSystemPrefencesSpotlight @"Spotlight.prefPane"
#define kSCSystemPrefencesStartupDisk @"StartupDisk.prefPane"
#define kSCSystemPrefencesTimeMachine @"TimeMachine.prefPane"
#define kSCSystemPrefencesTrackpad @"Trackpad.prefPane"
#define kSCSystemPrefencesUniversalAccess @"UniversalAccessPref.prefPane"


@interface NSWorkspace (Additions)

/**
 * Brings an application to the front. Requires an application
 * info dictionary, which must contain the key "NSApplicationPath"
 */
- (void)bringApplicationToFront:(NSDictionary *)appInfo;

/**
 * Brings the current application to front - uses NSBundle internally.
 */
- (void)bringCurrentApplicationToFront;

/**
 * Brings an application to the front, from an application
 * path.
 */
- (void)bringApplicationToFrontFromPath:(NSString *)appPath;

/**
 * Opens the system preferences panel and opens the specified
 * preference. Pass in an argument like "UniversalAccessPref"
 * this function will append the ".prefpane", and also search
 * in two places for the prefpane: /System/Library/PreferencePanes/,
 * and ~/Library/PreferencePanes/
 */
- (void)openSystemPreference:(NSString *)preferencesFileName;

/**
 * Installs a launch agent/startup item into ~/Library/LaunchAgents, you
 * need to pass it a "plist" file. ex: "MyAppStartup.Agent.plist"
 */
- (void)installStartupLaunchdItem:(NSString *)plistName;

/**
 * Removes a launchd agent/startup item from ~/Library/LaunchAgents, you
 * need to pass it a "plist" file. ex: "MyAppStartup.Agent.plist"
 */
- (void)uninstallStartupLaunchdItem:(NSString *)plistName;

@end
