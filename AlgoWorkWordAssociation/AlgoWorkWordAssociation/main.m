//
//  main.m
//  AlgoWorkWordAssociation
//
//  Created by Abed Kassem on 1/24/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        
        
        NSArray *allPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [allPaths objectAtIndex:0];
        NSString *pathForLog = [documentsDirectory stringByAppendingPathComponent:@"wordAssociation.txt"];
        
        freopen([pathForLog cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
        
        
        
        NSArray *wordsSelected = @[@"alcohol",@"pain",@"drinking",@"pressure",@"infection",@"heart",@"brain",@"muscle",@"arthritis",@"cholesterol",@"fever",@"depression",@"infections",@"diarrhea",@"diabetes",@"cancer",@"skin",@"anxiety",@"inflammatory",@"inflammation",@"hypertension",@"stroke",@"dizziness",@"headache",@"dizzy",@"bleeding",@"antidepressant",@"sugar",@"swelling",@"hiv",@"seizures",@"antibiotic",@"drowsiness",@"dehydrated",@"bacteria",@"lung",@"arteries",@"pregnancy",@"nervous",@"herpes",@"pregnant",@"depressive",@"nasal",@"allergic",@"panic",@"asthma",@"itching",@"virus",@"chronic",@"nausea",@"measles",@"ache",@"shingles",@"prostate",@"indomethacin",@"menstrual",@"aids",@"hives"];
        
        
        
        
        
        //NSLog(@"%@", wordsSelected);
        
        for(int j = 0; j < wordsSelected.count; j++){
            NSMutableString *wordsWebsites = [NSMutableString stringWithFormat:@"http://wordassociations.net/search?hl=en&q=%@&button=Search", wordsSelected[j]];
           // NSLog(@"%@", wordsSelected[j]);
            NSURL *wordWebsite = [[NSURL alloc] initWithString:wordsWebsites];
            NSString *webContents = [[NSString alloc] initWithContentsOfURL:wordWebsite];
        
        
        
        NSScanner *Scanner;
        NSString *text = @"";
        Scanner = [NSScanner scannerWithString:webContents];
        
        while ([Scanner isAtEnd] == NO) {
            
            [Scanner scanUpToString:@"class=\"wordscolumn\""intoString:NULL] ;
            
            [Scanner scanUpToString:@"All Rights Reserved.divdiv" intoString:&text];
            
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"love"] withString:@""];
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"dream"] withString:@""];
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"bee"] withString:@""];
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"flower"] withString:@""];
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"grass"] withString:@""];
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"paint"] withString:@""];
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"thunder"] withString:@""];
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"gift"] withString:@""];
            webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"motorcycle"] withString:@""];



            
            
    
        }
            
           // NSLog(@"%@", webContents);
            

            
            NSMutableArray *collectedTerms = [[NSMutableArray alloc] init];
            NSString *htmlWebsite = webContents;
            NSScanner* newScanner = [NSScanner scannerWithString:htmlWebsite];
            NSString *newText;
            while (![newScanner isAtEnd]) {
                [newScanner scanUpToString:@"href=\"/search?hl=en&amp;w=" intoString:NULL];
                //[newScanner scanString:@"<body>" intoString:NULL];
                [newScanner scanUpToString:@"\">" intoString:&newText];
                newText = [newText stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"href=\"/search?hl=en&amp;w="] withString:@""];
                newText = [newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

                
                [collectedTerms addObject:newText];
                [collectedTerms removeObject:@""];
                
                
            }
            
            /*
            if ([collectedTerms count] == 0 ){
                NSLog(@"There is no page for: %@", wordsSelected[j]);
            }
             */
            
            //NSLog(@"%@", collectedTerms);
            //NSLog(@"%@", wordsSelected[j]);
            
            
            
            if ([collectedTerms containsObject:wordsSelected]){
                
                NSLog(@"found a relationship");
                
            }
            
            
            
        }
        
        
    
        
        
    }
    
    
    
    
    return 0;
}



