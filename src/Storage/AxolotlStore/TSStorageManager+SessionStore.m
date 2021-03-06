//
//  Copyright (c) 2017 Open Whisper Systems. All rights reserved.
//

#import "TSStorageManager+SessionStore.h"

#define TSStorageManagerSessionStoreCollection @"TSStorageManagerSessionStoreCollection"

@implementation TSStorageManager (SessionStore)


#pragma mark - SessionStore

- (SessionRecord *)loadSession:(NSString *)contactIdentifier deviceId:(int)deviceId {
    NSDictionary *dictionary =
        [self dictionaryForKey:contactIdentifier inCollection:TSStorageManagerSessionStoreCollection];

    SessionRecord *record;

    if (dictionary) {
        record = [dictionary objectForKey:[self keyForInt:deviceId]];
    }

    if (!record) {
        return [SessionRecord new];
    }

    return record;
}

- (NSArray *)subDevicesSessions:(NSString *)contactIdentifier {
    NSDictionary *dictionary =
        [self objectForKey:contactIdentifier inCollection:TSStorageManagerSessionStoreCollection];

    NSMutableArray *subDevicesSessions = [NSMutableArray array];

    if (dictionary) {
        for (NSString *key in [dictionary allKeys]) {
            NSNumber *number = @([key doubleValue]);

            [subDevicesSessions addObject:number];
        }
    }

    return subDevicesSessions;
}

- (void)storeSession:(NSString *)contactIdentifier deviceId:(int)deviceId session:(SessionRecord *)session {
    // We need to ensure subsequent usage of this SessionRecord does not consider this session as "fresh". Normally this
    // is achieved by marking things as "not fresh" at the point of deserialization - when we fetch a SessionRecord from
    // YapDB (initWithCoder:). However, because YapDB has an object cache, rather than fetching/deserializing, it's
    // possible we'd get back *this* exact instance of the object (which, at this point, is still potentially "fresh"),
    // thus we explicitly mark this instance as "unfresh", any time we save.
    [session markAsUnFresh];

    NSMutableDictionary *dictionary =
        [[self dictionaryForKey:contactIdentifier inCollection:TSStorageManagerSessionStoreCollection] mutableCopy];

    if (!dictionary) {
        dictionary = [NSMutableDictionary dictionary];
    }

    [dictionary setObject:session forKey:[self keyForInt:deviceId]];

    [self setObject:dictionary forKey:contactIdentifier inCollection:TSStorageManagerSessionStoreCollection];
}

- (BOOL)containsSession:(NSString *)contactIdentifier deviceId:(int)deviceId {
    return [self loadSession:contactIdentifier deviceId:deviceId].sessionState.hasSenderChain;
}

- (void)deleteSessionForContact:(NSString *)contactIdentifier deviceId:(int)deviceId {
    NSMutableDictionary *dictionary =
        [[self dictionaryForKey:contactIdentifier inCollection:TSStorageManagerSessionStoreCollection] mutableCopy];

    if (!dictionary) {
        dictionary = [NSMutableDictionary dictionary];
    }

    [dictionary removeObjectForKey:[self keyForInt:deviceId]];

    [self setObject:dictionary forKey:contactIdentifier inCollection:TSStorageManagerSessionStoreCollection];
}

- (void)deleteAllSessionsForContact:(NSString *)contactIdentifier {
    [self removeObjectForKey:contactIdentifier inCollection:TSStorageManagerSessionStoreCollection];
}

#pragma mark - util

- (NSNumber *)keyForInt:(int)number {
    return [NSNumber numberWithInt:number];
}

#pragma mark - debug

- (void)printAllSessions
{
    NSString *tag = @"[TSStorageManager (SessionStore)]";
    [self.dbConnection readWithBlock:^(YapDatabaseReadTransaction *_Nonnull transaction) {
        DDLogDebug(@"%@ All Sessions:", tag);
        [transaction
            enumerateKeysAndObjectsInCollection:TSStorageManagerSessionStoreCollection
                                     usingBlock:^(NSString *_Nonnull key,
                                         id _Nonnull deviceSessionsObject,
                                         BOOL *_Nonnull stop) {
                                         if (![deviceSessionsObject isKindOfClass:[NSDictionary class]]) {
                                             OWSAssert(NO);
                                             DDLogError(
                                                 @"%@ Unexpected type: %@ in collection.", tag, deviceSessionsObject);
                                             return;
                                         }
                                         NSDictionary *deviceSessions = (NSDictionary *)deviceSessionsObject;

                                         DDLogDebug(@"%@     Sessions for recipient: %@", tag, key);
                                         [deviceSessions enumerateKeysAndObjectsUsingBlock:^(
                                             id _Nonnull key, id _Nonnull sessionRecordObject, BOOL *_Nonnull stop) {
                                             if (![sessionRecordObject isKindOfClass:[SessionRecord class]]) {
                                                 OWSAssert(NO);
                                                 DDLogError(@"%@ Unexpected type: %@ in collection.",
                                                     tag,
                                                     sessionRecordObject);
                                                 return;
                                             }
                                             SessionRecord *sessionRecord = (SessionRecord *)sessionRecordObject;
                                             SessionState *activeState = [sessionRecord sessionState];
                                             NSArray<SessionState *> *previousStates =
                                                 [sessionRecord previousSessionStates];
                                             DDLogDebug(@"%@         Device: %@ SessionRecord: %@ activeSessionState: "
                                                        @"%@ previousSessionStates: %@",
                                                 tag,
                                                 key,
                                                 sessionRecord,
                                                 activeState,
                                                 previousStates);
                                         }];
                                     }];
    }];
}

@end
