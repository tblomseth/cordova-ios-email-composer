/*
 * Based on https://github.com/phonegap/phonegap-plugins/blob/DEPRECATED/iOS/EmailComposer/EmailComposer.js
 *
 */
var exec = require("cordova/exec");

function EmailComposer() {
    this.cdvService = 'EmailComposer';
}

EmailComposer.ComposeResultType = {
    Cancelled: 0,
    Saved: 1,
    Sent: 2,
    Failed: 3,
    NotSent: 4
}

/*
 * showEmailComposer: All args are optional
 */
EmailComposer.prototype.showEmailComposer = function ( callback, subject, body, toRecipients, ccRecipients, bccRecipients, bIsHTML ) {
    var args = {};
    if ( toRecipients )
        args.toRecipients = toRecipients;
    if ( ccRecipients )
        args.ccRecipients = ccRecipients;
    if ( bccRecipients )
        args.bccRecipients = bccRecipients;
    if ( subject )
        args.subject = subject;
    if ( body )
        args.body = body;
    if ( bIsHTML )
        args.bIsHTML = bIsHTML;

    exec( callback, null, this.cdvService, "showEmailComposer", [args] );
}
