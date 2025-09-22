//
//  MachODropView.h
//  EntDump
//
//  Created by Dora Orak on 13.09.2025.
//


#import <Cocoa/Cocoa.h>

@interface MachODropView : NSView <NSDraggingDestination>

@property BOOL isApp;

-(BOOL)isAppOrMachOFile;

-(void) handleDroppedFile:(NSString *)filePath;

@end

NSArray<NSString *>* GetEntitlements(NSString *machOPath);

