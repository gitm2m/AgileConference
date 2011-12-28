//
//  CommonUtility.h
//  AgileConference
//
//  Created by Valtech India Systems Pvt Ltd on 27/12/11.
//  Copyright (c) 2011 deepak.shukla@valtech.co.in. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>
#include <CoreFoundation/CoreFoundation.h>



@interface CommonUtility : NSObject{
    
}

//Image
+(UIImage *) getImageWithConentsOfURL:(NSString *)urlString;
+(UIImage *) getImageWithConentsOfFile:(NSString *)filePath;

//Date
+(NSDate*)convertStringToDate:(NSString*)inString format:(NSString *)format;
+(NSString*) convertDateToString:(NSDate *)firstDate format:(NSString *)format;

//Network
+(BOOL)connectedToNetwork;


//plist
+(id)convertToPlistFromXMLString:(NSString *)xmlString;
+(NSDictionary *)convertToDictionaryFromXMLString:(NSString *)xmlString;
+(NSString *)convertToXMLFromPlist:(id)plistObject;

//Document directory && bundle
+(NSString*)getDocumentDirectoryPath;
+(NSString*)getBundlePath;
+(NSDictionary *)getDictionaryOfPlistAtPath:(NSString *)relativePath fileType:(NSString *)fileType isDocumentDirecory:(BOOL)isDD;
+(NSString *)getFilePath:(NSString *)relativePath fileType:(NSString *)fileType isDocumentDirecory:(BOOL)isDD;



//general
+(NSString *)GetUUID;
+(NSFileManager *)getFileManager;//

//
+(void)saveImage:(UIImage *)image atPath:(NSString *)relativePath andFormat:(NSString *)formatType;
+(BOOL)isFileExistAtPath:(NSString*)file;
+(void)createFileAtPath:(NSString *)relativePath;

@end
