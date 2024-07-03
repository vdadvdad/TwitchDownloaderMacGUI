//
//  VideoDownloadView.swift
//  TwitchDownloaderMacGUI
//
//  Created by Владислав Павловский on 02.07.2024.
//

import SwiftUI

struct VideoDownloadView: View {
    @State private var link = ""
    @State private var hours_start = ""
    @State private var minutes_start = ""
    @State private var seconds_start = ""
    @State private var hours_end = ""
    @State private var minutes_end = ""
    @State private var seconds_end = ""
    @State private var video_name = ""
    func sendData() {
        var start_time: Int? = (Int(hours_start) ?? 0) * 3600
        start_time! += (Int(minutes_start) ?? 0) * 60
        start_time! += (Int(seconds_start) ?? 0)
        var end_time: Int? = (Int(hours_end) ?? 0) * 3600
        end_time! += (Int(minutes_end) ?? 0) * 60
        end_time! += (Int(seconds_end) ?? 0)
        var requestString: String = "videodownload "
        requestString += "-u " + link + " "
        requestString += "-b " + String(describing: start_time ?? 0) + " "
        requestString += "-e " + String(describing: end_time ?? 0) + " "
        requestString += "-o " + video_name
        let url = URL(string: "https://localhost:7084/twitchdownloader")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("text/json", forHTTPHeaderField: "Content-Type")
        let data = try! JSONEncoder().encode(requestString)
        print(data.base64EncodedString())
        request.httpBody = data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 201 {
                print("Success")
            }
            else {
                print("Unable to download")
                print(statusCode)
            }
            
        }
        task.resume()
    }
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Link to the stream:")
                    Spacer()
                    TextField(
                        "twitch.tv/videos",
                        text: $link
                    )
                }
                HStack {
                    Text("Download starting time:")
                    Spacer()
                    TextField(
                        "hh",
                        text: $hours_start
                    ).frame(width:30).padding(.trailing, -7)
                    Text(":")
                    TextField(
                        "mm",
                        text: $minutes_start
                    ).frame(width:30)
                        .padding([.leading, .trailing], -7)
                    Text(":")
                    TextField(
                        "ss",
                        text: $seconds_start
                    ).frame(width:30).padding(.leading, -7)
                }
                HStack {
                    Text("Download ending time:")
                    Spacer()
                    TextField(
                        "hh",
                        text: $hours_end
                    ).frame(width:30).padding(.trailing, -7)
                    Text(":")
                    TextField(
                        "mm",
                        text: $minutes_end
                    ).frame(width:30)
                        .padding([.leading, .trailing], -7)
                    Text(":")
                    TextField(
                        "ss",
                        text: $seconds_end
                    ).frame(width:30).padding(.leading, -7)
                }
                HStack {
                    Text("Filename:")
                    Spacer()
                    TextField(
                        "*.mp4",
                        text: $video_name
                    )
                }
            }
        }.padding()
        Button(action: sendData) {
            Text("Download")
        }.frame(maxWidth: .infinity)
            .background(Color.blue)
    }
}

#Preview {
    VideoDownloadView()
}
