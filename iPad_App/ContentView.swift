//
//  ContentView.swift
//  iPad_App
//
//  Created by 梅原 奈輝 on 2023/10/19.
//

import SwiftUI

struct ContentView: View {
    @State var selection = ("heart.fill", Color.pink)
    let sfSymbols = [
        ("heart.fill", Color.pink),
        ("star.fill", Color.yellow),
        ("ellipsis.circle.fill", Color.green),
        ("paperplane.fill", Color.blue),
        ("person.crop.circle.fill", Color.gray),
        ("cloud.sun.fill", Color.red),
        ("bolt.fill", Color.yellow),
        ("moon.stars.fill", Color.purple),
        ("house.fill", Color.orange),
        ("globe", Color.blue)
    ]
    
    var body: some View {
        NavigationSplitView {
            List {
                Section {
                    ForEach(sfSymbols, id: \.0.self) { symbol in
                        Button {
                            selection = symbol
                        } label: {
                            row(symbol.0, color: symbol.1, isSelection: selection.0 == symbol.0)
                        }
                        .listRowBackground(selection.0 == symbol.0 ? Color.cyan : nil)
                    }
                    .listRowInsets(EdgeInsets())
                } header: {
                    Text("Header")
                }
            }
            .listStyle(.insetGrouped)
        } detail: {
            Image(systemName: selection.0)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .foregroundStyle(selection.1)
        }
    }
    
    private func row(_ name: String, color: Color, isSelection: Bool) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundStyle(color)
                .overlay {
                    Image(systemName: name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        .padding(4)
                }
            
            Text(name)
                .foregroundStyle(isSelection ? Color.white : Color.black)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ContentView()
}
