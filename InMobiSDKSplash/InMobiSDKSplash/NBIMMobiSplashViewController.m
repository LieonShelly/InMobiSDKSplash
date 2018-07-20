//
//  NBIMMobiSplashViewController.m
//  NBCartoon
//
//  Created by lieon on 2018/7/7.
//  Copyright © 2018年 NotBroken. All rights reserved.
//

#import "NBIMMobiSplashViewController.h"
#import "ViewController.h"

@interface NBIMMobiSplashViewController ()
@property(nonatomic,strong) IMNative *InMobiNativeAd;
@property (weak, nonatomic) IBOutlet UILabel *skipBtn;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation NBIMMobiSplashViewController
{
    BOOL isShowAd;
}

- (instancetype)initiWithNative: (IMNative*)native {
    if (self == [super init]) {
        self.InMobiNativeAd = native;
    }
    return self;
}


- (void)dealloc {
    [self.InMobiNativeAd recyclePrimaryView];
    self.InMobiNativeAd.delegate = nil;
    self.InMobiNativeAd = nil;
    [self.timer invalidate];
    self.timer = nil;
   NSLog(@"NBIMMobiSplashViewController-- dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skipBtn.text = @"3 跳过";
    self.skipBtn.layer.cornerRadius = 15;
    self.skipBtn.layer.masksToBounds = true;
    UITapGestureRecognizer * tap = [UITapGestureRecognizer new];
    [tap addTarget:self action:@selector(skipAction)];
    self.skipBtn.userInteractionEnabled = true;
    [self.skipBtn addGestureRecognizer:tap];
    [self performSelector:@selector(showIfSplashAdIsReady) withObject:NULL afterDelay:2];
    self.skipBtn.hidden = true;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarHidden = false;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    if (self.InMobiNativeAd) {
        [_InMobiNativeAd recyclePrimaryView];
        _InMobiNativeAd = nil;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

-(void)showIfSplashAdIsReady{
    if(self.InMobiNativeAd.isReady) {
         [self showAd];
    } else {
        [self dismissAd];
    }
}

- (void)skipAction {
    [self dismissAd];
}

- (void)startCount {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (void)timerAction {
    self.skipBtn.hidden = false;
    static NSInteger i = 3;
    self.skipBtn.text =[NSString stringWithFormat:@"%ld 跳过", i];
    if (i == 0) {
        [self dismissAd];
    }
     
    i = i - 1;
}

- (void)showAd{
    if (!isShowAd) {
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            UIView* AdPrimaryViewOfCorrectWidth = [self.InMobiNativeAd primaryViewOfWidth:[UIScreen mainScreen].bounds.size.width];
            AdPrimaryViewOfCorrectWidth.backgroundColor = [UIColor whiteColor];
            self.containerView.clipsToBounds = true;
            [self.containerView addSubview:AdPrimaryViewOfCorrectWidth];
            [self.view bringSubviewToFront:self.skipBtn];
        }];
        isShowAd = true;
    }

}

- (void)dismissAd{
       [[NSOperationQueue mainQueue]addOperationWithBlock:^{
           [self.timer invalidate];
           self.timer = nil;
           [self.InMobiNativeAd recyclePrimaryView];
           self.InMobiNativeAd = nil;
           [self.view removeFromSuperview];
           [self removeFromParentViewController];
           if (![[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[ViewController class]]) {
               ViewController * mainVC = [ViewController new];
               [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
               CATransition *transtition = [CATransition animation];
               transtition.duration = 0.5;
               transtition.removedOnCompletion = true;
               transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
               [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];
           }
       }];
}


- (void)nativeDidFinishLoading:(IMNative*)native{
    NSLog(@"Native Ad load Successful");
    [self showAd];
    [self startCount];
}

- (void)native:(IMNative*)native didFailToLoadWithError:(IMRequestStatus*)error{
    NSLog(@"didFailToLoadWithError");
    [self dismissAd];
    
}

- (void)nativeWillPresentScreen:(IMNative*)native{
    NSLog(@"Native Ad will present screen");
}

- (void)nativeDidPresentScreen:(IMNative*)native{
    NSLog(@"Native Ad did present screen");
}

- (void)nativeWillDismissScreen:(IMNative*)native{
    NSLog(@"Native Ad will dismiss screen");
}

- (void)nativeDidDismissScreen:(IMNative*)native{
    NSLog(@"Native Ad did dismiss screen");
}

-(void)userWillLeaveApplicationFromNative:(IMNative*)native{
    NSLog(@"User leave");
}

-(void)native:(IMNative *)native didInteractWithParams:(NSDictionary *)params{
    NSLog(@"User leave");
}

- (void)nativeAdImpressed:(IMNative *)native{
    NSLog(@"nativeAdImpressed");
}

- (void)native:(IMNative *)native rewardActionCompletedWithRewards:(NSDictionary *)rewards{
    NSLog(@"User leave");
}

- (void)nativeDidFinishPlayingMedia:(IMNative *)native{
    
}

- (void)userDidSkipPlayingMediaFromNative:(IMNative*)native {
    
}
@end
