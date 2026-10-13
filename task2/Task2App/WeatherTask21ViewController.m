// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
#import "WeatherTask21ViewController.h"

@interface WeatherTask21ViewController ()
@property (nonatomic, strong) UITextField *cityTextField;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, copy) NSDictionary<NSString *, NSNumber *> *temperatures;
@property (nonatomic, copy) NSArray<NSString *> *supportedCities;
@end

@implementation WeatherTask21ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Task 2.1";
    self.temperatures = @{
        @"Minsk": @15, @"Brest": @14, @"Rome": @26,
        @"Milan": @22, @"Paris": @20, @"Lyon": @19
    };
    self.supportedCities = [[self.temperatures allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self setupUI];
    self.temperatureLabel.text = NSLocalizedString(@"task21_prompt", nil);
    self.cityTextField.placeholder = [self.supportedCities componentsJoinedByString:@", "];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.cityTextField = [[UITextField alloc] init];
    self.cityTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.cityTextField.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Refresh" forState:UIControlStateNormal];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn addTarget:self action:@selector(refreshTapped) forControlEvents:UIControlEventTouchUpInside];
    self.temperatureLabel = [[UILabel alloc] init];
    self.temperatureLabel.numberOfLines = 0;
    self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
    self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cityTextField];
    [self.view addSubview:btn];
    [self.view addSubview:self.temperatureLabel];
    UILayoutGuide *g = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [self.cityTextField.topAnchor constraintEqualToAnchor:g.topAnchor constant:24],
        [self.cityTextField.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20],
        [self.cityTextField.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20],
        [btn.topAnchor constraintEqualToAnchor:self.cityTextField.bottomAnchor constant:16],
        [btn.centerXAnchor constraintEqualToAnchor:g.centerXAnchor],
        [self.temperatureLabel.topAnchor constraintEqualToAnchor:btn.bottomAnchor constant:24],
        [self.temperatureLabel.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20],
        [self.temperatureLabel.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20]
    ]];
}

- (void)refreshTapped {
    NSString *input = self.cityTextField.text ?: @"";
    NSString *city = [self canonicalCityNameForInput:input];
    NSNumber *temperature = self.temperatures[city];
    if (temperature == nil) {
        self.temperatureLabel.text = [NSString stringWithFormat:@"%@: %@",
            NSLocalizedString(@"task21_not_found", nil),
            [self.supportedCities componentsJoinedByString:@", "]];
        self.temperatureLabel.textColor = [UIColor systemRedColor];
        return;
    }
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@: %@°C", city, temperature];
    self.temperatureLabel.textColor = [self colorForTemperature:temperature.integerValue];
}

- (NSString *)canonicalCityNameForInput:(NSString *)input {
    NSString *normalized = [[input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    for (NSString *key in self.supportedCities) {
        if ([[key lowercaseString] isEqualToString:normalized]) return key;
    }
    return input;
}

- (UIColor *)colorForTemperature:(NSInteger)temperature {
    if (temperature <= 0) return [UIColor systemBlueColor];
    if (temperature <= 15) return [UIColor systemTealColor];
    if (temperature <= 25) return [UIColor systemOrangeColor];
    return [UIColor systemRedColor];
}
@end
