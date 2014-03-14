//
//  ViewController.h
//  ProjetoContinuando
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 10/03/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Twitter.h"


@interface ViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *tweet;
@property (weak, nonatomic) IBOutlet UIButton *botaoEnviar;
@property (weak, nonatomic) IBOutlet UIButton *botaoFavoritar;
@property (weak, nonatomic) IBOutlet UIButton *botaoRetweet;
@property (weak, nonatomic) IBOutlet UIButton *botaoTeste;

@property Twitter *contaTwitter;

-(IBAction)botaoFavoritar:(id)sender;
-(IBAction)botaoRetweet:(id)sender;
-(IBAction)botaoTeste:(id)sender;
@end
