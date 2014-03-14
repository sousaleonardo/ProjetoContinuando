//
//  Twitter.h
//  ProjetoContinuando
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/03/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface Twitter : NSObject

@property NSURLConnection *twitterConnection;

-(void)mandarTweet : (UITextField*)textField;
-(void)favoritarTweet:(NSNumber*)idTweet;
-(void)procurarTweet:(NSString *)aKeyword;
-(void)retweetar:(NSNumber*)idTweet;

@end
