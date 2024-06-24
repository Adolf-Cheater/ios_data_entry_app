//
//  IntroView.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-20.
//

import SwiftUI

struct IntroView: View {
    @State private var isActive = false
    @State private var sliderOffset = CGFloat.zero  // To track the slider's horizontal offset
    let sliderWidth = CGFloat(80)  // Width of the slider handle
    let edgePadding = CGFloat(20)  // Padding on both sides

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                ZStack(alignment: .leading) {
                    // Background for the slider
                    Rectangle()
                        .foregroundColor(Color.gray.opacity(0.3))
                        .frame(height: 50)
                        .cornerRadius(25)
                        .padding(.horizontal, edgePadding)

                    // Text that will be covered by the slider
                    Text("Slide to Get Started")
                        .foregroundColor(.white)
                        .frame(height: 50, alignment: .leading)
                        .padding(.leading, sliderOffset + sliderWidth + edgePadding)

                    // Draggable slider handle
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .frame(width: sliderWidth, height: 50)
                        .background(Color.purple)
                        .cornerRadius(25)
                        .offset(x: sliderOffset + edgePadding)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    let newOffset = gesture.translation.width + sliderOffset
                                    sliderOffset = max(0, min(newOffset, UIScreen.main.bounds.width - sliderWidth - 2 * edgePadding))
                                }
                                .onEnded { _ in
                                    let maxOffset = UIScreen.main.bounds.width - sliderWidth - 2 * edgePadding
                                    if sliderOffset > maxOffset * 0.8 {
                                        sliderOffset = maxOffset  // Complete the slide
                                        isActive = true
                                    } else {
                                        withAnimation {
                                            sliderOffset = 0  // Reset
                                        }
                                    }
                                }
                        )
                }
                .frame(height: 50)
                .padding(.horizontal, edgePadding)

                Spacer()

                NavigationLink(destination: ContentView(), isActive: $isActive) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}







