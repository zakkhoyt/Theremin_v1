//
//  VWWFileSystem.m
//  Theremin
//
//  Created by Zakk Hoyt on 12/30/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWFileSystem.h"

static NSString* kConfigFileName = @"theremin.cfg";
@implementation VWWFileSystem

+(bool)configFileExists{
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDirectory stringByAppendingPathComponent:kConfigFileName];
    NSFileManager *fileManager = [[NSFileManager defaultManager]autorelease];
    return [fileManager fileExistsAtPath:path];
}

+(NSString*)readFile{
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDirectory stringByAppendingPathComponent:kConfigFileName];

    if([VWWFileSystem configFileExists] == NO){
        return nil;
    }
    
    NSError* error = nil;
    NSString* contents = [[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error]autorelease];
    return contents;

}

+(bool)writeFile:(NSString*)contents{
    NSData* data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docsDirectory stringByAppendingPathComponent:kConfigFileName];
    [data writeToFile:path atomically:YES];
    return [VWWFileSystem configFileExists];
}

@end
