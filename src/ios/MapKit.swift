//
//  MapKit.swift
//  
//
//  Created by Victor Zimmer on 09/11/15.
//
//

import Foundation

@objc(MapKit) class MapKit : CDVPlugin {
    func echo(command: CDVInvokedUrlCommand) {
        var message = command.arguments[0] as String
        
        message = message.uppercaseString // Prove the plugin is actually doing something
        
        var pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: message)
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
}