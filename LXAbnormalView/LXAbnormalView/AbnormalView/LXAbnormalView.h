//
//  LXAbnormalView.h
//  LXAbnormalView
//
//  Created by 天边的星星 on 2019/6/24.
//  Copyright © 2019 starxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kLXHexColor(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f]

///@summary 按钮排列方式，默认是水平排列
typedef NS_ENUM(uint, LXAbnormalButtonQueueType) {
    ///水平排序
    LXAbnormalButtonQueueTypeHorizonal = 0,
    ///垂直排序
    LXAbnormalButtonQueueTypeVertical
};

/**
 异常界面事件回调
 
 @param idx -2：设置过文本内容点击事件回调的事件 -1：触摸回调，必须设置allowTouchCallback=YES才有回调，其它按照按钮的从左到右的顺序从0递增
 */
typedef void (^LXAbnormalEventBlock)(NSInteger idx);

///@summary 异常控件：比如数据请求失败空白页面、无权限异常页面等。
///@detail 内部控件排序从上到下：图片、文本、子文本、按钮，若都没有则整个控件高度为0
@interface LXAbnormalView : UIView

#pragma mark --- 图片属性设置
///图片名称
@property (nonatomic, copy, readwrite) NSString* imgName;

///图片宽度，默认值图片的实际宽度
@property (nonatomic, assign, readwrite) CGFloat imgWidth;

///图片高度，默认值图片的实际高度
@property (nonatomic, assign, readwrite) CGFloat imgHeight;

///图片显示模式，默认UIViewContentModeScaleAspectFit
@property (nonatomic, assign, readwrite) UIViewContentMode imgContentMode;

///图片的背景颜色，默认是无色
@property (nonatomic, strong, readwrite) UIColor* imgBackgroundColor;

#pragma mark --- 文本属性设置
///文本内容，若同时设置了富文本，则富文本优先级高，富文本下文本内容的其他属性设置无效
@property (nonatomic, copy, readwrite) NSString* text;

///文本富文本，不为空才会创建文本控件
@property (nonatomic, copy, readwrite) NSAttributedString* attText;

///文本字体大小，默认系统16，富文本无效
@property (nonatomic, strong, readwrite) UIFont* textFont;

///文本颜色，默认系统darkTextColor，富文本无效
@property (nonatomic, strong, readwrite) UIColor* textColor;

///文本的背景颜色
@property (nonatomic, strong, readwrite) UIColor* textBackgroundColor;

///文本对齐方式，默认是center，富文本无效
@property (nonatomic, assign) NSTextAlignment textAlignment;


///子文本内容，若同时设置了富文本，则富文本优先级高，富文本下文本内容的其他属性设置无效
@property (nonatomic, copy, readwrite) NSString* subText;

///子文本富文本，不为空才会创建子文本控件
@property (nonatomic, copy, readwrite) NSAttributedString* subAttText;

///子文本字体大小，默认系统15，富文本无效
@property (nonatomic, strong, readwrite) UIFont* subTextFont;

///子文本颜色默认系统lightTextColor，富文本无效
@property (nonatomic, strong, readwrite) UIColor* subTextColor;

///子文本的背景颜色
@property (nonatomic, strong, readwrite) UIColor* subTextBackgroundColor;

///子文本对齐方式，默认是center，富文本无效
@property (nonatomic, assign) NSTextAlignment subTextAlignment;

#pragma mark --- 按钮属性设置,注意按钮的宽度是根据间距和父控件宽度动态计算的
///按钮的标题数组，数组个数不等于0才会创建按钮控件
@property (nonatomic, strong, readwrite) NSArray<NSString*>* btnTitlesArr;

///按钮排列顺序，默认是水平排列
@property (nonatomic, assign, readwrite) LXAbnormalButtonQueueType buttonQueueType;

///按钮的标题颜色，默认0x222222
@property (nonatomic, strong, readwrite) NSArray<UIColor*>* btnColorsArr;

///按钮的标题字体大小，默认系统15
@property (nonatomic, strong, readwrite) NSArray<UIFont*>* btnFontsArr;

///按钮的border宽度
@property (nonatomic, strong, readwrite) NSArray<NSNumber*>* btnBorderWidthArr;

///按钮的border颜色
@property (nonatomic, strong, readwrite) NSArray<UIColor*>* btnBorderColorArr;

///按钮的corner radius
@property (nonatomic, strong, readwrite) NSArray<NSNumber*>* btnCornerRadiusArr;

///按钮高度，默认是44
@property (nonatomic, assign, readwrite) CGFloat btnHeight;

///按钮背景颜色
@property (nonatomic, strong, readwrite) NSArray<UIColor*>* btnBackgroundColorsArr;

#pragma mark --- 间距设置
///abnormal view的内容控件初始y值，默认是0，此参数可以实现整个控件内容下移或者上移功能，值>0为下移，<0为上移
@property (nonatomic, assign, readwrite) CGFloat originalY;
///图片和文本垂直方向的间距，默认值为20
@property (nonatomic, assign, readwrite) CGFloat marginBetweenImageAndText;

///文本和子文本垂直方向的间距，默认值为20
@property (nonatomic, assign, readwrite) CGFloat marginBetweenTextAndSubText;

///子文本和按钮垂直方向的间距，默认值为20
@property (nonatomic, assign, readwrite) CGFloat marginBetweenSubTextAndButton;

///文本距离父控件左边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginLeftXText;

///文本距离父控件右边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginRightXText;

///子文本距离父控件左边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginLeftXSubText;

///子文本距离父控件右边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginRightXSubText;

///最左边按钮距离父控件左边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginLeftXLeftButton;

///最右边按钮距离父控件右边距，默认值为40
@property (nonatomic, assign, readwrite) CGFloat marginRightXRightButton;

///按钮之间的间距，默认是20
@property (nonatomic, assign, readwrite) CGFloat marginBetweenButtons;

#pragma mark --- 事件设置
///是否允许触摸回调，默认是NO
@property (nonatomic, assign, getter=isAllowTouchCallback) BOOL allowTouchCallback;
///对于某些文本内容加入点击事件监听，事件回调idx=-2
@property (nonatomic, copy, readwrite) NSString* tapEventText;
///按钮回调
@property (nonatomic, copy) LXAbnormalEventBlock abnormalEventBlock;

@end

NS_ASSUME_NONNULL_END
