//
//  ClipDownloadView.swift
//  TwitchDownloaderMacGUI
//
//  Created by Владислав Павловский on 22.07.2024.
//

import SwiftUI

struct ClipDownloadView: View {
    func sendData() {
        handler.sendClipDownload(link, filename, path)
    }
    @State private var link = ""
    @State private var filename = ""
    @State private var fileImporter = false
    @State private var path = "~/Downloads"
    var body: some View {
        ZStack (alignment: .center){
            VStack {
                HStack {
                    Text("Link to the clip: ")
                    TextField("twitch.tv/user/clip", text: $link)
                }
                HStack {
                    Text("Filename: ")
                    TextField("videoname.mp4", text: $filename)
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
                } // end of HStack
                Button(action: sendData) {
                    Text("Download Clip")
                }.frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.blue)
            } // end of VStack
            /*
            Text("Downloading in progress...")
                .monospaced()
                .background(.thinMaterial)
                //.frame(width: .infinity, height: .infinity)
            */
        }
        
    }
}

#Preview {
    ClipDownloadView()
}
