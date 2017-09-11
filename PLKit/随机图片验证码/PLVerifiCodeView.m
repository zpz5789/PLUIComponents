//
//  PLVerifiCodeView.m
//  PLKit
//
//  Created by zpz on 2017/9/11.
//  Copyright © 2017年 BigRoc. All rights reserved.
//

#import "PLVerifiCodeView.h"

@interface PLVerifiCodeView ()
///
@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) NSArray <NSString *> *localVerifiCodes;

@property (nonatomic, copy) NSString *currentVerificode;

@property (nonatomic, assign) NSInteger verifiCodeLenth;

@property (nonatomic, assign) CGRect originRect;
@end

@implementation PLVerifiCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    //配置属性默认值
    self.rotation = YES;
    self.horizontalAlignment = YES;
    self.verticalAlignment = YES;
    self.verifiCodeColorRandom = YES;

    self.verifiCodeFont = [UIFont boldSystemFontOfSize:20];
    self.verifiCodeColor = [UIColor darkGrayColor];
    self.bottomShadingWidth = 2.f;
    
    self.originRect = self.frame;
    self.verifiCodeLenth = 4;

    [self addSubview:self.bgView];
    
    self.placeHolderCodeText = @"获取验证码";

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnClick)];
    [self addGestureRecognizer:tapGesture];

}

- (void)layoutSubviews
{
    
    self.frame = self.originRect;
    
    CGFloat elementMaxWidth = 0;
    CGFloat elementMaxHeight = 0;
    for (int i = 0; i < self.currentVerificode.length; i ++) {
        NSString *aCharStr = [self.currentVerificode substringWithRange:NSMakeRange(i, 1)];
        CGFloat width = [self getStringSizeWithStr:aCharStr].width;
        CGFloat height = [self getStringSizeWithStr:aCharStr].height;
        elementMaxWidth = MAX(elementMaxWidth, width);
        elementMaxHeight = MAX(elementMaxHeight, height);
    }
    
    //宽度判断
    if (self.bounds.size.width - 8 < elementMaxWidth * self.currentVerificode.length) {
        //宽度小于文字宽度情况
        CGRect tempFrame = self.frame;
        tempFrame.size.width = elementMaxWidth * self.currentVerificode.length + 8;
        self.frame = tempFrame;
    }
    
    //高度判断
    if (self.bounds.size.height - 5 < elementMaxHeight) {
        CGRect frame = self.frame;
        frame.size = CGSizeMake(self.frame.size.width, elementMaxHeight + 5);
        self.frame = frame;
    }

    self.bgView.frame = self.bounds;
    [super layoutSubviews];
}


#pragma mark - private method

- (void)changeVerifiCode
{
    // 改变背景颜色
    [self changeVerifiCodeBgColor];
    // 改变验证码
    [self changeVerifiCodeText];
    // 改变底纹
    [self changeVerifiCodeBottomShading];
}


- (void)tapOnClick
{
    [self changeVerifiCode];
}

// 改变背景颜色
- (void)changeVerifiCodeBgColor
{
    if (self.bgImages.count) {
        self.bgView.image = [self.bgImages objectAtIndex:arc4random_uniform((uint32_t)self.bgImages.count)];
    } else if (self.bgColors.count) {
        self.bgView.backgroundColor = [self.bgColors objectAtIndex:arc4random_uniform((uint32_t)self.bgColors.count)];
    } else {
        self.bgView.backgroundColor = [self getRandomColorWithAlpha:0.5];
    }
}

