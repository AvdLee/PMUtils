// Copyright (c) 2013-2014 Peter Meyers
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//  PMSwipeCellDelegate.h
//  Pods
//
//  Created by Peter Meyers on 11/28/14.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PMCellPosition)
{
    PMCellPositionCentered,
    PMCellPositionLeftUtilityViewVisible,
    PMCellPositionRightUtilityViewVisible
};

@protocol PMSwipeCellDelegate <NSObject>

@optional

/**
 *  Tells the delegate a swipe cell changed the position of its content view.
 *
 *  @param cell     The swipe cell whose content view moved to a new position.
 *  @param position The new position of the content view.
 */
- (void) swipeCell:(id)cell didMoveToPosition:(PMCellPosition)position;

@end

