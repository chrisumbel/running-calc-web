var distances = {
    '1 mile': 1,
    '5K': 3.10686,
    '8K': 4.97097,
    '10K': 6.21371,
    '15K': 9.32057,
    '10 mile': 10,
    'Half Marathon': 13.1094,
    'Marathon': 26.2188,
    '50K': 31.0686,
    '50 mile': 50,
    '100K': 62.1371,
    '100 mile': 100
};

function pad(s, n) {
    if(s.length < n)
        return '0' + s;

    return s;
}

function getDistanceMode() {
    return $('input:radio[name=calc_units]:checked').val();
}

$('input:radio[name=calc_units]').click(function() {
    $('.units_label').text(getDistanceMode());
});

function calcDistanceTimes(spu) {
    if(isValid(spu)) {
        $('#calc_dist_results').html('');
        var scale = 1;

        if(getDistanceMode() == 'km') {
            scale = 1.60934;
        }

        var times = times = calcTimes(spu, scale);
        var customDist = parseNumber($('#calc_dist_dist').val());

        if(customDist > 0 && isValid(customDist)) {
            $('#calc_dist_results').html('<tr class="custom_dist"><td>' + customDist + ' ' + getDistanceMode() + '</td><td>' + timeForDistance(customDist, spu) + '</td></tr>');
        }

        for(distName in distances) {
            $('#calc_dist_results').append('<tr><td>' + distName + '</td><td>' + times[distName] + '</td></tr>');
        }
    } else {
        $('#calc_dist_results').html('');
    }
}

function parseNumber(s) {
    s = s.replace(/[^0-9.]/g, '');

    if(s == '')
        return NaN;

    return parseFloat(s) || 0;
} 

function parseAndValidateNumberField(fieldSelector) {
    var n = parseNumber($(fieldSelector).val());

    if(!isValid(n)) {
        $(fieldSelector).addClass('inputError');

        throw 'invalid input';
    }

    return n;
}

function errorIfy(callback, err) {
    try {        
        $('input').removeClass('inputError');
        callback();
    } catch (e) {
        if(err) {
            err();
        }
    }
}

$('#calc_mpm_calc').click(function() {
    errorIfy(function() {    
        var dist = parseAndValidateNumberField($('#calc_mpm_dist'));
        var hh = parseAndValidateNumberField($('#calc_mpm_hh'));
        var mm = parseAndValidateNumberField($('#calc_mpm_mm')); 
        var ss = parseAndValidateNumberField($('#calc_mpm_ss'));
        var time = calcMilesPerMinute(dist, hh, mm, ss);

        $('#calc_mpm_result').text(time);
    
    }, function() {
        $('#calc_mpm_result').text('');        
    });
});

$('#calc_dist_calc_uph').click(function() {
    errorIfy(function() {
        var ups = parseAndValidateNumberField('#calc_dist_uph');
        var spu = upsToSpu(uphToUps(ups));
        calcDistanceTimes(spu);
    }, function() {
        $('#calc_dist_results').html('');
    });
});

$('#calc_dist_calc_time').click(function() {
    errorIfy(function() {
        var mm = parseAndValidateNumberField('#calc_dist_mm');
        var ss = parseAndValidateNumberField('#calc_dist_ss');

        var spu = timePartsToSeconds(0, mm, ss);
        calcDistanceTimes(spu);

    }, function() {
        $('#calc_dist_results').html('');        
    });
});

function formateDecimal(n) {
    return n.toFixed(3);
}

$('#calc_utom_uph_to_mpm').click(function() {
    errorIfy(function() {
        var spu = upsToSpu(uphToUps(parseAndValidateNumberField('#calc_utom_uph')));
        $('#calc_utom_mm').val(Math.floor(spu / 60));
        $('#calc_utom_ss').val(formateDecimal(spu % 60));
    }, function() {
        $('#calc_utom_mm').val(0);
        $('#calc_utom_ss').val(0);        
    });
});

$('#calc_utom_mpm_to_uph').click(function() {
    errorIfy(function() {
        var ups = spuToUps(timePartsToSeconds(0, parseAndValidateNumberField('#calc_utom_mm'), parseAndValidateNumberField('#calc_utom_ss')));
        $('#calc_utom_uph').val(ups * 60 * 60);
    }, function() {
        $('#calc_utom_uph').val(0);        
    });
});

(function() {
    $('.units_label').text(getDistanceMode());
})();