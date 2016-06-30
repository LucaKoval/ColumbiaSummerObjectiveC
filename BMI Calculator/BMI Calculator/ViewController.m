//
//  ViewController.m
//  BMI Calculator
//
//  Created by Luca on 6/30/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = RGB(233, 233, 233);
    self.weightLabel.textAlignment = NSTextAlignmentCenter;
    self.heightLabel.textAlignment = NSTextAlignmentCenter;
    self.unitSystemLabel.textAlignment = NSTextAlignmentCenter;
    self.bmiLabel.textAlignment = NSTextAlignmentCenter;
    self.genderLabel.textAlignment = NSTextAlignmentCenter;
    self.ageLabel.textAlignment = NSTextAlignmentCenter;
    self.bmrLabel.textAlignment = NSTextAlignmentCenter;
    self.weightField.placeholder = @"70";
    self.heightField.placeholder = @"1.89";
    self.genderField.placeholder = @"Female or Male";
    self.ageField.placeholder = @"26";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(id)sender {
    Person* p = [Person sharedPersonInstance];
    p.heightInM = [NSNumber numberWithDouble:self.heightField.text.doubleValue];
    p.weightInKG = [NSNumber numberWithDouble:self.weightField.text.doubleValue];
    p.gender = self.genderField.text;
    p.age = [NSNumber numberWithDouble:self.ageField.text.doubleValue];
    self.bmiLabel.text = p.bmi.stringValue;
    self.bmrLabel.text = p.bmr.stringValue;
    
    //NSNumber* weightClass = p.
    
    UIImage* newImage;
    NSString* path;
    
    NSBundle *myBundle = [NSBundle mainBundle];
    
    // 1 = underweight, 2 = normal weight, 3 = overweight, 4 = class I obesity, 5 = class II obesity, 6 = class III obesity
    // Should update this so it finds based on image name b/c number correspond!
    if (p.bmi.doubleValue < 18.5) {
        path = [myBundle pathForResource:@"1" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 18.5 && p.bmi.doubleValue < 25.0) {
        path = [myBundle pathForResource:@"2" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 25.0 && p.bmi.doubleValue < 30.0) {
        path = [myBundle pathForResource:@"3" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 30.0 && p.bmi.doubleValue < 35.0) {
        path = [myBundle pathForResource:@"4" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 35.0 && p.bmi.doubleValue < 39.9) {
        path = [myBundle pathForResource:@"5" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 40.0) {
        path = [myBundle pathForResource:@"6" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    }
    
    self.myImageView.image = newImage;
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.weightField resignFirstResponder];
    [self.heightField resignFirstResponder];
}

- (IBAction)unitSystemSwitch:(id)sender {
    if (self.unitSystemSwitch.on) {
        self.unitSystemLabel.text = @"Unit system: Metric";
    } else {
        self.unitSystemLabel.text = @"Unit system: Imperial";
    }
}

@end
