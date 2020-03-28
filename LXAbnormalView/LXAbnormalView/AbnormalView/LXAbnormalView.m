//
//  LXAbnormalView.m
//  LXAbnormalView
//
//  Created by 天边的星星 on 2019/6/24.
//  Copyright © 2019 starxin. All rights reserved.
//

#import "LXAbnormalView.h"

@interface LXAbnormalView ()

@property (nonatomic, strong, readonly) UIImageView* iconImgView;
@property (nonatomic, strong, readonly) UILabel* textLbl;
@property (nonatomic, strong, readonly) UILabel* subTextLbl;
@property (nonatomic, strong, readonly) NSMutableArray<UIButton*>* buttonArrM;

#pragma mark --- 父控件尺寸大小校准相关属性
///父控件
@property (nonatomic, weak, readonly) UIView* parentView;
///计算性属性，校准后的父控件frame
@property (nonatomic, assign) CGRect parentFrame;
///父控件的safe area
@property (nonatomic, assign) UIEdgeInsets inset;
///父控件是否是最近控制器的根view
@property (nonatomic, assign) BOOL equalControllerView;
///父控件是否隐藏了导航条
@property (nonatomic, assign) BOOL hideNavBar;
///父控件是否隐藏了Tab Bar
@property (nonatomic, assign) BOOL hideTabBar;
///父控件最近的控制器是否开启了系统调整inset
@property (nonatomic, assign) BOOL autoAdjustScrollInset;

@end

@implementation LXAbnormalView

#pragma mark --- life cycle
- (instancetype)init {
    if (self = [super init]) {
        [self p_initConfiguration];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_initConfiguration];
    }
    return self;
}
- (void)p_initConfiguration {
    _imgContentMode = UIViewContentModeScaleAspectFit;
    _imgBackgroundColor = UIColor.clearColor;
    _textFont = [UIFont systemFontOfSize:16];
    _textColor = UIColor.darkTextColor;
    _subTextFont = [UIFont systemFontOfSize:15];
    _subTextColor = UIColor.lightTextColor;
    _btnHeight = 44;
    
    _textAlignment = NSTextAlignmentCenter;
    _subTextAlignment = NSTextAlignmentCenter;
    
    _buttonQueueType = LXAbnormalButtonQueueTypeHorizonal;
    _originalY = 0;
    _marginBetweenImageAndText = 20;
    _marginBetweenTextAndSubText = 20;
    _marginBetweenSubTextAndButton = 20;
    _marginLeftXText = 40;
    _marginRightXText = 40;
    _marginLeftXSubText = 40;
    _marginRightXSubText = 40;
    _marginLeftXLeftButton = 40;
    _marginRightXRightButton = 40;
    _marginBetweenButtons = 20;
    
    _buttonArrM = [NSMutableArray array];
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        _parentView = newSuperview;
        [self p_setupView];
    }
}
- (void)p_setupView {
    [self p_actionForInitIconImageView];
    [self p_actionForInitTextLabel];
    [self p_actionForInitSubTextLabel];
    [self p_actionForInitButtons];
}

