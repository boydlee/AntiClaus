
#import "Database.h"
#import "Utils.h"
//#import "DateUtil.h"

static sqlite3_stmt *query_statement1 = nil;
static sqlite3_stmt *query_statement2 = nil;
static sqlite3_stmt *query_statement3 = nil;
static sqlite3_stmt *query_statement4 = nil;
static sqlite3_stmt *query_statement5 = nil;
static sqlite3_stmt *query_statement6 = nil;
static sqlite3_stmt *query_statement7 = nil;

static NSString *DATABASE_PATH = nil;
NSString *DATABASE_NAME=@"data.db";


@implementation Database


// Open the database connection 
- (sqlite3 *)openDatabase {
	
	
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([DATABASE_PATH UTF8String], &database) == SQLITE_OK) {
		return database;
        
    } else {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
        // Additional error handling, as appropriate...
		return nil;
    }
}

+ (void)closeDatabase:(sqlite3 *)database{     
    [Database finalizeStatements];
    // Close the database.
    if (sqlite3_close(database) != SQLITE_OK) {
        NSAssert1(0, @"Error: failed to close database with message '%s'.", sqlite3_errmsg(database));
    }
}

// Finalize (delete) all of the SQLite compiled queries.
+ (void)finalizeStatements {
	if (query_statement1) sqlite3_finalize(query_statement1);
	if (query_statement2) sqlite3_finalize(query_statement2);
	if (query_statement3) sqlite3_finalize(query_statement3);
	if (query_statement4) sqlite3_finalize(query_statement4);
	if (query_statement5) sqlite3_finalize(query_statement5);
	if (query_statement6) sqlite3_finalize(query_statement6);
	if (query_statement7) sqlite3_finalize(query_statement7);
	
}

- (void)setDatabasePath {   
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
    DATABASE_PATH = [defaultDBPath copy];
}


// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
	if(!DATABASE_PATH)
		DATABASE_PATH = [writableDBPath copy];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_NAME];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

+ (NSMutableArray*)getSettings: (sqlite3 *)db {
	sqlite3* database = db;
	sqlite3_stmt * statement = query_statement5;
	if (statement == nil) {
		static char *sql = "select music_on, effects_on, player_name from settings LIMIT 1";
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}	
	
	//declare the array of items	
	NSMutableArray *items;
	items = [[NSMutableArray alloc] init];
	
	Setting* item = nil;
	while(sqlite3_step(statement) == SQLITE_ROW) {		
		item = [[Setting alloc] init];		
		item.effects = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)] ;
		item.music = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] ;	
		item.playername = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)] ;								
		
		// Add the object to the items Array
		[items addObject:item];	
		[item autorelease];	
	} 
	sqlite3_reset(statement);	
	[items autorelease];	
	return items;
}


+ (void)updateEffects:(NSString*)value InDatabase:(sqlite3 *)db {
	sqlite3* database = db;
	int success;
	
	sqlite3_stmt * statement2 = query_statement1;
	if (statement2 == nil) {
		static char *sql1 = "UPDATE settings SET effects_on = ? WHERE id = 1";
		if (sqlite3_prepare_v2(database, sql1, -1, &statement2, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	sqlite3_bind_text(statement2, 1,[value UTF8String], -1, SQLITE_TRANSIENT);
	
	success = sqlite3_step(statement2);
	sqlite3_reset(statement2);
	if (success == SQLITE_ERROR) {
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
	}		
}

+ (void)updateMusic:(NSString*)value InDatabase:(sqlite3 *)db {
	sqlite3* database = db;
	int success;
	
	sqlite3_stmt * statement2 = query_statement3;
	if (statement2 == nil) {
		static char *sql1 = "UPDATE settings SET music_on = ? WHERE id = 1";
		if (sqlite3_prepare_v2(database, sql1, -1, &statement2, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	sqlite3_bind_text(statement2, 1,[value UTF8String], -1, SQLITE_TRANSIENT);
	
	success = sqlite3_step(statement2);
	sqlite3_reset(statement2);
	if (success == SQLITE_ERROR) {
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
	}	
}

+ (void)updatePlayername:(NSString*)value InDatabase:(sqlite3 *)db {
	sqlite3* database = db;
	int success;
	
	sqlite3_stmt * statement2 = query_statement4;
	if (statement2 == nil) {
		static char *sql1 = "UPDATE settings SET player_name = ?";
		if (sqlite3_prepare_v2(database, sql1, -1, &statement2, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}
	sqlite3_bind_text(statement2, 1,[value UTF8String], -1, SQLITE_TRANSIENT);
		
	success = sqlite3_step(statement2);
	sqlite3_reset(statement2);
	if (success == SQLITE_ERROR) {
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
	}	
}


+ (NSMutableArray*)getFavourites: (sqlite3 *)db {
	sqlite3* database = db;
	sqlite3_stmt * statement = query_statement5;
	if (statement == nil) {
		static char *sql = "select score_name, score_points from favs order by cast(score_points as numeric) DESC LIMIT 10";
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
		}
	}	
	
	//declare the array of items	
	NSMutableArray *items;
	items = [[NSMutableArray alloc] init];
	
	Fav* item = nil;
	while(sqlite3_step(statement) == SQLITE_ROW) {		
		item = [[Fav alloc] init];		
		item.score_name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)] ;
		item.score_points = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)] ;							
		
		// Add the object to the items Array
		[items addObject:item];	
		[item autorelease];	
	} 
	sqlite3_reset(statement);	
	[items autorelease];	
	return items;
}

+ (void)insertFavourite:(Fav*)item InDatabase:(sqlite3 *)db {
	sqlite3* database = db;
	bool itemExists = NO;
		int success;
	
	if(!itemExists){
		sqlite3_stmt * statement2 = query_statement2;
		if (statement2 == nil) {
			static char *sql1 = "INSERT INTO favs(id, score_name, score_points) VALUES(null,?,?)";
			if (sqlite3_prepare_v2(database, sql1, -1, &statement2, NULL) != SQLITE_OK) {
				NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			}
		}
		sqlite3_bind_text(statement2, 1,[item.score_name UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(statement2, 2,[item.score_points UTF8String], -1, SQLITE_TRANSIENT);	
		success = sqlite3_step(statement2);
		sqlite3_reset(statement2);
		if (success == SQLITE_ERROR) {
			NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(database));
		}	
	}
}


@end