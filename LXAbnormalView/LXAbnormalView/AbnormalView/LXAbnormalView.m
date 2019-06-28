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

///父控件
@property (nonatomic, weak, readonly) UIView* parentView;

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
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_actionForTapGesture)];
    [self addGestureRecognizer:tap];
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        _parentView = newSuperview;
        [self p_setupView];
    }
}
- (void)p_setupView {
    _iconImgView = UIImageView.alloc.init;
    _iconImgView.backgroundColor = _imgBackgroundColor;
    _iconImgView.contentMode = _imgContentMode;
    
    _textLbl = UILabel.alloc.init;
    _textLbl.numberOfLines = 0;
    _textLbl.textAlignment = _textAlignment;
    _textLbl.backgroundColor = _textBackgroundColor;
    _textLbl.preferredMaxLayoutWidth = _parentView.frame.size.width-_marginLeftXText-_marginRightXText;
    _textLbl.frame = CGRectMake(0, 0, _textLbl.preferredMaxLayoutWidth, 0);
    
    _subTextLbl = UILabel.alloc.init;
    _subTextLbl.textAlignment = _subTextAlignment;
    _subTextLbl.numberOfLines = 0;
    _subTextLbl.backgroundColor = _subTextBackgroundColor;
    _subTextLbl.preferredMaxLayoutWidth = _parentView.frame.size.width-_marginLeftXSubText-_marginRightXSubText;
    _subTextLbl.frame = CGRectMake(0, 0, _subTextLbl.preferredMaxLayoutWidth, 0);
    
    [self addSubview:self.iconImgView];
    [self addSubview:self.textLbl];
    [self addSubview:self.subTextLbl];
    
    //图片处理
    [self p_actionForInitIconImageView];
    
    //文本处理
    [self p_actionForInitTextLabel];
    
    //子文本处理
    [self p_actionForInitSubTextLabel];
    
    //按钮处理
    [self p_actionForInitButtons];
    
    //计算所有控件的有效高度
    [self p_actionForUpdateOrigin];
}

#pragma mark --- actions
///图片处理，主要是设置图片的宽高
- (void)p_actionForInitIconImageView {
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
///文本处理，主要是设置文本的宽高
- (void)p_actionForInitTextLabel {
    if (_text) {
        _textLbl.text = _text;
        _textLbl.font = _textFont;
        _textLbl.textColor = _textColor;
    }
    if (_attText) {
        _textLbl.attributedText = _attText;
    }
    [_textLbl sizeToFit];
}
///子文本处理，主要是设置子文本的宽高
- (void)p_actionForInitSubTextLabel {
    if (_subText) {
        _subTextLbl.text = _subText;
        _subTextLbl.font = _subTextFont;
        _subTextLbl.textColor = _subTextColor;
    }
    if (_subAttText) {
        _subTextLbl.attributedText = _subAttText;
    }
    [_subTextLbl sizeToFit];
}
///按钮处理，主要是设置按钮的x和size
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
                    btn.titleLabel.font = [UIFont systemFontOfSize:15];
                } @finally {
                    
                }
            }else {
                btn.titleLabel.font = [UIFont systemFontOfSize:15];
            }
            
            if (_btnBorderWidthArr && _btnBorderWidthArr.count) {
                @try {
                    btn.layer.borderWidth = _btnBorderWidthArr[i].floatValue;
                } @catch (NSException *exception) {
                    btn.layer.borderWidth = 0;
                } @finally {
                    
                }
            }
            
            if (_btnBorderColorArr && _btnBorderColorArr.count) {
                @try {
                    btn.layer.borderColor = _btnBorderColorArr[i].CGColor;
                } @catch (NSException *exception) {
                } @finally {
                    
                }
            }
            
            if (_btnCornerRadiusArr && _btnCornerRadiusArr.count) {
                @try {
                    btn.layer.cornerRadius = _btnCornerRadiusArr[i].floatValue;
                } @catch (NSException *exception) {
                    btn.layer.cornerRadius = 0;
                } @finally {
                    
                }
            }
            if (_btnBackgroundColorsArr && _btnBackgroundColorsArr.count) {
                @try {
                    btn.backgroundColor = _btnBackgroundColorsArr[i];
                } @catch (NSException *exception) {
                    
                } @finally {
                    
                }
            }
            if (_buttonQueueType == LXAbnormalButtonQueueTypeHorizonal) {//按钮水平排列
                CGFloat width = (_parentView.frame.size.width-_marginLeftXLeftButton-_marginRightXRightButton-(_btnTitlesArr.count-1)*_marginBetweenButtons)/_btnTitlesArr.count;
                CGFloat x = _marginLeftXLeftButton+i*(width+_marginBetweenButtons);
                btn.frame = CGRectMake(x, 0, width, _btnHeight);
            }else {//按钮垂直排列
                CGFloat width = _parentView.frame.size.width-_marginLeftXLeftButton-_marginRightXRightButton;
                btn.frame = CGRectMake(_marginLeftXLeftButton, 0, width, _btnHeight);
            }
            btn.tag = i;
            [btn addTarget:self action:@selector(p_actionForClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArrM addObject:btn];
            [self addSubview:btn];
        }
    }
}
///更新控件的位置
- (void)p_actionForUpdateOrigin {

    //有效内容区域的高度
    CGFloat buttonsHeight = _btnHeight;
    if (_buttonQueueType == LXAbnormalButtonQueueTypeVertical) {
        buttonsHeight = self.buttonArrM.count*_btnHeight + (self.buttonArrM.count-1)*_marginBetweenButtons;
    }
    CGFloat totalHeight = self.iconImgView.frame.size.height+self.textLbl.frame.size.height+self.subTextLbl.frame.size.height+buttonsHeight+self.marginBetweenImageAndText+self.marginBetweenTextAndSubText+self.marginBetweenSubTextAndButton;
    NSAssert(totalHeight<=self.parentView.frame.size.height, @"abnormal view's height is bigger than it's parent's");
    
    //计算控件的位置
    CGFloat originalY = (self.parentView.frame.size.height-_originalY-totalHeight)*0.5;
    
    CGRect frame = self.iconImgView.frame;
    CGFloat x = (self.parentView.frame.size.width-self.imgWidth)*0.5;
    CGFloat y = originalY;
    self.iconImgView.frame = CGRectMake(x, originalY, self.imgWidth, self.imgHeight);
    
    frame = self.textLbl.frame;
    x = (self.parentView.frame.size.width-frame.size.width-_marginLeftXText-_marginRightXText)*0.5+_marginLeftXText;
    y = CGRectGetMaxY(self.iconImgView.frame)+self.marginBetweenImageAndText;
    self.textLbl.frame = CGRectMake(x, y, frame.size.width, frame.size.height);
    
    frame = self.subTextLbl.frame;
    x = (self.parentView.frame.size.width-frame.size.width-_marginLeftXSubText-_marginRightXSubText)*0.5+_marginLeftXSubText;
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
    
    //计算异常界面的实际尺寸和位置
    self.frame = CGRectMake(0, _originalY, self.parentView.frame.size.width, self.parentView.frame.size.height-_originalY);
}
///点击按钮回调
- (void)p_actionForClickButton:(UIButton *)sender {
    if (self.abnormalEventBlock) {
        self.abnormalEventBlock(sender.tag);
    }
}
- (void)p_actionForTapGesture {
    if (self.isAllowTouchCallback) {
        if (self.abnormalEventBlock) {
            self.abnormalEventBlock(-1);
        }
    }
}

- (void)dealloc {
    NSLog(@"dealloc --- %@", NSStringFromClass(self.class));
}

@end
