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

#import "VASTableViewController.h"
#import "BkVASPhoneView.h"
#import "UIColor+BkVASPhoneView.h"
#import "VASTableViewCell.h"

@interface VASTableViewController ()
@property (strong, nonatomic) NSArray *colors;
@property (strong, nonatomic) NSArray *types;
@property (strong, nonatomic) NSArray *alignements;
@property (strong, nonatomic) NSArray *larges;
@end

@implementation VASTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.navigationController.navigationBar.barTintColor = [UIColor vas_purpleColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

    self.tableView.rowHeight = 60.0f;
    self.title = @"SVA numero surtaxé";
    
    self.types = @[
        @(BkVASFeeTypeFree),
        @(BkVASFeeTypeCommon),
        @(BkVASFeeTypePremium)
    ];

    self.alignements = @[
        @(BkVASPhoneAlignmentLeft),
        @(BkVASPhoneAlignmentCenter),
        @(BkVASPhoneAlignmentRight)
    ];

    self.larges = @[
        @(true),
        @(false)
    ];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName;
    switch (section) {
    case 0:
        sectionName = @"Type choices";
        break;
    case 1:
        sectionName = @"Alignement choices";
        break;

    default:
        sectionName = @"Small size or big Size";
        break;
    }
    return sectionName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
    case 0:
        return self.types.count;

    case 1:
        return self.alignements.count;

    case 2:
        return self.larges.count;
    }
    return 0;
}

- (VASTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VASTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VASTableViewCell" forIndexPath:indexPath];

    switch (indexPath.section) {
    case 0: {
        [cell.phoneView configureWithPhoneNumber:@"0 825 123 456" feeType:[self.types[indexPath.row] integerValue] fee:@"0,34€/min" size:BkVASPhoneSizeSmall];
        cell.phoneView.alignment = BkVASPhoneAlignmentCenter;
        break;
    }

    case 1: {
        [cell.phoneView configureWithPhoneNumber:@"0 825 123 456" feeType:BkVASFeeTypeFree fee:nil size:BkVASPhoneSizeSmall];

        cell.phoneView.alignment = [self.alignements[indexPath.row] integerValue];
        break;
    }
    case 2: {
        BOOL useBigSize = [self.larges[indexPath.row] boolValue];
        [cell.phoneView configureWithPhoneNumber:@"0 825 123 456" feeType:BkVASFeeTypePremium fee:@"0,34€/min" size:useBigSize ? BkVASPhoneSizeSmall : BkVASPhoneSizeLarge];
        cell.phoneView.alignment = BkVASPhoneAlignmentCenter;
        break;
    }
    }

    return cell;
}

@end
