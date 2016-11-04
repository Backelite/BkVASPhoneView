//
// The MIT License (MIT)
//
// Copyright (c) 2016 Backelite
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "BkVASPhoneView.h"
#import "UIFont+BkVASPhoneView.h"
#import "UIColor+BkVASPhoneView.h"

const CGFloat BkVASPhoneNumberFrameHeightBig = 36.0f;
const CGFloat BkVASPhoneNumberFrameHeight = 22.0f;
const CGFloat BkVASPhoneNumberPaddingBig = 8.0f;
const CGFloat BkVASPhoneNumberPadding = 5.0f;

const CGFloat BkVASPhoneFeeLabelPaddingLeftBig = 14.0f;
const CGFloat BkVASPhoneFeeLabelPaddingLeft = 10.0f;
const CGFloat BkVASPhoneFeeLabelPaddingRightBig = 8.0f;
const CGFloat BkVASPhoneFeeLabelPaddingRight = 5.0f;

const CGFloat BkVASPhoneFeeFrameHeightBig = 40.0f;
const CGFloat BkVASPhoneFeeFrameHeight = 24.0f;

const CGFloat BkVASPhoneFeeArrowSizeBig = 8.0f;
const CGFloat BkVASPhoneFeeArrowSize = 6.0f;

const CGFloat BkVASPhoneRightMarginWidthBig = 8.0f;
const CGFloat BkVASPhoneRightMarginWidth = 6.0f;

const CGFloat BkVASDefaultPhoneLabelFontSizeBig = 26.0f;
const CGFloat BkVASDefaultPhoneLabelFontSize = 17.0f;

const CGFloat BkVASDefaultFeeLabelFontSizeBig = 20.0f;
const CGFloat BkVASDefaultFeeLabelFontSize = 15.0f;
const CGFloat BkVASDefaultMultipleLineFeeLabelFontSizeBig = 15.0f;
const CGFloat BkVASDefaultMultipleLineFeeLabelFontSize = 10.0f;

@interface BkVASPhoneView ()

@property (nonatomic) UILabel *phoneNumberLabel;
@property (nonatomic) UILabel *feeLabel;

// Inspectable properties
@property (assign, nonatomic) IBInspectable NSInteger alignment_1_2_3;
@property (assign, nonatomic) IBInspectable NSInteger feeType_0_1_2;
@property (assign, nonatomic) IBInspectable NSInteger size_1_2;

@property (copy, nonatomic) IBInspectable NSString *phoneNumber;
@property (copy, nonatomic) IBInspectable NSString *fee;

@property (assign, nonatomic, readwrite) BkVASFeeType type;
@property (assign, nonatomic, readwrite) BkVASPhoneSize size;

@end

@implementation BkVASPhoneView

#pragma mark - LifeCycle

- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber feeType:(BkVASFeeType)feeType fee:(NSString *)fee size:(BkVASPhoneSize)size {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupDefaultValues];
        [self setupPhoneSubviews];
        [self configureWithPhoneNumber:phoneNumber feeType:feeType fee:fee size:size];
        
        self.frame = CGRectMake(0.f, 0.f, [self intrinsicContentSize].width, self.intrinsicContentSize.height);
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultValues];
        [self setupPhoneSubviews];
    }
    return self;
}
#pragma clang diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupDefaultValues];
        [self setupPhoneSubviews];
    }
    return self;
}
#pragma clang diagnostic pop

- (void)setAlignment_1_2_3:(NSInteger)alignementType {
    _alignment = (BkVASPhoneAlignment)alignementType;
}

- (void)setFeeType_0_1_2:(NSInteger)feeType {
    _type = (BkVASFeeType)feeType;
}

- (void)setSize_1_2:(NSInteger)size {
    _size = (BkVASPhoneSize)size;
}

#pragma mark -

- (void)setupPhoneSubviews {
    self.phoneNumberLabel = [[UILabel alloc] initWithFrame:[self phoneNumberRectFrame]];
    [self addSubview:self.phoneNumberLabel];

    CGRect feeRectFrame = NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0 ? CGRectOffset([self feeRectFrame], 0., 1.) : [self feeRectFrame];
    self.feeLabel = [[UILabel alloc] initWithFrame:feeRectFrame];
    [self addSubview:self.feeLabel];
}

- (void)setupDefaultValues {
    _alignment = BkVASPhoneAlignmentCenter;
    _phoneNumber = @"0 825 123 456";
    _fee = @"0,34 € / min";
    _type = BkVASFeeTypeFree;
    _size = BkVASPhoneSizeSmall;
}

#pragma mark - Configure view

