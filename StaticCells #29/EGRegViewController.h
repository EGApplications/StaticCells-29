//
//  EGRegViewController.h
//  StaticCells #29
//
//  Created by Евгений Глухов on 28.05.15.
//  Copyright (c) 2015 EG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGRegViewController : UITableViewController

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *mainTextFields;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *mainLabels;

@property (weak, nonatomic) IBOutlet UISwitch *subscribeSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *receivingNewsControl;
@property (weak, nonatomic) IBOutlet UISlider *newsPerDaySlider;

@property (weak, nonatomic) IBOutlet UILabel *newsCountLabel;



- (IBAction)subscriptionActions:(id)sender;

- (IBAction)actionTextFieldChanged:(UITextField *)sender;



@end
