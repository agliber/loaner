//
//  SBDUserMessage.h
//  SendBirdSDK
//
//  Created by Jed Gyeong on 5/23/16.
//  Copyright © 2016 SENDBIRD.COM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBDBaseMessage.h"
#import "SBDBaseChannel.h"

@class SBDCommand;
@class SBDBaseChannel;

/**
 *  The `SBDUserMessage` class represents the user <span>message</span> which is generated by a user via [`sendUserMessage:completionHandler:`](../Classes/SBDBaseChannel.html#//api/name/sendUserMessage:completionHandler:) or [`sendUserMessage:data:completionHandler:`](../Classes/SBDBaseChannel.html#//api/name/sendUserMessage:data:completionHandler:) in `SBDBaseChannel` or [Platform API](https://docs.sendbird.com/platform#messages_3_send).
 */
@interface SBDUserMessage : SBDBaseMessage

/**
 *  <span>Message</span> text.
 */
@property (strong, nonatomic, readonly, nullable) NSString *message;

/**
 *  Data of <span>message</span>.
 */
@property (strong, nonatomic, readonly, nullable) NSString *data;

/**
 *  Sender of the <span>message</span>. This is represented by `SBDUser` class.
 */
@property (strong, nonatomic, nullable, getter = sender) SBDUser *sender;

/**
 *  Request ID for checking ACK.
 */
@property (strong, nonatomic, readonly, nullable) NSString *requestId;

/**
 *  Custom message type.
 */
@property (strong, nonatomic, readonly, nullable) NSString *customType;

/**
 *  Translated <span>message</span> text.
 */
@property (strong, nonatomic, readonly, nullable) NSDictionary *translations;

- (nullable instancetype)initWithDictionary:(NSDictionary * _Nonnull)dict;

/**
 Serializes message object.
 
 @return Serialized <span>data</span>.
 */
- (nullable NSData *)serialize;

/**
 Returns sender.
 
 @return Sender of the message.
 */
- (nonnull SBDUser *)sender;

/**
 *  Internal use only.
 *
 *  @see -serialize
 *  @warning *Important*: DON'T use this method. This method will be unavailable.
 */
- (nullable NSDictionary *)_toDictionary;

@end