#pragma mark --- layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self p_adjustFrame];
    [self p_actionForSizeImageView];
    [self p_actionForSizeTextLabel];
    [self p_actionForSizeSubTextLabel];
    [self p_actionForSizeButtons];
    
    ///计算所有控件的有效高度
    [self p_actionForUpdateOrigin];
}
///更新图片的size
- (void)p_actionForSizeImageView {
    if (_imgName) {
        UIImage* img = [UIImage imageNamed:_imgName];
        if (img) {
            if (_imgWidth < 1) {
                _imgWidth = img.size.width;
            }
            if (_imgHeight < 1) {
                _imgHeight = img.size.height;
            }
            _iconImgView.frame = CGRectMake(0, 0, _imgWidth, _imgHeight);
            _iconImgView.image = img;
        }
    }
}
///更新主标题的size
- (void)p_actionForSizeTextLabel {
    _textLbl.preferredMaxLayoutWidth = _parentView.frame.size.width-_marginLeftXText-_marginRightXText;
    [_textLbl sizeToFit];
    _textLbl.frame = CGRectMake(0, 0, _textLbl.preferredMaxLayoutWidth, _textLbl.frame.size.height);
}
///更新子标题的size
- (void)p_actionForSizeSubTextLabel {
    _subTextLbl.preferredMaxLayoutWidth = _parentView.frame.size.width-_marginLeftXSubText-_marginRightXSubText;
    [_subTextLbl sizeToFit];
    _subTextLbl.frame = CGRectMake(0, 0, _subTextLbl.preferredMaxLayoutWidth, _subTextLbl.frame.size.height);
}
///更新按钮的size
- (void)p_actionForSizeButtons {
    
    [self.buttonArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (_buttonQueueType == LXAbnormalButtonQueueTypeHorizonal) {//按钮水平排列
            CGFloat width = (_parentView.frame.size.width-_marginLeftXLeftButton-_marginRightXRightButton-(_btnTitlesArr.count-1)*_marginBetweenButtons)/_btnTitlesArr.count;
            
            CGFloat x = _marginLeftXLeftButton+idx*(width+_marginBetweenButtons);
            btn.frame = CGRectMake(x, 0, width, _btnHeight);
        }else {//按钮垂直排列
            CGFloat width = _parentView.frame.size.width-_marginLeftXLeftButton-_marginRightXRightButton;
            btn.frame = CGRectMake(_marginLeftXLeftButton, 0, width, _btnHeight);
        }
        
        CGFloat borderWidth = 0;
        CGFloat cornerRadius = 0;
        CGColorRef colorRef = NULL;
        @try {
            borderWidth = _btnBorderWidthArr[idx].floatValue;
        } @catch (NSException *exception) {
        } @finally {
        }
        
        @try {
            cornerRadius = _btnCornerRadiusArr[idx].floatValue;
            btn.layer.cornerRadius = cornerRadius;
        } @catch (NSException *exception) {
            
        } @finally {
        }
        @try {
            colorRef = _btnBorderColorArr[idx].CGColor;
        } @catch (NSException *exception) {
        } @finally {
        }
        if (borderWidth > 0) {
            CAShapeLayer* shape = [CAShapeLayer layer];
            shape.frame = btn.bounds;
            UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            shape.path = path.CGPath;
            shape.strokeStart = 0;
            shape.strokeEnd = 1;
            shape.contentsScale = [UIScreen mainScreen].scale;
            shape.lineWidth = borderWidth;
            shape.lineCap = kCALineCapRound;
            shape.lineJoin = kCALineJoinRound;
            shape.strokeColor = colorRef;
            shape.fillColor = [UIColor clearColor].CGColor;
            [btn.layer addSublayer:shape];
        }
    }];
}
///校准父控件及其self的frame
- (void)p_adjustFrame {
    
    ///获取所有影响frame的因素
    [self p_actionForGetStatesAffectFrame];
    
    ///计算控件的位置
    CGRect parentFrame = self.parentView.frame;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (@available(iOS 11.0,*)) {
        inset = self.parentView.safeAreaInsets;
        parentFrame = CGRectMake(parentFrame.origin.x+inset.left, parentFrame.origin.y+inset.top, parentFrame.size.width-inset.left-inset.right, parentFrame.size.height-inset.top-inset.bottom);
    }else {
        if (self.equalControllerView) {//控制器的根view
            if (self.hideNavBar && self.hideTabBar) {
                parentFrame = CGRectMake(parentFrame.origin.x+inset.left, parentFrame.origin.y+inset.top, parentFrame.size.width-inset.left-inset.right, parentFrame.size.height-inset.top-inset.bottom);
            }else if (self.hideNavBar && !self.hideTabBar) {
                parentFrame = CGRectMake(parentFrame.origin.x+inset.left, parentFrame.origin.y+inset.top, parentFrame.size.width-inset.left-inset.right, [UIScreen mainScreen].bounds.size.height-49);
            }else if (!self.hideNavBar && self.hideTabBar) {
                parentFrame = CGRectMake(parentFrame.origin.x+inset.left, 64, parentFrame.size.width-inset.left-inset.right, [UIScreen mainScreen].bounds.size.height-64);
            }else {
                parentFrame = CGRectMake(parentFrame.origin.x+inset.left, 64, parentFrame.size.width-inset.left-inset.right, [UIScreen mainScreen].bounds.size.height-64-49);
            }
        }else {
            if ([self.parentView isKindOfClass:UIScrollView.class]) {
                UIScrollView* scrollView = (UIScrollView*)self.parentView;
                inset = scrollView.contentInset;
                parentFrame = CGRectMake(parentFrame.origin.x+inset.left, parentFrame.origin.y+inset.top, parentFrame.size.width-inset.left-inset.right, parentFrame.size.height-inset.top-inset.bottom);
            }
        }
    }
    self.parentFrame = parentFrame;
    self.inset = inset;
    
    //计算异常界面的实际尺寸和位置
    CGFloat y = self.parentFrame.origin.y-self.parentView.frame.origin.y;
    if ([self.parentView isKindOfClass:UIScrollView.class] && self.autoAdjustScrollInset) {
        y = -self.parentView.frame.origin.y;
    }
    //如果是非ios11系统则，safeAreaInsets始终为0
    CGFloat height = self.parentFrame.size.height+self.inset.bottom;
    self.frame = CGRectMake(0, y, self.parentFrame.size.width, height);
}
///更新控件的位置
- (void)p_actionForUpdateOrigin {

    //有效内容区域的高度
    CGFloat buttonsHeight = _btnHeight;
    if (_buttonQueueType == LXAbnormalButtonQueueTypeVertical) {
        if (self.buttonArrM.count == 0) {
            buttonsHeight = 0;
        }else {
            buttonsHeight = self.buttonArrM.count*_btnHeight + (self.buttonArrM.count-1)*_marginBetweenButtons;
        }
    }
    CGFloat totalHeight = self.iconImgView.frame.size.height+self.textLbl.frame.size.height+self.subTextLbl.frame.size.height+buttonsHeight+self.marginBetweenImageAndText+self.marginBetweenTextAndSubText+self.marginBetweenSubTextAndButton;
    NSAssert(totalHeight<=self.parentView.frame.size.height, @"abnormal view's height is bigger than it's parent's");
    
    CGFloat originalY = (self.parentFrame.size.height-totalHeight)*0.5+_originalY;
    
    CGRect frame = self.iconImgView.frame;
    CGFloat x = (self.parentFrame.size.width-self.imgWidth)*0.5;
    CGFloat y = originalY;
    self.iconImgView.frame = CGRectMake(x, originalY, self.imgWidth, self.imgHeight);
    
    frame = self.textLbl.frame;
    x = (self.parentFrame.size.width-frame.size.width-_marginLeftXText-_marginRightXText)*0.5+_marginLeftXText;
    y = CGRectGetMaxY(self.iconImgView.frame)+self.marginBetweenImageAndText;
    self.textLbl.frame = CGRectMake(x, y, frame.size.width, frame.size.height);
    
    frame = self.subTextLbl.frame;
    x = (self.parentFrame.size.width-frame.size.width-_marginLeftXSubText-_marginRightXSubText)*0.5+_marginLeftXSubText;
    y = CGRectGetMaxY(self.textLbl.frame)+self.marginBetweenTextAndSubText;
    self.subTextLbl.frame = CGRectMake(x, y, frame.size.width, frame.size.height);
    
    __weak typeof(self) weakSelf = self;
    CGFloat startY = CGRectGetMaxY(weakSelf.subTextLbl.frame)+weakSelf.marginBetweenSubTextAndButton;
    [self.buttonArrM enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = obj.frame;
        CGFloat y = 0;
        if (weakSelf.buttonQueueType == LXAbnormalButtonQueueTypeVertical) {
            y = startY+idx*(weakSelf.marginBetweenButtons+weakSelf.btnHeight);
        }else {
            y = startY;
        }
        obj.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    }];
}
#pragma mark --- init
///图片控件默认处理
- (void)p_actionForInitIconImageView {
    _iconImgView = UIImageView.alloc.init;
    _iconImgView.backgroundColor = _imgBackgroundColor;
    _iconImgView.contentMode = _imgContentMode;
    [self addSubview:_iconImgView];
}
///主文本控件默认处理
- (void)p_actionForInitTextLabel {
    _textLbl = UILabel.alloc.init;
    _textLbl.numberOfLines = 0;
    _textLbl.textAlignment = _textAlignment;
    _textLbl.backgroundColor = _textBackgroundColor;
    
    if (_text) {
        _textLbl.text = _text;
        _textLbl.font = _textFont;
        _textLbl.textColor = _textColor;
    }
    if (_attText) {
        _textLbl.attributedText = _attText;
    }
    [self addSubview:_textLbl];
}
///子文本控件默认处理
- (void)p_actionForInitSubTextLabel {
    
    _subTextLbl = UILabel.alloc.init;
    _subTextLbl.textAlignment = _subTextAlignment;
    _subTextLbl.numberOfLines = 0;
    _subTextLbl.backgroundColor = _subTextBackgroundColor;

    if (_subText) {
        _subTextLbl.text = _subText;
        _subTextLbl.font = _subTextFont;
        _subTextLbl.textColor = _subTextColor;
    }
    if (_subAttText) {
        _subTextLbl.attributedText = _subAttText;
    }
    [self addSubview:_subTextLbl];
}
///按钮控件默认处理
- (void)p_actionForInitButtons {
    if (_btnTitlesArr && _btnTitlesArr.count) {
        for (int i=0; i<_btnTitlesArr.count; i++) {
            UIButton* btn = UIButton.alloc.init;
            [btn setTitle:_btnTitlesArr[i] forState:UIControlStateNormal];
            
            if (_btnColorsArr && _btnColorsArr.count) {
                @try {
                    [btn setTitleColor:_btnColorsArr[i] forState:UIControlStateNormal];
                } @catch (NSException *exception) {
                    [btn setTitleColor:kLXHexColor(0x222222) forState:UIControlStateNormal];
                } @finally {
                    
                }
            }else {
                [btn setTitleColor:kLXHexColor(0x222222) forState:UIControlStateNormal];
            }
            
            if (_btnFontsArr && _btnFontsArr.count) {
                @try {
                    btn.titleLabel.font = _btnFontsArr[i];
                } @catch (NSException *exception) {
                    btn.titleLabel.font = [UIFont systemFontOfSize:16];
                } @finally {
                    
                }
            }else {
                btn.titleLabel.font = [UIFont systemFontOfSize:16];
            }
            
            UIColor* backgroundColor = nil;
            if (_btnBackgroundColorsArr && _btnBackgroundColorsArr.count) {
                @try {
                    backgroundColor = _btnBackgroundColorsArr[i];
                    btn.backgroundColor = backgroundColor;
                } @catch (NSException *exception) {
                    
                } @finally {
                    
                }
            }
            
            CGFloat cornerRadius = 0;
            CGColorRef colorRef = NULL;
            
            @try {
                cornerRadius = _btnCornerRadiusArr[i].floatValue;
                btn.layer.cornerRadius = cornerRadius;
            } @catch (NSException *exception) {
                
            } @finally {
            }
            
            @try {
                colorRef = _btnBorderColorArr[i].CGColor;
                btn.layer.borderColor = colorRef;
            } @catch (NSException *exception) {
                      
            } @finally {
            }
            
            btn.tag = i;
            [btn addTarget:self action:@selector(p_actionForClickButton:) forControlEvents:UIControlEventTouchUpInside];
      
            [self.buttonArrM addObject:btn];
            [self addSubview:btn];
        }
    }
}
#pragma mark --- event
- (void)setAllowTouchCallback:(BOOL)allowTouchCallback {
    _allowTouchCallback = allowTouchCallback;
    if (allowTouchCallback) {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_actionForTapGesture:)];
        if (@available(iOS 11.0,*)) {
            tap.name = @"abnormalViewTapEvent";
        }
        [self addGestureRecognizer:tap];
    }
}
///判断当前控件导航条隐藏、Tab Bar隐藏、最近控制器是否自动开启了系统自调整滚动控件功能、该parentView是否是最近控制器的根控制器
- (void)p_actionForClickButton:(UIButton *)sender {
    if (self.abnormalEventBlock) {
        self.abnormalEventBlock(sender.tag);
    }
}
///判断当前控件的导航条是否隐藏
- (void)p_actionForGetStatesAffectFrame {
    BOOL hideNavBar = YES;
    BOOL hideTabBar = YES;
    BOOL autoAdjustScrollInset = YES;
    BOOL rootView = NO;
    UIResponder* nextResponder = self.parentView.nextResponder;
    
    while (nextResponder) {
        if ([nextResponder isKindOfClass:UIViewController.class] && !rootView) {
            rootView = [((UIViewController*)nextResponder).view isEqual:self.parentView];
            autoAdjustScrollInset = ((UIViewController*)nextResponder).automaticallyAdjustsScrollViewInsets;
        }else if ([nextResponder isKindOfClass:UINavigationController.class] && hideNavBar) {
            hideNavBar = ((UINavigationController*)nextResponder).navigationBar.isHidden;
        }else if ([nextResponder isKindOfClass:UITabBarController.class] && hideTabBar) {
            hideTabBar = ((UITabBarController*)nextResponder).tabBar.isHidden;
        }else if ([nextResponder isKindOfClass:UIApplication.class]) {
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }
    self.hideNavBar = hideNavBar;
    self.hideTabBar = hideTabBar;
    self.autoAdjustScrollInset = autoAdjustScrollInset;
    self.equalControllerView = rootView;
}
///手势点击事件
- (void)p_actionForTapGesture:(UITapGestureRecognizer*)tap {
    if (self.isAllowTouchCallback) {
        NSInteger idx = -1;
        if (self.tapEventText) {
            CGPoint abnormalP = [tap locationInView:self];
            
            if ([self.textLbl.attributedText.string containsString:self.tapEventText]) {
                CGPoint lblP = [self convertPoint:abnormalP toView:self.textLbl];
                NSRange range = [self.textLbl.attributedText.string rangeOfString:self.tapEventText];
                CGRect rect = [self p_boundingRectForCharacterRange:range attrText:self.textLbl.attributedText size:self.textLbl.frame.size];
                CGRect amplifyRect = CGRectMake(rect.origin.x-10, rect.origin.y-10, rect.size.width+20, rect.size.height+20);
                if (CGRectContainsPoint(amplifyRect, lblP)) {
                    idx = -2;
                }
            }else if ([self.subTextLbl.attributedText.string containsString:self.tapEventText]) {
                CGPoint lblP = [self convertPoint:abnormalP toView:self.subTextLbl];
                NSRange range = [self.subTextLbl.attributedText.string rangeOfString:self.tapEventText];
                CGRect rect = [self p_boundingRectForCharacterRange:range attrText:self.subTextLbl.attributedText size:self.subTextLbl.frame.size];
                CGRect amplifyRect = CGRectMake(rect.origin.x-10, rect.origin.y-10, rect.size.width+20, rect.size.height+20);
                if (CGRectContainsPoint(amplifyRect, lblP)) {
                   idx = -2;
                }
            }else {}
        }
        if (self.abnormalEventBlock) {
            self.abnormalEventBlock(idx);
        }
    }
}
///获取文本中某段文字的rect
- (CGRect)p_boundingRectForCharacterRange:(NSRange)range attrText:(NSAttributedString*)attrText size:(CGSize)size {
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attrText];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:size];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}
- (void)dealloc {
    NSLog(@"dealloc --- %@", NSStringFromClass(self.class));
}

@end
