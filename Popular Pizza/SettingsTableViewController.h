//
//  SettingsTableViewController.h
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMaxPopularKey @"maxPopular"

@interface SettingsTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *maxPopularTextField;

@end
