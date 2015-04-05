//
//  GendersViewController.h
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 3/31/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Family.h"

@interface GendersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *familyNameLabel;
@property Family *familySelected;
@end
