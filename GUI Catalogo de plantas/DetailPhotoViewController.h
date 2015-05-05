//
//  DetailPhotoViewController.h
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 5/3/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPhotoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *PlantListTableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property UIImage *photoTaken;
@end
