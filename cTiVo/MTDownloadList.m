//
//  MTDownloadList.m
//  myTivo
//
//  Created by Scott Buchanan on 12/8/12.
//  Copyright (c) 2012 Scott Buchanan. All rights reserved.
//

#import "MTDownloadList.h"

@implementation MTDownloadList

-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:kMTNotificationDownloadQueueUpdated object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgress) name:kMTNotificationProgressUpdated object:nil];
    self.dataSource = self;
    self.delegate    = self;
//    self.rowHeight = 24;
    self.allowsMultipleSelection = YES;
}

-(void)updateTable
{
    [super reloadData];
    //Check download Status
    
    
}

-(void)updateProgress
{
	for (int i=0; i< _downloadQueue.count; i++) {
		MTDownloadListCellView *thisCell = [self viewAtColumn:0 row:i makeIfNecessary:NO];
		if (thisCell) {
			MTTiVoShow *thisShow = [_downloadQueue objectAtIndex:i];
			thisCell.progressIndicator.doubleValue = thisShow.processProgress;
			thisCell.progressIndicator.rightText.stringValue = thisShow.showStatus;
			[thisCell setNeedsDisplay:YES];
		}
	}
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark - Table Delegate Protocol


#pragma mark - Table Data Source Protocol

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return _downloadQueue.count;
}

-(id)makeViewWithIdentifier:(NSString *)identifier owner:(id)owner
{
    id result;
    if([identifier compare: @"Program"] == NSOrderedSame) {
        NSTableColumn *thisColumn = [self tableColumnWithIdentifier:identifier];
        MTDownloadListCellView *thisCell = [[[MTDownloadListCellView alloc] initWithFrame:CGRectMake(0, 0, thisColumn.width, 20)] autorelease];
        //        result.textField.font = [NSFont userFontOfSize:14];
        thisCell.textField.editable = NO;
        
        // the identifier of the NSTextField instance is set to MyView. This
        // allows it to be re-used
        thisCell.identifier = identifier;
        result = (id)thisCell;
    } else {
        result =[super makeViewWithIdentifier:identifier owner:owner];       
    }
    return result;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    MTTiVoShow *rowData = [_downloadQueue objectAtIndex:row];
//	NSDictionary *idMapping = [NSDictionary dictionaryWithObjectsAndKeys:@"Title",@"Program",kMTSelectedTiVo,@"TiVo",kMTSelectedFormat,@"Format", nil];
	
    // get an existing cell with the MyView identifier if it exists
	
    MTDownloadListCellView *result = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    // There is no existing cell to reuse so we will create a new one
    if (result == nil) {
        
        // create the new NSTextField with a frame of the {0,0} with the width of the table
        // note that the height of the frame is not really relevant, the row-height will modify the height
        // the new text field is then returned as an autoreleased object
        result = [[[MTDownloadListCellView alloc] initWithFrame:CGRectMake(0, 0, tableColumn.width, 20)] autorelease];
//        result.textField.font = [NSFont userFontOfSize:14];
        result.textField.editable = NO;
        
        // the identifier of the NSTextField instance is set to MyView. This
        // allows it to be re-used
        result.identifier = tableColumn.identifier;
    }
    
    // result is now guaranteed to be valid, either as a re-used cell
    // or as a new cell, so set the stringValue of the cell to the
    // nameArray value at row
//	NSString *dataKey = [idMapping objectForKey:tableColumn.identifier];
//	id columnItem = [rowData objectForKey:dataKey];
//	NSString *content = @"";
	if ([tableColumn.identifier compare:@"Program"] == NSOrderedSame) {
		result.progressIndicator.rightText.stringValue = rowData.showStatus;
        result.progressIndicator.leftText.stringValue = rowData.title ;
        result.progressIndicator.doubleValue = rowData.processProgress;
	} else if ([tableColumn.identifier compare:@"TiVo"] == NSOrderedSame) {
//		content	= [columnItem name];
        result.textField.stringValue = rowData.tiVo.name ;
	} else { //This is the format column
//		content	= [columnItem objectForKey:@"name"];
        result.textField.stringValue = [rowData.encodeFormat objectForKey:@"name"] ;
	}
    
    // return the result.
    return result;
    
}

@end