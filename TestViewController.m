//
//  TestViewController.m
//  QuickApp
//
//  Created by Todd Laney on 5/17/20.
//  Copyright © 2020 Wombat. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PopupSegmentedControl.h"

@interface TestViewController : UIViewController

@end

@implementation TestViewController

-(void)segChange:(UISegmentedControl*)seg {
    NSLog(@"SEG CHANGE: %d - %@", (int)seg.selectedSegmentIndex, [seg titleForSegmentAtIndex:seg.selectedSegmentIndex]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemPurpleColor;
    
    // move title to the left.
    UILabel* title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:32.0 weight:UIFontWeightHeavy];
    title.text = self.title;
        
    self.navigationItem.title = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:title];

    if (@available(iOS 13.0, *)) {
        self.navigationController.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        [self.navigationController.view setNeedsLayout];
    }
    else
    {
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        title.textColor = UIColor.whiteColor;
        UISegmentedControl* appearance = [UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]];
        [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    }

    UISegmentedControl* seg1 = [[PopupSegmentedControl alloc] initWithItems:@[@"Aa", @"BbbBbb", @"Cc"]];
    seg1.selectedSegmentIndex = 0;
    [seg1 addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];

    UISegmentedControl* seg2 = [[PopupSegmentedControl alloc] initWithItems:@[@"Aaa", @"BbbBbbb", @"Ccc", @"Ddddd", @"Eeeeeee"]];
    seg2.selectedSegmentIndex = 1;
    [seg2 addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
        
    UISegmentedControl* seg3 = [[PopupSegmentedControl alloc] initWithItems:@[@"Aaa", @"BbbBbbb", @"Ccc"]];
    seg3.momentary = TRUE;
    [seg3 setTitle:@"😛" forSegmentAtIndex:UISegmentedControlNoSegment];
    [seg3 addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
        
    UISegmentedControl* seg4;

    if (@available(iOS 13.0, *)) {
        seg4 = [[PopupSegmentedControl alloc] initWithItems:@[
            [UIImage systemImageNamed:@"square.grid.4x3.fill"],
            [UIImage systemImageNamed:@"rectangle.grid.2x2.fill"],
            [UIImage systemImageNamed:@"rectangle.stack.fill"],
            [UIImage systemImageNamed:@"rectangle.grid.1x2.fill"]
        ]];
    }
    else {
        seg4 = [[PopupSegmentedControl alloc] initWithItems:@[@"⚏", @"☷", @"▢", @"☰"]];
    }
    seg4.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [seg4 addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];

    UISegmentedControl* appearance = [UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    if (@available(iOS 13.0, *)) {
        appearance.selectedSegmentTintColor = self.view.tintColor;
    }

    self.navigationItem.rightBarButtonItems = @[
        [[UIBarButtonItem alloc] initWithCustomView:seg1],
        [[UIBarButtonItem alloc] initWithCustomView:seg2],
        [[UIBarButtonItem alloc] initWithCustomView:seg3],
        [[UIBarButtonItem alloc] initWithCustomView:seg4],
    ];
}

@end
