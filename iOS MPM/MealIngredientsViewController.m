//
//  MealIngredientsViewController.m
//  iOS MPM
//
//  Created by guest on 4/4/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import "MealIngredientsViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface MealIngredientsViewController ()

@end

@implementation MealIngredientsViewController

@synthesize InstructionsLBL, mealNameLBL;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InstructionsLBL.text = @"Tap once on ingredients to Like. Tap twice on ingredients to Dislike.";
    mealNameLBL.text = _clickedMealName;
    _textView.text = _clickedMealIngredeients;
    _textView.text = [_textView.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    string = [[NSMutableAttributedString alloc]initWithString:_textView.text];
    words = [_textView.text componentsSeparatedByString:@" "];
    
    
    
    selectedLikes = [[NSMutableArray alloc] initWithArray:[[PFUser currentUser] valueForKey:@"selectedLikes"]];
    selectedDislikes = [[NSMutableArray alloc] initWithArray:[[PFUser currentUser] valueForKey:@"selectedDislikes"]];
    
    for (NSString *word in words) {
        //NSLog(@"%@", word);
        if ([selectedLikes containsObject:word]) {
            NSRange range=[_textView.text rangeOfString:word];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range];
            [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:30.0f] range:range];

        }
        
        else if ([selectedDislikes containsObject:word]){
            NSRange range=[_textView.text rangeOfString:word];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
            [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:30.0f] range:range];

        }

    }
    [_textView setAttributedText:string];


    
    
    
    //----firstly you have to alloc the double and single tap gesture-------//
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleDoubleTap:)];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleSingleTap:)];
    
    [singleTap requireGestureRecognizerToFail : doubleTap];
    [doubleTap setDelaysTouchesBegan : YES];
    [singleTap setDelaysTouchesBegan : YES];
    
    //-----------------------number of tap----------------//
    [doubleTap setNumberOfTapsRequired : 2];
    [singleTap setNumberOfTapsRequired : 1];
    
    //------- add double tap and single tap gesture on the view or button--------//
    [_textView addGestureRecognizer : doubleTap];
    [_textView addGestureRecognizer : singleTap];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString*)getPressedWordWithRecognizer:(UIGestureRecognizer*)recognizer
{
    
    CGPoint location = [recognizer locationInView:_textView];
    UITextPosition *tapPosition = [_textView closestPositionToPoint:location];
    UITextRange *textRange = [_textView.tokenizer rangeEnclosingPosition:tapPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    
    return [_textView textInRange:textRange];
}

-(void)handleSingleTap:(UITapGestureRecognizer*)recognizer
{
    
    //NSLog(@"Single Tap On: %@", [self getPressedWordWithRecognizer:recognizer]);
    
    
    if ([[self getPressedWordWithRecognizer:recognizer] isEqualToString:@""]){
        NSLog(@"you clicked on nothing this will be ignored");
    }
    

    if ([selectedLikes containsObject:[self getPressedWordWithRecognizer:recognizer]]){
        
        [selectedLikes removeObject:[self getPressedWordWithRecognizer:recognizer]];
        [[PFUser currentUser] removeObject:[self getPressedWordWithRecognizer:recognizer] forKey:@"selectedLikes"];
        [[PFUser currentUser] saveInBackground];

        
        for (NSString *word in words) {
            if ([word containsString:[self getPressedWordWithRecognizer:recognizer]]) {
                NSRange range=[_textView.text rangeOfString:word];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
                [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:12.0f] range:range];
                
            }
            
        }
        
        [_textView setAttributedText:string];
    
        
    }
    else{
        [selectedLikes addObject:[self getPressedWordWithRecognizer:recognizer]];
        [[PFUser currentUser] addUniqueObject:[self getPressedWordWithRecognizer:recognizer] forKey:@"selectedLikes"];
        [[PFUser currentUser] saveInBackground];
        
        [selectedDislikes removeObject:[self getPressedWordWithRecognizer:recognizer]];
        [[PFUser currentUser] removeObject:[self getPressedWordWithRecognizer:recognizer] forKey:@"selectedDislikes"];
        [[PFUser currentUser] saveInBackground];

        for (NSString *word in words) {
            if ([word containsString:[self getPressedWordWithRecognizer:recognizer]]) {
                NSRange range=[_textView.text rangeOfString:word];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range];
                [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:30.0f] range:range];
            }
            
        }
        
        [_textView setAttributedText:string];


    }
    
    
    //NSLog(@"LIKED %@", selectedLikes);
    //NSLog(@"DISLIKED %@", selectedDislikes);

}





-(void)handleDoubleTap:(UITapGestureRecognizer*)recognizer
{
    
    if ([[self getPressedWordWithRecognizer:recognizer] isEqualToString:@""]){
        NSLog(@"you clicked on nothing this will be ignored");
    }
    
    
    
    if ([selectedDislikes containsObject:[self getPressedWordWithRecognizer:recognizer]]){
        
        [selectedDislikes removeObject:[self getPressedWordWithRecognizer:recognizer]];
        [[PFUser currentUser] removeObject:[self getPressedWordWithRecognizer:recognizer] forKey:@"selectedDislikes"];
        [[PFUser currentUser] saveInBackground];
        
        for (NSString *word in words) {
            if ([word containsString:[self getPressedWordWithRecognizer:recognizer]]) {
                NSRange range=[_textView.text rangeOfString:word];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
                [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:12.0f] range:range];
                
            }
            
        }
        [_textView setAttributedText:string];

        
    }
    else{
        
        [selectedDislikes addObject:[self getPressedWordWithRecognizer:recognizer]];
        [[PFUser currentUser] addUniqueObject:[self getPressedWordWithRecognizer:recognizer] forKey:@"selectedDislikes"];
        [[PFUser currentUser] saveInBackground];
        
        [selectedLikes removeObject:[self getPressedWordWithRecognizer:recognizer]];
        [[PFUser currentUser] removeObject:[self getPressedWordWithRecognizer:recognizer] forKey:@"selectedLikes"];
        [[PFUser currentUser] saveInBackground];
        
        for (NSString *word in words) {
            if ([word containsString:[self getPressedWordWithRecognizer:recognizer]]) {
                NSRange range=[_textView.text rangeOfString:word];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:30.0f] range:range];
            }
            
        }
        
        [_textView setAttributedText:string];

        
    }
    
    //NSLog(@"LIKE %@", selectedLikes);
    //NSLog(@"DISLIKE %@", selectedDislikes);
    

}


@end
