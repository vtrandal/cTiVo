//
//  MTDownloadList.h
//  myTivo
//
//  Created by Scott Buchanan on 12/8/12.
//  Copyright (c) 2012 Scott Buchanan. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MTNetworkTivos.h"
#import "MTDownloadListCellView.h"
#import "MTProgressindicator.h"

@interface MTDownloadList : NSTableView <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, assign) NSMutableArray *downloadQueue;

@end