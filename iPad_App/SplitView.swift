//
//  SplitView.swift
//  iPad_App
//
//  Created by 梅原 奈輝 on 2023/10/19.
//

import SwiftUI

struct SplitView: View {
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
        CustomSplitViewController(
            primaryView: {
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
            },
            secondaryView: {
                Image(systemName: selection.0)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .foregroundStyle(selection.1)
            })
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

struct CustomSplitViewController<PrimaryContent: View, SecondaryContent: View>: UIViewControllerRepresentable {
    let primaryView: () -> PrimaryContent
    let secondaryView: () -> SecondaryContent
    
    func makeUIViewController(context: Context) -> UISplitViewController {
        let vc = UISplitViewController(style: .doubleColumn)
        let primaryVC = UIHostingController(rootView: primaryView())
        let secondaryVC = UIHostingController(rootView: secondaryView())
        vc.setViewController(primaryVC, for: .primary)
        vc.setViewController(secondaryVC, for: .secondary)
//        vc.showDetailViewController(secondaryVC, sender: nil)
//        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UISplitViewController, context: Context) {
        uiViewController.setViewController(UIHostingController(rootView: primaryView()), for: .primary)
        uiViewController.showDetailViewController(UIHostingController(rootView: secondaryView()), sender: nil)
//        uiViewController.setViewController(UIHostingController(rootView: secondaryView()), for: .secondary)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: UISplitViewControllerDelegate {
        let parent: CustomSplitViewController
        
        init(parent: CustomSplitViewController) {
            self.parent = parent
        }
    }
}

#Preview {
    SplitView()
}
