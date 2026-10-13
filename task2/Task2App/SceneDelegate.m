#import "SceneDelegate.h"
#import "WeatherTask21ViewController.h"
#import "CityWeatherViewController.h"

@implementation SceneDelegate
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *ws = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:ws];
    WeatherTask21ViewController *w = [[WeatherTask21ViewController alloc] init];
    w.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"2.1" image:nil tag:0];
    CityWeatherViewController *c = [[CityWeatherViewController alloc] init];
    c.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"2.2" image:nil tag:1];
    UITabBarController *tabs = [[UITabBarController alloc] init];
    tabs.viewControllers = @[
        [[UINavigationController alloc] initWithRootViewController:w],
        [[UINavigationController alloc] initWithRootViewController:c]
    ];
    self.window.rootViewController = tabs;
    [self.window makeKeyAndVisible];
}
@end
