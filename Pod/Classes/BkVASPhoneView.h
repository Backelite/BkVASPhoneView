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

#import <UIKit/UIKit.h>

/** Fee Types
 *
 * Set the fee type. 
 * Free is Green with a fee message "Service & appel gratuits"
 * Common is Gray with a fee message "Service gratuit + prix appel"
 * Premium is Purple with a fee message "Service [...] + prix appel"
 */
typedef NS_ENUM(NSInteger, BkVASFeeType) {
    BkVASFeeTypeFree = 0,
    BkVASFeeTypeCommon,
    BkVASFeeTypePremium
};

/** Alignment
 *
 * Set the alignment.
 * Note : Prefer using AutoLayout and the intrinsicContentSize
 */
typedef NS_ENUM(NSInteger, BkVASPhoneAlignment) {
    BkVASPhoneAlignmentLeft = 1,
    BkVASPhoneAlignmentCenter,
    BkVASPhoneAlignmentRight
};

/** Size
 *
 * Set the size.
 * Small for small size
 * Large for large size
 */
typedef NS_ENUM(NSInteger, BkVASPhoneSize) {
    BkVASPhoneSizeSmall = 1,
    BkVASPhoneSizeLarge
};

IB_DESIGNABLE
@interface BkVASPhoneView : UIView

/** Set the alignment
 *
 * (Default: BkVASPhoneAlignmentLeft)
 */
@property (assign, nonatomic) BkVASPhoneAlignment alignment;

/** Type of the VAS phone view
 *
 * (Default: BkVASFeeTypeFree)
 */
@property (assign, nonatomic, readonly) BkVASFeeType type;

/** Size of the VAS phone view
 *
 * (Default: BkVASPhoneSizeSmall)
 */
@property (assign, nonatomic, readonly) BkVASPhoneSize size;

/** Creates and return a VAS Phone view
 *
 * @param phoneNumber The phone number to display
 * @param feeType The fee type
 * @param fee The fee to display. Can be nil and will only be displayed for a BkVASFeeTypePremium.
 */
- (nonnull instancetype)initWithPhoneNumber:(nonnull NSString *)phoneNumber feeType:(BkVASFeeType)feeType fee:(nonnull NSString *)fee size:(BkVASPhoneSize)size NS_DESIGNATED_INITIALIZER;

/** Configure the VAS Phone view
 *
 * @param phoneNumber The phone number to display
 * @param feeType The fee type
 * @param fee The fee to display. Can be nil and will only be displayed for a BkVASFeeTypePremium.
 */
- (void)configureWithPhoneNumber:(nonnull NSString *)phoneNumber feeType:(BkVASFeeType)feeType fee:(nonnull NSString *)fee size:(BkVASPhoneSize)size;

@end
