//
//  SceneDelegate.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "SceneDelegate.h"
#import "PlayViewController.h"
#import "UIImage+SFFont.h"
#import "HomeViewController.h"
#import "MusicPlayerView.h"
#import "VoiceSearchCenter.h"
#import "Common.h"


@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    homeViewController.view.backgroundColor = [UIColor whiteColor];
    homeViewController.title = @"歌单";
    homeViewController.tabBarItem.image = [UIImage systemImageNamed:@"list.dash"];
    
    UINavigationController *navi_1 = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    [tabBarController addChildViewController:navi_1];
    
    UIViewController *controller2 = [[UIViewController alloc] init];
    controller2.view.backgroundColor = [UIColor whiteColor];
    controller2.title = @"我的";
    controller2.tabBarItem.image = [UIImage systemImageNamed:@"person.fill"];
    UINavigationController *navi_2 = [[UINavigationController alloc]initWithRootViewController:controller2];

    [tabBarController addChildViewController:navi_2];
    tabBarController.tabBar.hidden = YES;
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
 
    //一直处于下方的播放控制view
    CGFloat tabHeight = tabBarController.tabBar.frame.size.height;

    
//    CGFloat naviHeight = navi_1.navigationBar.frame.size.height;b
    MusicPlayerView *view1 = [[MusicPlayerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-tabHeight-100, SCREENWIDTH, 100)];
    view1.backgroundColor = [UIColor redColor];

    [tabBarController.view addSubview:view1];
    [tabBarController.view bringSubviewToFront:view1];
    
    VoiceSearchCenter *VSCenter = [VoiceSearchCenter defaultCenter];
    [VSCenter setFrameWithRect:CGRectMake(0, CGRectGetMaxY(view1.frame), SCREENWIDTH, SCREENHEIGHT-CGRectGetMaxY(view1.frame))];
    
    [tabBarController.view addSubview:VSCenter.view];
    
    [tabBarController.view bringSubviewToFront:view1];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
