//
//  NSString+Helpers.h
//  cTiVo
//
//  Created by Scott Buchanan on 6/1/13.
//  Copyright (c) 2013 cTiVo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

-(BOOL)contains:(NSString *)string;

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval;

+ (NSString *)stringFromBytesPerSecond: (double) speed;

- (BOOL) isEquivalentToPath: (NSString *) path;

+(NSString *) stringWithEndOfFile:(NSString *) path;

-(BOOL) hasCaseInsensitivePrefix: (NSString *) prefix;

-(NSString *) removeParenthetical;

@end
