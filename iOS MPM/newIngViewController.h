//
//  newIngViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/24/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newIngViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *ingNameTF;
- (IBAction)submitBTN:(id)sender;

@end
