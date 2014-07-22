//
//  ViewController.swift
//  SparkConnect
//
//  Created by Alok Rao on 7/21/14.
//  Copyright (c) 2014 Alok Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var  socket : GCDAsyncUdpSocket?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket = GCDAsyncUdpSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
        var err : NSErrorPointer = nil
        if (!socket?.bindToPort( 8880, error: err)) {
            println(err)
        }
            
        if (!socket?.beginReceiving(err)) {
            println(err);
        }
        socket?.enableBroadcast(true, error: err)
        self.sendData("192.168.1.83", port: 8888, message: "Hello")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
    
    func udp( socket: GCDAsyncUdpSocket, didSendDataWithTag:CLong) {
        
    }
    // udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
    
    func udp(socket: GCDAsyncUdpSocket, didReceiveData:NSData, fromAddress : NSData,  withFilterContext : id_t) {
        println(didReceiveData)
    }
    
    func sendData(host: NSString, port : Int16, message : NSString) {
        socket?.sendData(message.dataUsingEncoding(NSUTF8StringEncoding), toHost: "192.168.1.255", port: 8888, withTimeout: -1, tag: 1)
    }
    //udpSocketDidClose:withError:
    func udpSocketDidClose(sock : GCDAsyncUdpSocket, withError:NSError) {
        println(withError)
    }
}

