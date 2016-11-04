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

#import "UIFont+BkVASPhoneView.h"
#import <CoreText/CoreText.h>

@implementation UIFont (BkVASPhoneView)

+ (UIFont *)vas_boldArialFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Arial-BoldMT" size:size];
}

+ (UIFont *)vas_exoFontOfSize:(CGFloat)size {
    NSString *fontName = @"Exo-Bold";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (font == nil) {
        [self dynamicallyLoadFontNamed:fontName];
        font = [UIFont fontWithName:fontName size:size];
        // safe fallback
        if (!font)
            font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (void)dynamicallyLoadFontNamed:(NSString *)name {
    NSString *resourceName = [NSString stringWithFormat:@"%@/%@", @"BkVASPhoneView.bundle", name];
    NSURL *url = [[NSBundle bundleForClass:NSClassFromString(@"BkVASPhoneView")] URLForResource:resourceName withExtension:@"otf"];
    NSData *fontData = [NSData dataWithContentsOfURL:url];
    if (fontData) {
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(font);
        CFRelease(provider);
    }
}

@end