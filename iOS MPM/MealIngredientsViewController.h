//
//  MealIngredientsViewController.h
//  iOS MPM
//
//  Created by guest on 4/4/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealIngredientsViewController : UIViewController <UITextViewDelegate>{
    
    NSMutableAttributedString * string;

    
    NSArray *words;
    NSMutableArray *selectedLikes;
    NSMutableArray *selectedDislikes;
    
    NSMutableArray *everythingInLikes;
    NSMutableArray *everythingInDislikes;
    
}




@property (weak, nonatomic) IBOutlet UILabel *InstructionsLBL;
@property (weak, nonatomic) IBOutlet UILabel *mealNameLBL;

- (IBAction)submitPreferencesBTN:(id)sender;

@property (nonatomic, strong) NSString *clickedMealName;
@property (nonatomic, strong) NSString *clickedMealIngredeients;


@property (weak, nonatomic) IBOutlet UITextView *textView;





@end
