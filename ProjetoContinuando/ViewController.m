//
//  ViewController.m
//  ProjetoContinuando
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 10/03/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _contaTwitter = [[Twitter alloc]init];
    [self.tweet setDelegate:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [self.contaTwitter mandarTweet:textField];
    
    for (UIView *view in self.view.subviews) {
        [view resignFirstResponder];
        
    }
    return YES;
}

-(IBAction)botaoFavoritar:(id)sender{
    [self.contaTwitter favoritarTweet:[NSNumber numberWithInt:12351]];
}

-(IBAction)botaoRetweet:(id)sender{
    [self.contaTwitter retweetar:[NSNumber numberWithInt:120]];
}

-(IBAction)botaoTeste:(id)sender{
    [self.contaTwitter procurarTweet:[NSString stringWithFormat:@"#10fatosSobreMim"]];
}

@end
