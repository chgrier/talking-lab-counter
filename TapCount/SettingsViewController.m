//
//  SettingsViewController.m
//  TapCount
//
//  Created by Charles Grier on 10/29/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"
#import "Language.h"
#import "SelectLanguageTableTableViewController.h"

@interface SettingsViewController ()
{
    
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   // self.languageNameLeft.text = [defaults objectForKey:@"leftLanguageCode"];
    //NSString *languageNameLeft = [defaults objectForKey:@"leftLanguageName"];
    //NSString *languageCodeLeft = [defaults objectForKey:@"leftLanguageCode"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *leftLanguageCode = [defaults objectForKey:@"leftLanguageCode"];
    NSString *leftLanguageName = [defaults objectForKey:@"leftLanguageName"];
    
    self.settings = [[Settings alloc]init];
    self.settings.vibrateOn = YES;
    self.settings.speechOn = YES;
    self.settings.soundOn = YES;
    self.settings.leftSliderValue = 1.0;
    self.settings.leftLanguageCode = [defaults objectForKey:@"leftLanguageCode"];
    
    self.language = [[Language alloc]init];
    self.language.leftLanguageCode = [defaults objectForKey:@"leftLanguageCode"];
    
    self.languageNameRight.text = @"English (United States)";
    
    if (leftLanguageCode == nil) {
        self.languageNameLeft.text = @"English (United States)";
    } else {
        self.languageNameLeft.text = leftLanguageName;
        NSLog(@"*** Language after view loads (): %@",leftLanguageName);
    }
    
    
    
    SelectLanguageTableTableViewController *languageViewController = [[SelectLanguageTableTableViewController alloc]init];
    languageViewController.delegate = self;
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
     //[self.delegate setSettings:self didSelectSettings:self.settings];
}

#pragma mark - Select Language Delegate

/*
-(void) setSettings:(SettingsViewController *)controller didSelectSettings:(Settings *)settings {
    
    // set selected code passed from settings controls to code object
    self.allSettings = [[Settings alloc]init];
    
    self.allSettings.vibrateOn = settings.vibrateOn;
    self.allSettings.speechOn = settings.speechOn;
    self.allSettings.soundOn = settings.soundOn;
    self.allSettings.leftSliderValue = settings.leftSliderValue;
    
}
*/

-(void) setLanguage:(SelectLanguageTableTableViewController *)controller didSelectLanguage:(Language *)language {
    
    //self.languageSettings = [[Settings alloc]init];
    //self.languageSettings.leftLanguageCode = language.leftLanguageCode;
    
    self.language = [[Language alloc]init];
    self.language = language;
    
    self.languageNameLeft.text = self.language.leftLanguageName;
    
    NSLog(@"**Language code passed: %@", self.language.leftLanguageCode);
    
    self.settings.leftLanguageCode = self.language.leftLanguageCode;
    [self.delegate setSettings:self didSelectSettings:self.settings];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:language.leftLanguageCode forKey:@"leftLanguageCode"];
    [defaults setValue:language.leftLanguageName forKey:@"leftLanguageName"];
    [defaults synchronize];


    
    
}
 
 
// UISWITCH CONTROLS

-(IBAction)vibrateSwitch:(id)sender
{
    
        if ([_vibrateSwitchToggle isOn]) {
        
        self.settings.vibrateOn = YES;
        NSLog(@"Vibrate on");
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        } else {
            
            self.settings.vibrateOn = NO;
            NSLog(@"Vibrate off");
       [self.delegate setSettings:self didSelectSettings:self.settings];
        
            
    }
}

- (IBAction)speechSwitch:(id)sender{
    
    if ([_speechSwitchToggle isOn]) {
        self.settings.speechOn = YES;
        [_soundsSwitchToggle setOn:YES];
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
    } else {
        self.settings.speechOn = NO;
        [self.delegate setSettings:self didSelectSettings:self.settings];
        if (![_vibrateSwitchToggle isOn])
        {
            [_soundsSwitchToggle setOn:NO];
            
        }
    }
}

// cast sender as UISwitch (rather than generic id) to create condition
- (IBAction)soundsSwitch:(UISwitch *)sender
{
    if (sender.on){
        //self.settings.vibrateOn = YES;
        //self.settings.speechOn = YES;
        self.settings.soundOn = YES;
        
        //[self.delegate currencyPicker:self didPickCurrency:currency];
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        //[_speechSwitchToggle setOn:YES];
       // [_vibrateSwitchToggle setOn:YES];
        
    } else {
        
       //self.settings.vibrateOn = NO;
        self.settings.soundOn = NO;
        //self.settings.speechOn = NO;
        
        //[_speechSwitchToggle setOn:NO];
        //[_vibrateSwitchToggle setOn:NO];
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)rightPitchSlider:(id)sender {
    
    
}
- (IBAction)leftSliderChange:(id)sender {
    
    float min = 0.5;
    float max = 1.5;
    
    self.leftPitchSlider.minimumValue = min;
    self.leftPitchSlider.maximumValue = max;
    NSLog(@"%f", self.leftPitchSlider.value);
    
    self.settings.LeftSliderValue = self.leftPitchSlider.value;
    
    [self.delegate setSettings:self didSelectSettings:self.settings];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SelectLanguage"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        // 2
        SelectLanguageTableTableViewController *controller = (SelectLanguageTableTableViewController *) navigationController.topViewController;
        // 3
        controller.delegate = self;
}
}


@end
