var distances = {
    '1 mile': 1,
    '5K': 3.1068559611866697,
    '8K': 4.970969537898672,
    '10K': 6.2137119223733395,
    '15K': 9.32056788356001,
    '10 mile': 10,
    'Half Marathon': 13.1094,
    'Marathon': 26.2188,
    '50K': 31.068559611866696,
    '50 mile': 50,
    '100K': 62.13711922373339,
    '100 mile': 100
};

function secondsToTime(ss) {
    return (ss >= 3600 ? Math.floor(ss / 3600.0 % 3600.0) + ':' : '') + 
        pad(Math.floor(ss / 60.0 % 60.0).toString(), 2) + ':' + 
        pad((ss % 60.0).toFixed(2), 5);
}

function pad(s, n) {
    if(s.length < n)
        return '0' + s;

    return s;
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

exports.pad = pad;
exports.secondsToTime = secondsToTime;
exports.secondsPerDistanceToTime = secondsPerDistanceToTime;
exports.timePartsToSeconds = timePartsToSeconds;
exports.calcMilesPerMinute = calcMilesPerMinute;
exports.secondsForDistance = secondsForDistance;
exports.timeForDistance = timeForDistance;
exports.calcTimes = calcTimes;
exports.uphToUps = uphToUps;
exports.upsToSpu = upsToSpu;
exports.spuToUps = spuToUps;

