//
//  Recorder.h
//  screenShare
//
//  Created by Jack on 6/29/16.
//  Copyright © 2016 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Recorder : NSObject <AVCaptureFileOutputRecordingDelegate> {
@private
    AVCaptureSession *mSession;
    AVCaptureMovieFileOutput *mMovieFileOutput;
    NSTimer *mTimer;
}

-(void)screenRecording:(NSURL *)destPath;
@end
