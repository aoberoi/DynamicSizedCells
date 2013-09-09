//
//  DetailViewController.h
//  DynamicSizedCells
//
//  Created by Ankur Oberoi on 9/9/13.
//  Copyright (c) 2013 Ankur Oberoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
