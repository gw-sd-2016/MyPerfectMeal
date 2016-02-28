//
//  main.m
//  RestaurantExtractor
//
//  Created by guest on 2/25/16.
//  Copyright © 2016 AKSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    /*
    NSMutableString *restaurantDirectoryURLString= [NSMutableString stringWithFormat:@"http://m.allmenus.com/va/annandale/345297-thai-food/menu/"];
    NSURL *restaurantDirectoryURL = [[NSURL alloc] initWithString:restaurantDirectoryURLString];
    NSString *loadPageHTML = [[NSString alloc] initWithContentsOfURL:restaurantDirectoryURL];
    NSMutableArray *getCategoriesArray = [[NSMutableArray alloc] init];
    
    NSScanner *Scanner;
    NSString *text = @"";
    Scanner = [NSScanner scannerWithString:loadPageHTML];
    
    while ([Scanner isAtEnd] == NO) {
        
        [Scanner scanUpToString:@"<div id=\"menu\" style=\"clear:both;\"><div class=\"category\"><div class=\"category_head\">" intoString:NULL] ;
        [Scanner scanUpToString:@"<!-- alternative menus -->" intoString:&text] ;
     
        
    }
   //NSLog(@"%@", text);

    
    ////////////////////////////////////GET CATEGORIES////////////////////////////////////////////
    
    NSString *loadPageHTML2 = text;
    NSScanner *theSecondScanner;
    NSString *getCategories = nil;
    theSecondScanner = [NSScanner scannerWithString:loadPageHTML2];
    
    while ([theSecondScanner isAtEnd] == NO) {
        
        
        [theSecondScanner scanUpToString:@"<h3>" intoString:NULL] ;
        
        [theSecondScanner scanUpToString:@"</h3>" intoString:&getCategories] ;
        
        getCategories = [getCategories stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<h3>"] withString:@""];
        
        [getCategoriesArray addObject:getCategories];
        
        
        
    }
    
    //NSLog(@"%@", getCategoriesArray);
    
    ////////////////////////////////////GET CATEGORIES////////////////////////////////////////////


    
    
    
    ////////////////////////////////////GET MEALS////////////////////////////////////////////

    
    NSString *loadPageHTML3 = text;
    NSScanner *theThirdScanner;
    NSString *getMeals = nil;
    theThirdScanner = [NSScanner scannerWithString:loadPageHTML3];
    
    while ([theThirdScanner isAtEnd] == NO) {
        
        
        [theThirdScanner scanUpToString:@"<dt>" intoString:NULL] ;
        
        [theThirdScanner scanUpToString:@"<p>" intoString:&getMeals] ;
        
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<dt>"] withString:@""];
        
         //NSLog(@"%@", getMeals);
        
        
    }
         
    ////////////////////////////////////GET MEALS////////////////////////////////////////////

    
    ////////////////////////////////////GET PRICING////////////////////////////////////////////

    
    NSString *loadPageHTML4 = text;
    NSScanner *theFourthScanner;
    NSString *getPrices = nil;
    theFourthScanner = [NSScanner scannerWithString:loadPageHTML4];
    
    while ([theFourthScanner isAtEnd] == NO) {
        
        
        [theFourthScanner scanUpToString:@"<p>" intoString:NULL] ;
        
        [theFourthScanner scanUpToString:@"</p>" intoString:&getPrices] ;
        
       getPrices = [getPrices stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p>"] withString:@""];
        //getPrices = [getPrices stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" "] withString:@""];

        
       // NSLog(@"%@", getPrices);
        
        
    }

    
   
    ////////////////////////////////////GET PRICING////////////////////////////////////////////
    
    ////////////////////////////////////GET INGREDIENTS////////////////////////////////////////////

    
    NSString *loadPageHTML5 = text;
    NSScanner *theFifthScanner;
    NSString *getIngredients = nil;
    theFifthScanner = [NSScanner scannerWithString:loadPageHTML5];
    
    while ([theFifthScanner isAtEnd] == NO) {
        
        
        [theFifthScanner scanUpToString:@"<dd>" intoString:NULL] ;
        
        [theFifthScanner scanUpToString:@"</dd>" intoString:&getIngredients] ;
        
        getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<dd>"] withString:@""];
        //getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" "] withString:@""];
        
        
        NSLog(@"%@", getIngredients);
        
        
    }
    ////////////////////////////////////GET INGREDIENTS////////////////////////////////////////////
*/

   
    return 0;
}
