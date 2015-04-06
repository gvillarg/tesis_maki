//
//  SpeciesViewController.h
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 4/5/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Family.h"
#import "Gender.h"

@interface SpeciesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *familyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderNameLabel;
@property Family *familySelected;
@property Gender *genderSelected;
@end
