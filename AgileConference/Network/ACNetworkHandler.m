//
//  ACNetworkHandler.m
//  AgileConference
//
//  Created by Deepak Shukla on 28/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import "ACNetworkHandler.h"
#import "JSON.h"

@implementation ACNetworkHandler
@synthesize downloadDelegate;

-(void)downloadHandler : (NSDictionary *)apiParamrters context:(NSString *)context delegate:(id<ACNetworkHandlerDelegate>)delegate{
    
    if(nil != apiParamrters ){
    
        downloadDelegate = delegate;
    
        SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    
    
        NSArray *objectsArray = [[NSArray alloc]initWithObjects :[apiParamrters valueForKey:@"personName"],
                                                                 [apiParamrters valueForKey:@"subject"],
                                                                 [apiParamrters valueForKey:@"feedBack"],
                                                                 [apiParamrters valueForKey:@"rating"],
                                                                 [apiParamrters valueForKey:@"eventType"],
                                                                 [apiParamrters valueForKey:@"seminarName"],
                                                                 [apiParamrters valueForKey:@"speakerName"],
                                                                 [apiParamrters valueForKey:@"udid"],
                                                                 [apiParamrters valueForKey:@"latitude"],
                                                                 [apiParamrters valueForKey:@"longitude"] ,nil];
        
        
        NSArray *keysArray = [NSArray arrayWithObjects:@"personName",@"subject",@"feedBack", @"rating", @"eventType",@"seminarName",@"speakerName",@"udid",@"latitude",@"longitude",nil];
    
        NSDictionary *dict = [NSDictionary 
                          dictionaryWithObjects: objectsArray
                          forKeys:keysArray];
    
        NSString *jsonString = [jsonWriter stringWithObject:dict];
        NSData *jsonData = [NSData dataWithBytes: [jsonString UTF8String] length: [jsonString length]];
    
        ACLog(@"JSON String : %@", jsonString);
    
        //Signup
        NSURL *url = [NSURL URLWithString:@"http://59.160.128.100:8080/agileeventfeedback/valtech/agileevent/feedback"];
    
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: jsonData];
    
        //NSLog(@"request : %@", request);
        // NSLog(@"request headers : %@", [request allHTTPHeaderFields]);
        // NSLog(@"request body : %@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);

    
       
       
        
        [self downloadRespone:request];
		
    }

    
}

-(void)downloadRespone : (NSMutableURLRequest *)request{
    
    [NSURLConnection connectionWithRequest:request  delegate:self];  
    
	ACLog(@"requestURL %@",[request URL]);
	/*
	NSURLResponse *response = nil;
	NSError *requestError = nil;	
	
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request 
												 returningResponse:&response
															 error:&requestError];
    
    NSString *responseString = [[NSString alloc] initWithData: responseData encoding:NSUTF8StringEncoding];
    [downloadDelegate networkHandler:self downloadDidComplete:[responseString JSONValue]];
     */
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSMutableData *d = [NSMutableData data];
    [d appendData:data];
    
    NSString *a = [[NSString alloc] initWithData:d encoding:NSASCIIStringEncoding];
    
    NSLog(@"Data: %@", [a JSONValue]);
    [downloadDelegate networkHandler:self downloadDidComplete:[a JSONValue]];
}


@end
