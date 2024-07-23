//
//  HttpHandler.swift
//  TwitchDownloaderMacGUI
//
//  Created by Владислав Павловский on 23.07.2024.
//

import Foundation

public struct HttpHandler {
    private let ffmpeg_path = (Bundle.main.path(forResource: "ffmpeg", ofType: "") ?? "")
    private let url = URL(string: "https://localhost:5001/twitchdownloader")!
    private var request: URLRequest
    private var requestString: String = ""
    init() {
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("text/json", forHTTPHeaderField: "Content-Type")
    }
    private mutating func sendRequest() {
        let data = try! JSONEncoder().encode(requestString)
        self.request.httpBody = data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //let statusCode = (response as! HTTPURLResponse).statusCode
            //if statusCode == 201 {
            //    print("Success")
            //}
            //else {
            //    print("Unable to download")
            //    print(statusCode)
            //}
            
        }
        task.resume()
    }
    public mutating func sendVideoDownload(
        _ hours_start: String, _ minutes_start: String, _ seconds_start: String,
        _ hours_end: String, _ minutes_end: String, _ seconds_end: String,
        _ video_name: String, _ link: String, _ file_path: String
    ) {
        var start_time: Int? = (Int(hours_start) ?? 0) * 3600
        start_time! += (Int(minutes_start) ?? 0) * 60
        start_time! += (Int(seconds_start) ?? 0)
        var end_time: Int? = (Int(hours_end) ?? 0) * 3600
        end_time! += (Int(minutes_end) ?? 0) * 60
        end_time! += (Int(seconds_end) ?? 0)
        requestString = "videodownload "
        requestString += "-u " + link + " "
        requestString += "-b " + String(describing: start_time ?? 0) + " "
        requestString += "-e " + String(describing: end_time ?? 0) + " "
        requestString += "-o " + video_name + " "
        requestString += "--ffmpeg-path " + ffmpeg_path + " "
        requestString += "--file-path " + file_path
        sendRequest()
    }
    public mutating func sendClipDownload(
        _ link: String, _ filename: String, _ path: String
    ) {
        requestString = "clipdownload "
        requestString += "-u " + link + " "
        requestString += "-o " + filename + " "
        requestString += "--ffmpeg-path " + ffmpeg_path
        //TODO: add path to arguments
        sendRequest()
        
    }
}
