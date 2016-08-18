
function secondsToTime(ss) {
    return (ss >= 3600 ? Math.floor(ss / 3600.0 % 3600.0) + ':' : '') + 
        pad(Math.floor(ss / 60.0 % 60.0).toString(), 2) + ':' + 
        pad((ss % 60.0).toFixed(2), 5);
}

function secondsPerDistanceToTime(dist, seconds) {
    return secondsToTime(seconds / dist);
}

function timePartsToSeconds(hh, mm, ss) {
    return (hh * 60 * 60) + (mm * 60) + ss;
}

function calcMilesPerMinute(dist, hh, mm, ss) {	
    return secondsPerDistanceToTime(dist, timePartsToSeconds(hh, mm, ss));
}

function secondsForDistance(dist, spu) {
    return dist * spu;
}

function timeForDistance(dist, spu) {
    return secondsToTime(secondsForDistance(dist, spu));
}

function calcTimes(spu, scale) {				
    var times = {};

    for(distName in distances) {
        times[distName] = timeForDistance(distances[distName] * scale, spu);
    }

    return times;
}

function uphToUps(uph) {
    return uph / 60.0 / 60.0;
}

function upsToSpu(ups) {
    return  1 / ups;
}

function spuToUps(spu) {
    return  1 / spu;
}

function isValid(n) {
    valid = isFinite(n) && n >= 0; 
    return valid;
}