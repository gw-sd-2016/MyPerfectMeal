//
//  MealIngredientsViewController.m
//  iOS MPM
//
//  Created by guest on 4/4/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import "MealIngredientsViewController.h"

@interface MealIngredientsViewController ()

@end

@implementation MealIngredientsViewController

@synthesize InstructionsLBL, mealNameLBL, submitPreferencesBTN;

- (void)viewDidLoad {
    [super viewDidLoad];

    InstructionsLBL.text = @"Tap once on ingredients to Like. Tap twice on ingredients to Dislike.";
    mealNameLBL.text = _clickedMealName;
    _textView.text = _clickedMealIngredeients;
    string = [[NSMutableAttributedString alloc]initWithString:_textView.text];
    words = [_textView.text componentsSeparatedByString:@" "];
    ThingsLiked = [[NSMutableArray alloc] init];
    ThingsDisliked = [[NSMutableArray alloc] init];
    
    

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
    
    NSLog(@"Single Tap On: %@", [self getPressedWordWithRecognizer:recognizer]);
    
    
    if ([ThingsDisliked containsObject:[self getPressedWordWithRecognizer:recognizer]]){
        [ThingsDisliked removeObject:[self getPressedWordWithRecognizer:recognizer]];
    }
    
    
    
    
    if ([ThingsLiked containsObject:[self getPressedWordWithRecognizer:recognizer]]){
        // NSLog(@"This item is already in the list of things likes, so lets deselect it");
        
        [ThingsLiked removeObject:[self getPressedWordWithRecognizer:recognizer]];
        
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
        [ThingsLiked addObject:[self getPressedWordWithRecognizer:recognizer]];
        
        for (NSString *word in words) {
            if ([word containsString:[self getPressedWordWithRecognizer:recognizer]]) {
                NSRange range=[_textView.text rangeOfString:word];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range];
                [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:30.0f] range:range];
            }
            
        }
        
        [_textView setAttributedText:string];
    }
    
    
    NSLog(@"All things Likes are: %@", ThingsLiked);
    NSLog(@"All things disliked are: %@", ThingsDisliked);
    
}

-(void)handleDoubleTap:(UITapGestureRecognizer*)recognizer
{
    
    NSLog(@"Double Tap On: %@", [self getPressedWordWithRecognizer:recognizer]);
    
    
    if ([ThingsLiked containsObject:[self getPressedWordWithRecognizer:recognizer]]){
        [ThingsLiked removeObject:[self getPressedWordWithRecognizer:recognizer]];
    }
    
    
    
    if ([ThingsDisliked containsObject:[self getPressedWordWithRecognizer:recognizer]]){
        
        [ThingsDisliked removeObject:[self getPressedWordWithRecognizer:recognizer]];
        
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
        
        [ThingsDisliked addObject:[self getPressedWordWithRecognizer:recognizer]];
        
        for (NSString *word in words) {
            if ([word containsString:[self getPressedWordWithRecognizer:recognizer]]) {
                NSRange range=[_textView.text rangeOfString:word];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:30.0f] range:range];
            }
            
        }
        
        [_textView setAttributedText:string];
        
        
    }
    
    NSLog(@"All things Likes are: %@", ThingsLiked);
    NSLog(@"All things disliked are: %@", ThingsDisliked);
    
    
}




@end
