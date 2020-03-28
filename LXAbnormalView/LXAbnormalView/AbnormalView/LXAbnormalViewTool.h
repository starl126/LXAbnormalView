//
//  LXAbnormalViewTool.h
//  LXAbnormalView
//
//  Created by 天边的星星 on 2019/6/24.
//  Copyright © 2019 starxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXAbnormalViewTool : NSObject

///图片文本
+ (void)abnormalViewInView:(UIView *)inView imgName:(NSString *)imgName text:(NSString *)text;

///图片文本按钮
+ (void)abnormalViewInView:(UIView *)inView imgName:(NSString *)imgName text:(NSString *)text btnTitle:(NSString *)btnTitle callback:(void (^)(NSInteger idx))callback;

///图片文本子文本按钮
+ (void)abnormalViewInView:(UIView *)inView imgName:(NSString *)imgName text:(NSString *)text subText:(NSString *)subtext btnTitle:(NSString *)btnTitle callback:(void (^)(NSInteger idx))callback;

///垂直排列按钮
+ (void)abnormalVerticalQueueViewInView:(UIView *)inView callback:(void (^)(NSInteger idx))callback;

///文本子文本
+ (void)abnormalViewInView:(UIView *)inView text:(NSString *)text subText:(NSString *)subText callback:(void (^)(void))callback;

///移除inView控件的异常界面
+ (void)removeInView:(UIView *)inView;

///文本按钮
+ (void)abnormalViewInView:(UIView *)inView text:(NSString *)text btnTitle:(NSString *)btnTitle callback:(void (^)(NSInteger idx))callback;

///文本内容点击事件
+ (void)abnormalViewInView:(UIView *)inView text:(NSString *)text tapContent:(NSString*)tapContent btnTitle:(NSString *)btnTitle callback:(void (^)(NSInteger idx))callback;

@end

NS_ASSUME_NONNULL_END
