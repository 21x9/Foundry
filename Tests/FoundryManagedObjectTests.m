//
//  FoundryManagedObjectTests.m
//  FoundryTests
//
//  Created by John Tumminaro on 4/21/14.
//
//

#import <XCTest/XCTest.h>

@interface FoundryManagedObjectTests : XCTestCase

@end

@implementation FoundryManagedObjectTests

- (void)setUp
{
    [super setUp];
    [MagicalRecord setDefaultModelFromClass:[ManagedPerson class]];
    [MagicalRecord setupCoreDataStackWithInMemoryStore];
}

- (void)tearDown
{
    [MagicalRecord cleanUp];
    [super tearDown];
}

- (void)testBuildManagedObject
{
    ManagedPerson *newPerson = [ManagedPerson foundryBuildWithContext:[NSManagedObjectContext MR_defaultContext]];
    XCTAssert(newPerson, @"There must be a new person built");
    XCTAssert(newPerson.objectID.isTemporaryID, @"The object should have a temporary ID");
    
}

- (void)testCreateManagedObject
{
    ManagedPerson *newPerson = [ManagedPerson foundryCreateWithContext:[NSManagedObjectContext MR_defaultContext]];
    XCTAssert(newPerson, @"There must be a new person built");
    XCTAssert(!newPerson.objectID.isTemporaryID, @"The object should have a permanent ID");
}

- (void)testBatchBuildManagedObjects
{
    NSArray *people = [ManagedPerson foundryBuildNumber:10 withContext:[NSManagedObjectContext MR_defaultContext]];
    XCTAssert(people, @"There must be an array of people");
    XCTAssert(people.count == 10, @"There must be 10 people");
    for (ManagedPerson *person in people) {
        XCTAssert(person.objectID.isTemporaryID, @"The object ID should be temporary");
    }
}

- (void)testBatchCreateManagedObjects
{
    NSArray *people = [ManagedPerson foundryCreateNumber:10 withContext:[NSManagedObjectContext MR_defaultContext]];
    XCTAssert(people, @"There must be an array of people");
    XCTAssert(people.count == 10, @"There must be 10 people");
    for (ManagedPerson *person in people) {
        XCTAssert(!person.objectID.isTemporaryID, @"The object ID should be permanent");
    }
}

- (void)testFailObjectBuild
{
    XCTAssertThrows([ManagedPerson foundryBuild], @"Trying to use the build method on a managed object should throw an exception");
}

- (void)testFailObjectBuildBatch
{
    XCTAssertThrows([ManagedPerson foundryBuildNumber:10], @"Trying to use the batch build method on a managed object should throw an exception");
}

@end