- (void)configureWithPhoneNumber:(NSString *)phoneNumber feeType:(BkVASFeeType)feeType fee:(NSString *)fee size:(BkVASPhoneSize)size {
    self.phoneNumber = phoneNumber;
    self.type = feeType;
    self.fee = fee;
    self.size = size;
    
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

#pragma mark - Layout / Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Clear context
    CGContextClearRect(ctx, rect);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillRect(ctx, rect);

    CGRect mainFrame = [self mainFrameRect];
    CGContextSetLineWidth(ctx, 1);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:164. / 255. green:164. / 255. blue:164. / 255. alpha:1.].CGColor);
    CGContextAddRect(ctx, mainFrame);
    CGContextDrawPath(ctx, kCGPathFillStroke);

    CGContextSetStrokeColorWithColor(ctx, [self vasColorForCurrentFeeType].CGColor);
    CGContextSetFillColorWithColor(ctx, [self vasColorForCurrentFeeType].CGColor);
    CGContextAddPath(ctx, [self feeFramePath]);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.phoneNumberLabel != nil) {
        self.phoneNumberLabel.frame = [self phoneNumberRectFrame];
        self.phoneNumberLabel.backgroundColor = [UIColor clearColor];
        self.phoneNumberLabel.text = self.phoneNumber;
        self.phoneNumberLabel.textAlignment = NSTextAlignmentCenter;
        self.phoneNumberLabel.font = [UIFont vas_boldArialFontOfSize:[self useBigSize] ? BkVASDefaultPhoneLabelFontSizeBig : BkVASDefaultPhoneLabelFontSize];
        self.phoneNumberLabel.adjustsFontSizeToFitWidth = YES;
        self.phoneNumberLabel.textColor = [self vasColorForCurrentFeeType];
    }

    if (self.feeLabel != nil) {
        CGRect feeRectFrame = CGRectOffset([self feeRectFrame], 0.0f, 1.0f); // Set an y-offset to adjust positioning
        self.feeLabel.frame = feeRectFrame;
        self.feeLabel.attributedText = [self attributedCostText];
        self.feeLabel.textAlignment = NSTextAlignmentLeft;
        self.feeLabel.numberOfLines = 2;
    }
}

#pragma mark - Autolayout

- (CGSize)intrinsicContentSize {
    CGSize mainFrameSize = [self mainFrameRect].size;
    CGSize feeFrameSize = [self feeRectFrame].size;
    return CGSizeMake(fmaxf(mainFrameSize.width, feeFrameSize.width) + 1.0, fmaxf(mainFrameSize.height, feeFrameSize.height) + 1.0);
}

#pragma mark -

- (CGFloat)phoneNumberLabelWidth {
    CGSize size = [self.phoneNumber sizeWithAttributes:@{NSFontAttributeName : [UIFont vas_boldArialFontOfSize:[self useBigSize] ? BkVASDefaultPhoneLabelFontSizeBig : BkVASDefaultPhoneLabelFontSize]}];
    return size.width + 2. * ([self useBigSize] ? BkVASPhoneNumberPaddingBig : BkVASPhoneNumberPadding);
}

- (CGFloat)feeLabelWdith {
    CGFloat fontSize = [self useBigSize] ? BkVASDefaultMultipleLineFeeLabelFontSizeBig : BkVASDefaultMultipleLineFeeLabelFontSize;
    CGSize size = [[self feeAttributedString] size];
    return size.width;
}

- (CGRect)mainFrameRect {
    CGRect f = CGRectZero;
    if ([self useBigSize]) {
        f.size.width = [self phoneNumberLabelWidth] + BkVASPhoneRightMarginWidthBig;
        f.size.width += BkVASPhoneFeeLabelPaddingLeftBig + BkVASPhoneFeeLabelPaddingRightBig;
        f.size.height = BkVASPhoneNumberFrameHeightBig;

    } else {
        f.size.width = [self phoneNumberLabelWidth] + BkVASPhoneRightMarginWidth;
        f.size.width += BkVASPhoneFeeLabelPaddingLeft + BkVASPhoneFeeLabelPaddingRight;
        f.size.height = BkVASPhoneNumberFrameHeight;
    }
    f.size.width += [self feeLabelWdith];

    if (self.alignment == BkVASPhoneAlignmentCenter) {
        f.origin.x = floorf((self.bounds.size.width - f.size.width) / 2.);

    } else if (self.alignment == BkVASPhoneAlignmentLeft) {
        f.origin.x = 0.;

    } else if (self.alignment == BkVASPhoneAlignmentRight) {
        f.origin.x = self.bounds.size.width - f.size.width - 1.;
    }
    f.origin.y = floorf((self.bounds.size.height - f.size.height) / 2.);
    return f;
}

