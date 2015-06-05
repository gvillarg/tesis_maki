//
//  AboutUsViewController.m
//  GUI Catalogo de plantas
//
//  Created by Maria del Carmen Aguilar Velez on 5/17/15.
//  Copyright (c) 2015 Gustavo Villar. All rights reserved.
//

#import "AboutUsViewController.h"
#import <MessageUI/MessageUI.h>

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"backgroundAboutUs2"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UINavigationController *navController = self.navigationController;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)apretoPaginaWeb:(id)sender {
    NSString *miUrlString;
    miUrlString = @"http://inform.pucp.edu.pe/~grpiaa/?p=234";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:miUrlString]];
}

- (IBAction)apretoFacebook:(id)sender {
    NSString *miUrlString;
    miUrlString = @"fb://profile/190332614427";
    if(![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:miUrlString]]){
        miUrlString = @"https://www.facebook.com/grpiaa";
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:miUrlString]];
}

- (IBAction)apretoTwitter:(id)sender {
    NSString *miUrlString;
    miUrlString = @"https://www.twitter.com/GRPIAAPUCP";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:miUrlString]];
}

- (IBAction)apretoCorreo:(UIButton *)sender {
    MFMailComposeViewController *miComposer = [[MFMailComposeViewController alloc] init];
    
    if (miComposer != nil) {
        miComposer.mailComposeDelegate = self;
        
        //Aqui le metemos el destinatario y el cuerpo
        [miComposer setSubject:@"Mensaje al grupo GRPIAA"];
        [miComposer setMessageBody:@"Escribe aqui tu sugerencia - Prueba 1" isHTML:NO];
        [miComposer setToRecipients:@[@"makikommt@gmail.com"]];
        //
        
        miComposer.popoverPresentationController.sourceRect = sender.bounds;
        miComposer.popoverPresentationController.sourceView = sender;
        
        [self presentViewController:miComposer animated:YES completion:nil];
    } else {
        NSLog(@"No se encontró un correo electronico");
    }
    
}
- (IBAction)apretoCompartir:(UIButton *)sender {
//    NSURL *url = [NSURL URLWithString:@"fb://page/190332614427"];
    NSString *text = @"Me gusta mucho esta aplicacion!";
    NSArray *items = @[text];
    UIActivityViewController *miActivity = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    miActivity.excludedActivityTypes = @[UIActivityTypeMail];
    
    miActivity.popoverPresentationController.sourceRect = sender.bounds;
    miActivity.popoverPresentationController.sourceView = sender;
    
    [self presentViewController:miActivity animated:YES completion:nil];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
