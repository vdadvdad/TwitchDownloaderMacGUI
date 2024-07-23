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
    @State private var fileImporter = false;
    @State private var path = "~/Downloads";
    func sendData() {
        handler.sendVideoDownload(hours_start, minutes_start, seconds_start, hours_end, minutes_end, seconds_end, video_name, link, path)
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
                HStack {
                    Text("Folder to download: ").frame(alignment: .leading)
                    Spacer()
                    Button(path, action: {
                        fileImporter = !fileImporter;
                    }).fileImporter(isPresented: $fileImporter, allowedContentTypes: [.folder]) { result in
                        switch result {
                        case .success(let url):
                            path = url.path()
                        case .failure(let error):
                            print("ERROR: " + error.localizedDescription)
                        }
                    }
                }
                
            }
        }//.padding()
        Button(action: sendData) {
            Text("Download VOD")
        }.frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .tint(Color.blue)
    }
}

#Preview {
    VideoDownloadView()
}
