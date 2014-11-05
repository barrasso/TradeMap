//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene
{
    // Map Container node
    CCNode *_mapContainer;
    
    // location manager
    CLLocationManager *locationManager;
    
    // Labels
    CCLabelTTF *_longitudeLabel;
    CCLabelTTF *_latitudeLabel;
}

#pragma mark - Lifecycle

-(void)didLoadFromCCB
{
    // init location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    // Check location manager for iOS 8
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        [locationManager requestWhenInUseAuthorization];
    
    // init map container
}

#pragma mark - Selectors

- (void)getLocation
{
    // update location
    [locationManager startUpdatingLocation];
    
    CCLOG(@"START updating location");
}

- (void)stopUpdates
{
    // stop updating user location
    [locationManager stopUpdatingLocation];
    
    CCLOG(@"STOP updating location");
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
    
    // Update labels
    _longitudeLabel.string = [NSString stringWithFormat:@"Longitude: %.8f",crnLoc.coordinate.longitude];
    _latitudeLabel.string = [NSString stringWithFormat:@"Latitude: %.8f",crnLoc.coordinate.latitude];
}

@end
