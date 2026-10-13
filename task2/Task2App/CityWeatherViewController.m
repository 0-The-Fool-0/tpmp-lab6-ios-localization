// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
#import "CityWeatherViewController.h"

@interface CityWeatherViewController ()
@property (nonatomic, strong) UITextField *cityTextField;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *countryLabel;
@property (nonatomic, strong) UILabel *monumentTitleLabel;
@property (nonatomic, strong) UIImageView *monumentImageView;
@property (nonatomic, copy) NSDictionary<NSString *, NSDictionary<NSString *, id> *> *cityData;
@property (nonatomic, copy) NSArray<NSString *> *cityKeys;
@end

@implementation CityWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Task 2.2";
    self.cityData = @{
        @"Rome": @{@"temp": @26, @"country": @"Italy", @"monument": @"Colosseum", @"monumentImageName": @"rome_colosseum"},
        @"Milan": @{@"temp": @22, @"country": @"Italy", @"monument": @"Duomo di Milano", @"monumentImageName": @"milan_duomo"},
        @"Naples": @{@"temp": @24, @"country": @"Italy", @"monument": @"Castel Nuovo", @"monumentImageName": @"naples_castel_nuovo"},
        @"Paris": @{@"temp": @20, @"country": @"France", @"monument": @"Eiffel Tower", @"monumentImageName": @"paris_eiffel_tower"},
        @"Lyon": @{@"temp": @19, @"country": @"France", @"monument": @"Basilica", @"monumentImageName": @"lyon_basilica"},
        @"Marseille": @{@"temp": @21, @"country": @"France", @"monument": @"Notre-Dame de la Garde", @"monumentImageName": @"marseille_notre_dame"}
    };
    self.cityKeys = [[self.cityData allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [self setupUI];
    self.temperatureLabel.text = NSLocalizedString(@"task2_prompt_enter_city", nil);
    self.countryLabel.text = NSLocalizedString(@"task2_prompt_supported_cities", nil);
    self.cityTextField.placeholder = [self.cityKeys componentsJoinedByString:@", "];
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
    self.countryLabel = [[UILabel alloc] init];
    self.monumentTitleLabel = [[UILabel alloc] init];
    self.monumentImageView = [[UIImageView alloc] init];
    self.monumentImageView.contentMode = UIViewContentModeScaleAspectFit;
    for (UILabel *l in @[self.temperatureLabel, self.countryLabel, self.monumentTitleLabel]) {
        l.numberOfLines = 0;
        l.textAlignment = NSTextAlignmentCenter;
        l.translatesAutoresizingMaskIntoConstraints = NO;
    }
    self.monumentImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cityTextField];
    [self.view addSubview:btn];
    [self.view addSubview:self.temperatureLabel];
    [self.view addSubview:self.countryLabel];
    [self.view addSubview:self.monumentTitleLabel];
    [self.view addSubview:self.monumentImageView];
    UILayoutGuide *g = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [self.cityTextField.topAnchor constraintEqualToAnchor:g.topAnchor constant:16],
        [self.cityTextField.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20],
        [self.cityTextField.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20],
        [btn.topAnchor constraintEqualToAnchor:self.cityTextField.bottomAnchor constant:12],
        [btn.centerXAnchor constraintEqualToAnchor:g.centerXAnchor],
        [self.temperatureLabel.topAnchor constraintEqualToAnchor:btn.bottomAnchor constant:16],
        [self.temperatureLabel.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20],
        [self.temperatureLabel.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20],
        [self.countryLabel.topAnchor constraintEqualToAnchor:self.temperatureLabel.bottomAnchor constant:8],
        [self.countryLabel.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20],
        [self.countryLabel.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20],
        [self.monumentTitleLabel.topAnchor constraintEqualToAnchor:self.countryLabel.bottomAnchor constant:8],
        [self.monumentTitleLabel.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20],
        [self.monumentTitleLabel.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20],
        [self.monumentImageView.topAnchor constraintEqualToAnchor:self.monumentTitleLabel.bottomAnchor constant:12],
        [self.monumentImageView.centerXAnchor constraintEqualToAnchor:g.centerXAnchor],
        [self.monumentImageView.widthAnchor constraintEqualToConstant:200],
        [self.monumentImageView.heightAnchor constraintEqualToConstant:150]
    ]];
}

- (void)refreshTapped {
    NSString *city = [self canonicalCityNameForInput:self.cityTextField.text ?: @""];
    NSDictionary *info = self.cityData[city];
    if (!info) {
        self.temperatureLabel.text = NSLocalizedString(@"task2_error_city_not_found", nil);
        self.temperatureLabel.textColor = [UIColor systemRedColor];
        self.countryLabel.text = [NSString stringWithFormat:@"%@: %@",
            NSLocalizedString(@"task2_supported_cities", nil), [self.cityKeys componentsJoinedByString:@", "]];
        self.monumentTitleLabel.text = @"";
        self.monumentImageView.image = nil;
        return;
    }
    NSNumber *temp = info[@"temp"];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@: %@°C", city, temp];
    self.temperatureLabel.textColor = [self colorForTemperature:temp.integerValue];
    self.countryLabel.text = [NSString stringWithFormat:@"%@: %@",
        NSLocalizedString(@"task2_country", nil), info[@"country"]];
    self.monumentTitleLabel.text = [NSString stringWithFormat:@"%@: %@",
        NSLocalizedString(@"task2_monument", nil), info[@"monument"]];
    self.monumentImageView.image = [UIImage imageNamed:info[@"monumentImageName"]];
}

- (NSString *)canonicalCityNameForInput:(NSString *)input {
    NSString *normalized = [[input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    for (NSString *key in self.cityKeys) {
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
