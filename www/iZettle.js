/*global cordova, module*/

module.exports = {
    chargeAmount: function (successCallback, errorCallback, api, amount, currency, reference) {
        cordova.exec(successCallback, errorCallback, "iZettle", "chargeAmount", [api, amount, currency, reference]);
    },
    settings: function (api) {
	    cordova.exec(function(){}, function(){}, "iZettle", "settings", [api]);
    },
    retrievePaymentInfoForReference: function(successCallback, errorCallback, api, rPIFR) {
	   cordova.exec(successCallback, errorCallback, "iZettle", "retrievePaymentInfoForReference", [api, rPIFR]); 
    },
    refundPaymentWithReference: unction(successCallback, errorCallback, api, refundPaymentWithReferenceID, refundReference) {
    	cordova.exec(successCallback, errorCallback, "iZettle", "refundPaymentWithReference", [api, refundPaymentWithReferenceID, refundReference]);
    },
    abortOperation: function(api) {
	 	cordova.exec(function(){}, function(){}, "iZettle", "abortOperation", [api]);  
    }
};