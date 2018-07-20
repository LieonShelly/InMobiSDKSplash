//
//  AppDelegate.m
//  InMobiSDKSplash
//
//  Created by lieon on 2018/7/20.
//  Copyright © 2018年 lieon. All rights reserved.
//

#import "AppDelegate.h"
#import <InMobiSDK/InMobiSDK.h>
#import "NBIMMobiSplashViewController.h"

#define IMMobiSDKAccountID @"22a909d5dac84123b4428a0be8521e88"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupImmobSDK];
    [self setupWindow];
    return YES;
}

- (void)setupImmobSDK {
    [IMSdk initWithAccountID:IMMobiSDKAccountID];
    [IMSdk setLogLevel:kIMSDKLogLevelDebug];
    CLLocationManager *mgr = [[CLLocationManager alloc] init]; CLLocation *loc = mgr.location;
    [IMSdk setLocation:loc];
    [IMSdk setGender:kIMSDKGenderFemale];
    [IMSdk setAgeGroup:kIMSDKAgeGroupBetween25And29];
}

- (void)setupWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    IMNative * nativeAd = [[IMNative alloc] initWithPlacementId:1529058537648];
    [nativeAd load];
    NBIMMobiSplashViewController* rootVC = [[NBIMMobiSplashViewController alloc] initiWithNative:nativeAd];
    nativeAd.delegate = rootVC;
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
}

@end
