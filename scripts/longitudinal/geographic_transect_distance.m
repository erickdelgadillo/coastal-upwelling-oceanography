function [distanceKm, limitsKm] = geographic_transect_distance( ...
    longitude, latitude)
%GEOGRAPHIC_TRANSECT_DISTANCE Convert positions to distance from the coast.
%   DISTANCEKM = GEOGRAPHIC_TRANSECT_DISTANCE(LONGITUDE, LATITUDE) returns
%   great-circle distance in kilometres from the coastal endpoint of the
%   ENVISION transect. The archived tables store degrees west as positive
%   longitude values; pairwise distances are unaffected by that convention.
%
%   [DISTANCEKM, LIMITSKM] also returns the fixed horizontal limits spanning
%   the complete transect, including days where an endpoint was not sampled.
%   The reference latitude is taken from the input table because the CTD and
%   nutrient archives record slightly different transect latitudes.

coastLongitude = 8.9145;
offshoreLongitude = 9.708;
validLatitude = latitude(isfinite(latitude));
if isempty(validLatitude)
    error('No finite latitude values were supplied.');
end
transectLatitude = median(validLatitude);

distanceKm = greatCircleDistanceKm(coastLongitude, transectLatitude, ...
    longitude, latitude);
maximumDistanceKm = greatCircleDistanceKm(coastLongitude, transectLatitude, ...
    offshoreLongitude, transectLatitude);
limitsKm = [0, maximumDistanceKm];
end

function distanceKm = greatCircleDistanceKm(longitude1, latitude1, ...
    longitude2, latitude2)
earthRadiusKm = 6371.0088;
latitude1Radians = deg2rad(latitude1);
latitude2Radians = deg2rad(latitude2);
latitudeDifference = latitude2Radians - latitude1Radians;
longitudeDifference = deg2rad(longitude2 - longitude1);

haversine = sin(latitudeDifference ./ 2).^2 ...
    + cos(latitude1Radians) .* cos(latitude2Radians) ...
    .* sin(longitudeDifference ./ 2).^2;
haversine = min(max(haversine, 0), 1);
distanceKm = 2 .* earthRadiusKm .* atan2(sqrt(haversine), ...
    sqrt(1 - haversine));
end
