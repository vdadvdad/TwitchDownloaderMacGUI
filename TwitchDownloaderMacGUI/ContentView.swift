//
//  ContentView.swift
//  TwitchDownloaderMacGUI
//
//  Created by Владислав Павловский on 29.06.2024.
//

import SwiftUI

struct ContentView: View {
    func f() {
        return
    }
    func modeButton(imageName: String, text: String, f: @escaping () -> Void) -> some View {
        return Button(action: f) {
            VStack() {
                Image(systemName: imageName)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .padding(.bottom)
                    .background(Color.black.opacity(0))
                Text(text).background(Color.black.opacity(0))
            }.padding()
        }.background(Color.black.opacity(1))
            .frame(maxHeight: 100)
            .aspectRatio(1.0, contentMode: .fill)
    }
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    modeButton(imageName: "video", text: "Download Video", f: f)
                    modeButton(imageName: "movieclapper", text: "Download Clip", f: f)
                    modeButton(imageName: "message", text: "Download Chat", f: f)
                    modeButton(imageName: "arrow.up.message", text: "Chat Update", f: f)
                    modeButton(imageName: "checkmark.message", text: "Chat Render", f: f)
                }.padding()
            }
            Divider()
            VideoDownloadView()
        }
    }
}

#Preview {
    ContentView()
}
