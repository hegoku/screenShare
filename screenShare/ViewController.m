//
//  ViewController.m
//  screenShare
//
//  Created by Jack on 6/29/16.
//  Copyright © 2016 Jack. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Recorder *recorder=[Recorder new];
    NSString *urlString = @"/Users/jack/a.mpeg4";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
    [recorder screenRecording:url];
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
