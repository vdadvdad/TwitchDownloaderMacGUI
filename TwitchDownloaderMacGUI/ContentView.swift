//
//  ContentView.swift
//  TwitchDownloaderMacGUI
//
//  Created by Владислав Павловский on 29.06.2024.
//

import SwiftUI

extension AnyTransition {
    static var modeTransition: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .top).combined(with: .opacity),
            removal: .move(edge: .bottom).combined(with: .opacity)
        )
    }
}

struct ContentView: View {
    @State var mode = 1;
    public var process: Process
    @State var hovered = [false, false, false, false, false]
    func changeMode(_ mode: Int) {
        withAnimation {
            self.mode = mode
        }
    }
    func modeButton(imageName: String, text: String, selectsMode: Int) -> some View {
        var b = withAnimation {
            Button(action: { () -> Void in
                changeMode(selectsMode)
            }) {
                VStack() {
                    Image(systemName: imageName)
                        .imageScale(.large)
                        .foregroundStyle(self.hovered[selectsMode - 1] ? AnyShapeStyle(.green) : (mode == selectsMode) ? AnyShapeStyle(.tint) : AnyShapeStyle(.gray))
                        .scaleEffect(hovered[selectsMode - 1] ? 1.2 : 1.0)
                        .padding([.horizontal])
                    Text(text)
                        .frame(alignment: .leading)
                        .minimumScaleFactor(0.5)
                        .foregroundStyle((mode == selectsMode) ? AnyShapeStyle(.tint) : AnyShapeStyle(.gray))
                        .padding()
                }
            }.buttonStyle(.borderless)
                .padding(.top)
                .background(RoundedRectangle(cornerRadius: 5).stroke(self.hovered[selectsMode - 1] ? .green : .clear))
                    .animation(.easeInOut(duration: 1.0), value: hovered)
                    .onHover { isHovered in
                        self.hovered[selectsMode - 1] = !hovered[selectsMode - 1]
                    }
        }
        return b
    }
    init() {
        process = Process()
        let apiPath = Bundle.main.path(forResource: "TwitchDownloaderWebAPI", ofType: "", inDirectory: "osx-x64")
        process.executableURL = URL(fileURLWithPath: "/bin/sh")
        process.arguments = ["-c", apiPath!]
        try! process.run()
    }
    var body: some View {
        VStack {
            HStack {
                modeButton(imageName: "video", text: "Download Video", selectsMode: 1)
                modeButton(imageName: "movieclapper", text: "Download Clip", selectsMode: 2)
                modeButton(imageName: "message", text: "Download Chat", selectsMode: 3)
                modeButton(imageName: "arrow.up.message", text: "Chat Update", selectsMode: 4)
                modeButton(imageName: "checkmark.message", text: "Chat Render", selectsMode: 5)
            }.frame(alignment: .top)
            Divider()
            switch(mode) {
            case 1: VideoDownloadView().padding(.horizontal).transition(.modeTransition)
            case 2: ClipDownloadView().padding(.horizontal).transition(.modeTransition)
            case 3: ChatDownloadView().padding(.horizontal).transition(.modeTransition)
            default: VideoDownloadView()
            }
        }
    }
}

#Preview {
    ContentView()
}
