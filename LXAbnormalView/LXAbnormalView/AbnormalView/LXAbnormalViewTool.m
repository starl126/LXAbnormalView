//
//  LXAbnormalViewTool.m
//  LXAbnormalView
//
//  Created by 天边的星星 on 2019/6/24.
//  Copyright © 2019 starxin. All rights reserved.
//

#import "LXAbnormalViewTool.h"
#import "LXAbnormalView.h"

@implementation LXAbnormalViewTool

+ (void)abnormalViewInView:(UIView *)inView imgName:(NSString *)imgName text:(NSString *)text {
    LXAbnormalView* abnormalView = [[LXAbnormalView alloc] init];
    abnormalView.backgroundColor = UIColor.whiteColor;
    
    if (@available(iOS 11.0, *)) {
        abnormalView.originalY = -inView.safeAreaInsets.top-inView.safeAreaInsets.bottom;
    }
    
    abnormalView.imgName = imgName;
    abnormalView.text = text;
    abnormalView.textFont = [UIFont systemFontOfSize:14];
    abnormalView.textColor = kLXHexColor(0x999999);
    
    abnormalView.marginBetweenImageAndText = 8;
    abnormalView.marginBetweenTextAndSubText = 0;
    abnormalView.marginBetweenSubTextAndButton = 0;
    abnormalView.allowTouchCallback = YES;
    __weak typeof(abnormalView) weakView = abnormalView;
    abnormalView.abnormalEventBlock = ^(NSInteger idx) {
        [weakView removeFromSuperview];
    };
    
    [inView addSubview:abnormalView];
}
+ (void)abnormalViewInView:(UIView *)inView imgName:(NSString *)imgName text:(NSString *)text btnTitle:(NSString *)btnTitle callback:(void (^)(NSInteger idx))callback {
    LXAbnormalView* abnormalView = [[LXAbnormalView alloc] init];
    abnormalView.backgroundColor = UIColor.whiteColor;
    
    if (@available(iOS 11.0,*)) {
        abnormalView.originalY = -inView.safeAreaInsets.top-inView.safeAreaInsets.bottom;
    }
    
    abnormalView.imgName = imgName;
    abnormalView.text = text;
    abnormalView.textFont = [UIFont systemFontOfSize:14];
    abnormalView.textColor = kLXHexColor(0x999999);
    
    abnormalView.btnTitlesArr = @[btnTitle];
    abnormalView.btnHeight = 34;
    abnormalView.btnFontsArr = @[[UIFont systemFontOfSize:15]];
    abnormalView.btnColorsArr = @[kLXHexColor(0x3E59CC)];
    abnormalView.btnBorderColorArr = @[kLXHexColor(0x3E59CC)];
    abnormalView.btnBorderWidthArr = @[@(0.5)];
    abnormalView.btnCornerRadiusArr = @[@(4)];
    
    abnormalView.marginBetweenImageAndText = 8;
    abnormalView.marginBetweenTextAndSubText = 0;
    abnormalView.marginBetweenSubTextAndButton = 8;
    abnormalView.marginLeftXLeftButton = 130;
    abnormalView.marginRightXRightButton = 130;
    
    abnormalView.abnormalEventBlock = callback;
    
    [inView addSubview:abnormalView];
}
+ (void)abnormalViewInView:(UIView *)inView imgName:(NSString *)imgName text:(NSString *)text subText:(NSString *)subtext btnTitle:(NSString *)btnTitle callback:(void (^)(NSInteger idx))callback {
    LXAbnormalView* abnormalView = [[LXAbnormalView alloc] init];
    abnormalView.backgroundColor = UIColor.whiteColor;
    
    if (@available(iOS 11.0,*)) {
        abnormalView.originalY = -inView.safeAreaInsets.top-inView.safeAreaInsets.bottom;
    }
    
    abnormalView.imgName = imgName;
    abnormalView.text = text;
    abnormalView.textFont = [UIFont systemFontOfSize:14];
    abnormalView.textColor = kLXHexColor(0x222222);
    
    abnormalView.subText = subtext;
    abnormalView.subTextFont = [UIFont systemFontOfSize:13];
    abnormalView.subTextColor = kLXHexColor(0x999999);
    
    abnormalView.btnTitlesArr = @[btnTitle];
    abnormalView.btnHeight = 34;
    abnormalView.btnFontsArr = @[[UIFont systemFontOfSize:15]];
    abnormalView.btnColorsArr = @[kLXHexColor(0x3E59CC)];
    abnormalView.btnBorderColorArr = @[kLXHexColor(0x3E59CC)];
    abnormalView.btnBorderWidthArr = @[@(0.5)];
    abnormalView.btnCornerRadiusArr = @[@(4)];
    
    abnormalView.marginBetweenImageAndText = 10;
    abnormalView.marginBetweenTextAndSubText = 8;
    abnormalView.marginBetweenSubTextAndButton = 20;
    abnormalView.marginLeftXLeftButton = 140;
    abnormalView.marginRightXRightButton = 140;
    
    abnormalView.allowTouchCallback = YES;
    abnormalView.abnormalEventBlock = callback;
    
    [inView addSubview:abnormalView];
}
+ (void)abnormalVerticalQueueViewInView:(UIView *)inView callback:(void (^)(NSInteger idx))callback {
    LXAbnormalView* abnormalView = [[LXAbnormalView alloc] init];
    abnormalView.backgroundColor = UIColor.whiteColor;
    
    if (@available(iOS 11.0,*)) {
        abnormalView.originalY = -inView.safeAreaInsets.top-inView.safeAreaInsets.bottom;
    }
    
    abnormalView.imgName = @"shouquanbohui";
    abnormalView.text = @"您暂无权限查看";
    abnormalView.textFont = [UIFont systemFontOfSize:14];
    abnormalView.textColor = kLXHexColor(0x222222);
    
    abnormalView.subText = @"请联系客服开通";
    abnormalView.subTextFont = [UIFont systemFontOfSize:13];
    abnormalView.subTextColor = kLXHexColor(0x999999);
    
    abnormalView.btnTitlesArr = @[@"接通客服", @"查看其它"];
    abnormalView.btnHeight = 34;
    abnormalView.btnFontsArr = @[[UIFont systemFontOfSize:15]];
    abnormalView.btnColorsArr = @[UIColor.whiteColor,kLXHexColor(444444)];
    abnormalView.btnBorderColorArr = @[kLXHexColor(0x3E59CC),kLXHexColor(444444)];
    abnormalView.btnBorderWidthArr = @[@(0.5)];
    abnormalView.btnCornerRadiusArr = @[@(4)];
    abnormalView.btnBackgroundColorsArr = @[kLXHexColor(0x3E59CC),UIColor.whiteColor];
    
    abnormalView.marginBetweenImageAndText = 10;
    abnormalView.marginBetweenTextAndSubText = 8;
    abnormalView.marginBetweenSubTextAndButton = 20;
    abnormalView.marginLeftXLeftButton = 140;
    abnormalView.marginRightXRightButton = 140;
    abnormalView.marginBetweenButtons = 10;
    
    abnormalView.buttonQueueType = LXAbnormalButtonQueueTypeVertical;
    abnormalView.abnormalEventBlock = callback;
    
    [inView addSubview:abnormalView];
}
+ (void)abnormalViewInView:(UIView *)inView text:(NSString *)text subText:(NSString *)subText callback:(void (^)(void))callback {
    LXAbnormalView* abnormalView = [[LXAbnormalView alloc] init];
    abnormalView.backgroundColor = UIColor.whiteColor;
    
    if (@available(iOS 11.0,*)) {
        abnormalView.originalY = -inView.safeAreaInsets.top-inView.safeAreaInsets.bottom;
    }
    
    abnormalView.text = text;
    abnormalView.textFont = [UIFont systemFontOfSize:14];
    abnormalView.textColor = kLXHexColor(0x222222);
    
    abnormalView.subText = subText;
    abnormalView.subTextFont = [UIFont systemFontOfSize:13];
    abnormalView.subTextColor = kLXHexColor(0x999999);
    
    abnormalView.marginBetweenImageAndText = 0;
    abnormalView.marginBetweenTextAndSubText = 15;
    abnormalView.marginBetweenSubTextAndButton = 0;
    
    abnormalView.allowTouchCallback = YES;
    abnormalView.abnormalEventBlock = ^(NSInteger idx) {
        if (callback) {
            callback();
        }
    };
    [inView addSubview:abnormalView];
}
+ (void)abnormalViewInView:(UIView *)inView text:(NSString *)text btnTitle:(NSString *)btnTitle callback:(void (^)(NSInteger idx))callback {
    LXAbnormalView* abnormalView = [[LXAbnormalView alloc] init];
    abnormalView.backgroundColor = UIColor.whiteColor;
    
    if (@available(iOS 11.0,*)) {
        abnormalView.originalY = -inView.safeAreaInsets.top-inView.safeAreaInsets.bottom;
    }
    abnormalView.text = text;
    abnormalView.textFont = [UIFont systemFontOfSize:14];
    abnormalView.textColor = kLXHexColor(0x222222);
    
    abnormalView.btnTitlesArr = @[btnTitle];
    abnormalView.btnBorderColorArr = @[kLXHexColor(0x999999)];
    abnormalView.btnBorderWidthArr = @[@(0.5)];
    abnormalView.btnHeight = 34;
    
    abnormalView.marginBetweenImageAndText = 0;
    abnormalView.marginBetweenTextAndSubText = 15;
    abnormalView.marginBetweenSubTextAndButton = 0;
    abnormalView.marginLeftXLeftButton = 120;
    abnormalView.marginRightXRightButton = 120;
    
    abnormalView.abnormalEventBlock = callback;
    [inView addSubview:abnormalView];
}

+ (void)removeInView:(UIView *)inView {
    [inView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:LXAbnormalView.class]) {
            [obj removeFromSuperview];
            *stop = YES;
        }
    }];
}

@end
