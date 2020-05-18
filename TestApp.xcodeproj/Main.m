//
//  Main.m
//
//  a single file (or as close as you can get) iOS app, you just define a class called:
//  MainViewController, TextViewController, or RootViewController in another file.
//
//  Created by Todd Laney on 5/17/20.
//  Copyright © 2020 Wombat. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma mark - MainAppDelegate

@interface MainAppDelegate : UIResponder <UIApplicationDelegate>
@property (nullable, nonatomic, strong) UIWindow *window;
@end

@implementation MainAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString* name = NSBundle.mainBundle.infoDictionary[@"CFBundleName"];
    
    // find a UIViewController subclass to use as the root view, either a ObjC class, or a Swift class.
    Class main = NSClassFromString(@"RootViewController") ?:
                 NSClassFromString(@"MainViewController") ?:
                 NSClassFromString(@"TestViewController") ?:
                 NSClassFromString(@"ViewController") ?:
                 NSClassFromString([NSString stringWithFormat:@"%@.RootViewController", name]) ?:
                 NSClassFromString([NSString stringWithFormat:@"%@.MainViewController", name]) ?:
                 NSClassFromString([NSString stringWithFormat:@"%@.TestViewController", name]) ?:
                 NSClassFromString([NSString stringWithFormat:@"%@.ViewController", name]) ?:
                 NSClassFromString(@"UIViewController");
    
    UIViewController* root = [[main alloc] init];
    root.title = name;
    
    if (![NSStringFromClass(main) containsString:@"RootViewController"])
        root = [[UINavigationController alloc] initWithRootViewController:root];

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setRootViewController:root];
    [_window makeKeyAndVisible];

    return YES;
}

@end

#pragma mark - main

int main(int argc, char * argv[]) {
    return UIApplicationMain(argc, argv, nil, NSClassFromString(@"AppDelegate") ? @"AppDelegate" : @"MainAppDelegate");
}