// 改变验证码
- (void)changeVerifiCodeText
{
    //清空状态
    [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.bgView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    self.currentVerificode = [self getRandomVerifiCode];
    
    //根据文字计算验证码父视图宽度
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    //前面已经保证了elementWidth > 一个字符的宽度
    CGFloat elementWidth = CGRectGetWidth(self.bgView.bounds) / self.currentVerificode.length;
    CGFloat elementHeight = CGRectGetHeight(self.bgView.bounds);
    
    for (int i = 0; i < self.currentVerificode.length; i ++) {
        
        NSString *aCharStr = [self.currentVerificode substringWithRange:NSMakeRange(i, 1)];
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = self.verifiCodeFont;
        textLabel.text = aCharStr;
        if (self.verifiCodeColorRandom) {
            textLabel.textColor = [self getRandomColorWithAlpha:0.8];
        } else {
            textLabel.textColor = self.verifiCodeColor ? self.verifiCodeColor : [UIColor darkGrayColor];
        }
        textLabel.textAlignment = NSTextAlignmentCenter;
        CGSize aCharSize = [self getStringSizeWithStr:aCharStr];
        CGFloat deltaX = elementWidth - aCharSize.width;
        CGFloat deltaY = elementHeight - aCharSize.height;


        CGFloat x = arc4random_uniform(deltaX) + i * elementWidth;
        CGFloat y = arc4random_uniform(deltaY);
        CGFloat w = aCharSize.width;
        CGFloat h = aCharSize.height;
        
        //水平对齐，上下不浮动
        if (!self.horizontalAlignment) {
            x = i * elementWidth;
            w = elementWidth;
        }
        //垂直对齐，左右不浮动
        if (!self.verticalAlignment) {
            y = 0;
            h = elementHeight;
        }
        
        textLabel.frame = CGRectMake(x, y, w, h);
        
        [self.bgView addSubview:textLabel];

        //旋转
        if (!self.rotation) {
            //获取 -M_PI_4 ~ M_PI_4之间的随机数
            CGFloat symbo = ((- 1) * (CGFloat)arc4random_uniform(3)) + 1;
            CGFloat random = arc4random_uniform(100)/ 100.0 * M_PI_4;
            CGFloat angle = symbo * random;
            textLabel.transform = CGAffineTransformMakeRotation(angle);
        }
    }
}

// 改变底纹
- (void)changeVerifiCodeBottomShading
{
    for (int i = 0; i < arc4random_uniform(10); i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat pX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat pY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path moveToPoint:CGPointMake(pX, pY)];
        CGFloat ptX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat ptY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path addLineToPoint:CGPointMake(ptX, ptY)];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [[self getRandomColorWithAlpha:0.2] CGColor];//layer的边框色
        layer.lineWidth = self.bottomShadingWidth;
        layer.strokeEnd = 1;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.path = path.CGPath;
        [_bgView.layer addSublayer:layer];
    }

}

- (CGSize)getStringSizeWithStr:(NSString *)string
{
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName : self.verifiCodeFont}];
    return size;
}



//获取随机颜色
- (UIColor *)getRandomColorWithAlpha:(CGFloat)alpha{
    //浅颜色
    float red = arc4random_uniform(100) / 100.0;
    float green = arc4random_uniform(100) / 100.0;
    float blue = arc4random_uniform(100) / 100.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//获取随机验证码
- (NSString *)getRandomVerifiCode
{
    if (self.verifiCodeText.length) {
        return self.verifiCodeText;
    } else {
        if (self.verifiCodes.count) {
            NSInteger index = arc4random_uniform((uint32_t)self.verifiCodes.count);
            NSString *verifiCode = [self.verifiCodes objectAtIndex:index];
            return verifiCode;
        } else {
            NSMutableString *verificodeStr = [NSMutableString string];
            for (int i = 0; i < self.verifiCodeLenth; i ++) {
                NSInteger index = arc4random_uniform((uint32_t)self.localVerifiCodes.count);
                NSString *aChar = [self.localVerifiCodes objectAtIndex:index];
                [verificodeStr appendString:aChar];
            }
            return verificodeStr;
        }
    }
}

#pragma mark - setter
- (void)setVerifiCodeText:(NSString *)verifiCodeText
{
    if (verifiCodeText.length) {
        return;
    }
    _verifiCodeText = verifiCodeText;
    self.currentVerificode = verifiCodeText;
    [self getRandomVerifiCode];
}

- (void)setVerifiCodes:(NSArray<NSString *> *)verifiCodes
{
    _verifiCodes = verifiCodes;
    [self changeVerifiCode];
    self.verifiCodeLenth = [[_verifiCodes firstObject] length];
}

- (void)setBgColors:(NSArray<UIColor *> *)bgColors
{
    _bgColors = bgColors;
}

- (void)setBgImages:(NSArray<UIImage *> *)bgImages
{
    _bgImages = bgImages;
}

#pragma mark - getter


-  (NSArray<NSString *> *)localVerifiCodes
{
    if (!_localVerifiCodes) {
        _localVerifiCodes = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    }
    return _localVerifiCodes;
}



- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.clipsToBounds = YES;
        _bgView.userInteractionEnabled = YES;
        _bgView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bgView;
}

@end

