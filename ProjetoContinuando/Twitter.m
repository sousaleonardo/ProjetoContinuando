//
//  Twitter.m
//  ProjetoContinuando
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/03/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import "Twitter.h"

@implementation Twitter

-(void)mandarTweet : (UITextField*)textField{
    ACAccountStore *conta = [[ACAccountStore alloc]init];
    
    ACAccountType *tipoDeConta = [conta accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [conta requestAccessToAccountsWithType:tipoDeConta options:nil completion:^(BOOL granted, NSError *error){
        if (granted == YES) {
            
            NSArray *contasConfiguradas = [conta accountsWithAccountType:tipoDeConta];
            
            if ([contasConfiguradas count] > 0) {
                ACAccount *contaDoTwitter = [contasConfiguradas lastObject];
                
                
                
                NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/pdateu.json"];
                
                SLRequest * mensagem = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:[NSDictionary dictionaryWithObject:textField.text forKey:@"status"]];
                
                [mensagem setAccount:contaDoTwitter];
                
                [mensagem performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                 {
                     //show status after done
                     NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
                     NSLog(@"Twiter post status : %@", output);
                 }];
            }
        }
        else{
            // Handle failure to get account access
            NSLog(@"%@", [error localizedDescription]);
            
        }
    }];
}

-(void)favoritarTweet:(NSNumber*)idTweet{
    ACAccountStore *conta=[[ACAccountStore alloc]init];
    ACAccountType *tipoConta=[conta accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [conta requestAccessToAccountsWithType:tipoConta options:nil completion:^(BOOL granted,NSError *error){
        if (granted==YES) {
            NSArray *contasConfiguradas=[conta accountsWithAccountType:tipoConta];
            
            
            if ([contasConfiguradas count]>0) {
                //Pega a ultima conta configurada para usar
                ACAccount *contaUsar=[contasConfiguradas lastObject];
                
                //Url do serviço solicitado
                NSURL *url=[NSURL URLWithString:[ NSString stringWithFormat:@"https://api.twitter.com/1/favorites/create/%@.json",idTweet]];
                
                SLRequest *favoritar=[SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:nil];
                
                [favoritar setAccount:contaUsar];
                [favoritar performRequestWithHandler:^(NSData *responseData,NSHTTPURLResponse *urlReponse,NSError *error)
                {
                    //Mostra o status
                    NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlReponse statusCode]];
                    NSLog(@"Twiter post status : %@", output);
                    
                }];
            }
        }
        else{
            //Erro
            NSLog(@"%@",[error localizedDescription]);
    }
    
    }];
}
/*
-(void)infoUser:(NSString*)userName{
    ACAccountStore *contaStore=[[ACAccountStore alloc]init];
    ACAccountType *tipoConta=[contaStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [contaStore requestAccessToAccountsWithType:tipoConta options:Nil completion:^(BOOL granted, NSError *error) {
        if (granted==YES) {
            NSArray *contasConfig=[contaStore accountTypeWithAccountTypeIdentifier:tipoConta];
            
            if ([contasConfig count]>0) {
                ACAccount *contaUsar=[contasConfig lastObject];
                
                //URL do serviço
                NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/1.1/users/lookup.json?screen_name=twitterapi,twitter"]];
                
                SLRequest *infoUser=[SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:<#(NSDictionary *)#>]
            }
        }
    }]
    
}*/

-(void)procurarTweet:(NSString *)aKeyword{
    //Primeiro pega as contas do twitter
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    //requisita permissão para acessar o serviço usando uma conta twitter
    [store requestAccessToAccountsWithType:twitterAccountType
                                   options:nil
                                completion:^(BOOL granted, NSError *error) {
                                    if (!granted) {
                                        // The user rejected your request
                                        NSLog(@"User rejected access to the account.");
                                    }
                                    else {
                                        // Grab the available accounts
                                        NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
                                        if ([twitterAccounts count] > 0) {
                                            ACAccount *account = [twitterAccounts lastObject];
                                            
                                            NSURL *url = [NSURL URLWithString:@"https://stream.twitter.com/1.1/statuses/filter.json"];
                                            
                                            NSDictionary *params = @{@"track" : aKeyword};
                                            
                                            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                                    requestMethod:SLRequestMethodPOST
                                                                                              URL:url
                                                                                       parameters:params];
                                            
                                            [request setAccount:account];
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                NSURLConnection *aConn = [NSURLConnection connectionWithRequest:[request preparedURLRequest] delegate:self];
                                                [aConn start];
                                            });
                                        }
                                    }
                                }];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"dataString: %@", [data description]);
    NSJSONSerialization *serializado=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

-(void)retweetar:(NSNumber*)idTweet{
    ACAccountStore *contaStore=[[ACAccountStore alloc]init];
    ACAccountType *tipoConta=[contaStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [contaStore requestAccessToAccountsWithType:tipoConta options:Nil completion:^(BOOL granted, NSError *error) {
        
        if (granted==YES) {
            
            NSArray *contasCofiguradas=[contaStore accountsWithAccountType:tipoConta];
            
            if ([contasCofiguradas count]>0) {
                ACAccount *contaUsar=[contasCofiguradas lastObject];
                
                NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json",idTweet]];
                
                SLRequest *retweetar=[SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:Nil];
                
                [retweetar setAccount:contaUsar];
                [retweetar performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    NSLog(@"Post Status: %i",[urlResponse statusCode]);
                    NSLog(@"%@",[NSHTTPURLResponse localizedStringForStatusCode:[urlResponse statusCode] ]);
                }];
            }
            else{
                NSLog(@"%@",[error localizedDescription]);
            }
        }
    }];
}

     
     
@end