//
//  Recorder.m
//  screenShare
//
//  Created by Jack on 6/29/16.
//  Copyright © 2016 Jack. All rights reserved.
//

#import "Recorder.h"

@implementation Recorder
-(void)screenRecording:(NSURL *)destPath
{
    // Create a capture session
    mSession = [[AVCaptureSession alloc] init];
    
    // Set the session preset as you wish
    mSession.sessionPreset = AVCaptureSessionPresetMedium;
    
    // If you're on a multi-display system and you want to capture a secondary display,
    // you can call CGGetActiveDisplayList() to get the list of all active displays.
    // For this example, we just specify the main display.
    // To capture both a main and secondary display at the same time, use two active
    // capture sessions, one for each display. On Mac OS X, AVCaptureMovieFileOutput
    // only supports writing to a single video track.
    CGDirectDisplayID displayId = kCGDirectMainDisplay;
    
    // Create a ScreenInput with the display and add it to the session
    AVCaptureScreenInput *input = [[AVCaptureScreenInput alloc] initWithDisplayID:displayId] ;
    if (!input) {
        mSession = nil;
        return;
    }
    if ([mSession canAddInput:input])
        [mSession addInput:input];
    
    // Create a MovieFileOutput and add it to the session
    mMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    if ([mSession canAddOutput:mMovieFileOutput])
        [mSession addOutput:mMovieFileOutput];
    
    // Start running the session
    [mSession startRunning];
    
    // Delete any existing movie file first
    if ([[NSFileManager defaultManager] fileExistsAtPath:[destPath path]])
    {
        NSError *err;
        if (![[NSFileManager defaultManager] removeItemAtPath:[destPath path] error:&err])
        {
            NSLog(@"Error deleting existing movie %@",[err localizedDescription]);
        }
    }
    
    // Start recording to the destination movie file
    // The destination path is assumed to end with ".mov", for example, @"/users/master/desktop/capture.mov"
    // Set the recording delegate to self
    [mMovieFileOutput startRecordingToOutputFileURL:destPath recordingDelegate:self];
    
    // Fire a timer in 5 seconds
    mTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(finishRecord:) userInfo:nil repeats:NO] ;
}

-(void)finishRecord:(NSTimer *)timer
{
    // Stop recording to the destination movie file
    [mMovieFileOutput stopRecording];
    
    mTimer = nil;
}

// AVCaptureFileOutputRecordingDelegate methods

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    NSLog(@"Did finish recording to %@ due to error %@", [outputFileURL description], [error description]);
    
    // Stop running the session
    [mSession stopRunning];
    
    mSession = nil;
}
@end
