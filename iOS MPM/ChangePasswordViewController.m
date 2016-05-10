
#import "ChangePasswordViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

@synthesize emailResetTF;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)changePasswordBTN:(id)sender {
    
    //check if the user has filled in the textfield

    if( [emailResetTF.text isEqualToString:@""] || emailResetTF.text == nil ){
        
        UIAlertController *resetFailed = [UIAlertController alertControllerWithTitle:@"Reset Failed"
                                                                                    message: @"Check Inputs"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Retry = [UIAlertAction
                                actionWithTitle:@"Retry"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [resetFailed dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
        
        [resetFailed addAction: Retry];
        
        [self presentViewController:resetFailed animated:YES completion:nil];
        
    }

    else{
        //looks like everything checks out, send the user an email to reset their password
        [PFUser requestPasswordResetForEmailInBackground:emailResetTF.text];
        
        UIAlertController *resetSuccess = [UIAlertController alertControllerWithTitle:@"Reset Instructions Sent"
                                                                              message: @"Check Email"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [resetSuccess dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [resetSuccess addAction: ok];
        
        [self presentViewController:resetSuccess animated:YES completion:nil];
        
        //show that the reset was successful 
        [self performSegueWithIdentifier:@"resetSuccess" sender:self];

       
    }
   
    
}


@end
