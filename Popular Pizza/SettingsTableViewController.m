//
//  SettingsTableViewController.m
//  Popular Pizza
//
//  Created by Jack Wright on 12/17/16.
//  Copyright © 2016 Jack Wright. All rights reserved.
//

#import "SettingsTableViewController.h"

#define kMaxPopularDefault @20

@interface SettingsTableViewController ()

@property (nonatomic, strong) NSNumber *maxPopular;

@end

@implementation SettingsTableViewController

+ (void) initialize
{
	// Register a default value for maxPopular
	
	NSDictionary *defaults = @{ kMaxPopularKey: kMaxPopularDefault };
	
	[[ NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

#pragma mark - view controller delegate methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	_maxPopular = [[NSUserDefaults standardUserDefaults] objectForKey:kMaxPopularKey];
	
	if (_maxPopular) {
		[_maxPopularTextField setText: [NSString stringWithFormat:@"%@", [_maxPopular stringValue]]];
	} else {
		[_maxPopularTextField setText: [NSString stringWithFormat:@"%@", [kMaxPopularDefault stringValue]]];
	}
	
	// put the cursor in the text field and bring up the keyboard
	[_maxPopularTextField becomeFirstResponder];
}

#pragma mark -

- (IBAction)done:(UIBarButtonItem *)sender
{
	NSInteger max = [_maxPopularTextField.text integerValue];
	NSNumber *maxPopular = [NSNumber numberWithInteger:max];
	[self setMaxPopular:maxPopular];
	
	// dismiass the keyboard
	
	[_maxPopularTextField resignFirstResponder];
}

- (void) setMaxPopular:(NSNumber *)maxPopular
{
	_maxPopular = maxPopular;
	
	// Persist in user defaults
	[[NSUserDefaults standardUserDefaults] setObject:_maxPopular forKey:kMaxPopularKey];

}

@end
