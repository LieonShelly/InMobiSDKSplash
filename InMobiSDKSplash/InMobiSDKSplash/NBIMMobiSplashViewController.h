//
//  NBIMMobiSplashViewController.h
//  NBCartoon
//
//  Created by lieon on 2018/7/7.
//  Copyright © 2018年 NotBroken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <InMobiSDK/InMobiSDK.h>

@interface NBIMMobiSplashViewController : UIViewController<IMNativeDelegate>
@property (nonatomic) long long placementID;
- (instancetype)initiWithNative: (IMNative*)native;
@end