- (CGMutablePathRef)feeFramePath {
    CGMutablePathRef path = CGPathCreateMutable();

    CGFloat paddingLeft = [self useBigSize] ? BkVASPhoneFeeLabelPaddingLeftBig : BkVASPhoneFeeLabelPaddingLeft;
    CGFloat paddingRight = [self useBigSize] ? BkVASPhoneFeeLabelPaddingRightBig : BkVASPhoneFeeLabelPaddingRight;
    CGFloat height = [self useBigSize] ? BkVASPhoneFeeFrameHeightBig : BkVASPhoneFeeFrameHeight;
    CGFloat width = paddingRight + paddingLeft + [self feeLabelWdith];
    CGFloat arrowSize = [self useBigSize] ? BkVASPhoneFeeArrowSizeBig : BkVASPhoneFeeArrowSize;

    CGFloat x = [self mainFrameRect].origin.x + [self phoneNumberLabelWidth];
    CGFloat y = [self mainFrameRect].origin.y - (height - [self mainFrameRect].size.height) / 2.;

    CGPathMoveToPoint(path, nil, x, y);
    CGPathAddLineToPoint(path, nil, x + width, y);
    CGPathAddLineToPoint(path, nil, x + width, y + height);
    CGPathAddLineToPoint(path, nil, x, y + height);

    CGPathAddLineToPoint(path, nil, x, y + height / 2. + arrowSize);
    CGPathAddLineToPoint(path, nil, x + arrowSize, y + height / 2.);
    CGPathAddLineToPoint(path, nil, x, y + height / 2. - arrowSize);

    CGPathCloseSubpath(path);
    return path;
}

- (CGRect)phoneNumberRectFrame {
    CGRect rect = CGRectZero;
    rect.origin = [self mainFrameRect].origin;
    if ([self useBigSize]) {
        rect.size = CGSizeMake([self phoneNumberLabelWidth], BkVASPhoneNumberFrameHeightBig);
    } else {
        rect.size = CGSizeMake([self phoneNumberLabelWidth], BkVASPhoneNumberFrameHeight);
    }
    return rect;
}

- (CGRect)feeRectFrame {
    CGFloat paddingLeft = [self useBigSize] ? BkVASPhoneFeeLabelPaddingLeftBig : BkVASPhoneFeeLabelPaddingLeft;
    CGFloat height = [self useBigSize] ? BkVASPhoneFeeFrameHeightBig : BkVASPhoneFeeFrameHeight;
    CGFloat x = [self mainFrameRect].origin.x + [self phoneNumberLabelWidth];
    CGFloat y = [self mainFrameRect].origin.y - (height - [self mainFrameRect].size.height) / 2.;

    CGRect rect = CGRectZero;
    rect.origin.x = x + paddingLeft;
    rect.origin.y = y;
    rect.size.width = [self feeLabelWdith];
    rect.size.height = height;

    return rect;
}

#pragma mark - Private

- (NSAttributedString *)attributedCostText {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:[self feeAttributedString]];
    
    CGFloat fontSize = [self useBigSize] ? BkVASDefaultMultipleLineFeeLabelFontSizeBig : BkVASDefaultMultipleLineFeeLabelFontSize;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = 0;
    CGFloat lineHeightGap = [self useBigSize] ? -2 : -1;
    [paragraphStyle setMaximumLineHeight:[self phoneNumberRectFrame].size.height / 2. + lineHeightGap];
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attrString.length)];
    
    return attrString;
}

- (NSAttributedString *)feeAttributedString {
    NSMutableAttributedString *attrString = nil;
    
    CGFloat fontSize = [self useBigSize] ? BkVASDefaultMultipleLineFeeLabelFontSizeBig : BkVASDefaultMultipleLineFeeLabelFontSize;
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont vas_exoFontOfSize:fontSize], NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSDictionary *feeAttributes = @{NSFontAttributeName : [UIFont vas_boldArialFontOfSize:fontSize], NSForegroundColorAttributeName : [UIColor whiteColor]};
    switch (self.type) {
        case BkVASFeeTypeFree:
        {
            attrString = [[NSMutableAttributedString alloc] initWithString:@"Service & appel\ngratuits" attributes:attributes];
        }
            break;
        case BkVASFeeTypeCommon:
        {
            attrString = [[NSMutableAttributedString alloc] initWithString:@"Service gratuit\n+ prix appel" attributes:attributes];
        }
            break;
        case BkVASFeeTypePremium:
        {
            NSString *string = [NSString stringWithFormat:@"Service %@\n+ prix appel", self.fee];
            NSRange feeRange = [string rangeOfString:self.fee];
            attrString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
            [attrString addAttributes:feeAttributes range:feeRange];
        }
            break;
    }

    return attrString;
}

- (UIColor *)vasColorForCurrentFeeType {
    switch (self.type) {
        case BkVASFeeTypeFree:
            return [UIColor vas_greenColor];
        case BkVASFeeTypeCommon:
            return [UIColor vas_grayColor];
        case BkVASFeeTypePremium:
            return [UIColor vas_purpleColor];
    }
}

- (BOOL)useBigSize {
    return self.size == BkVASPhoneSizeLarge;
}

@end
