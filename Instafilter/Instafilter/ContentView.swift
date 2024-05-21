//
//  ContentView.swift
//  Instafilter
//
//  Created by Sajib Ghosh on 07/04/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit

struct ContentView: View {
    /*
    @State private var blurAmount = 0.0 {
        didSet {
            print("Changed blurAmount: \(blurAmount)")
        }
    }
    @State private var backgroundColor = Color.white
    */
    
    //@State private var image: Image?
    
    
    
    
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @Environment(\.requestReview) var requestReview
    @AppStorage("filterCount") var filterCount = 0
    
    var body: some View {
        /*
        VStack{
            Text("Hello world!")
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: $blurAmount) { oldValue, newValue in
                    print("NewValue is: \(newValue)")
                }
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
         */
        /*
        Button("Hello world!"){
            showingConfirmation.toggle()
        }
        .frame(width: 200, height: 200)
        .background(backgroundColor)
        .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
            Button("Red") {backgroundColor = .red}
            Button("Green") {backgroundColor = .green}
            Button("Blue") {backgroundColor = .blue}
            Button("Cancel", role: .cancel){}
        }message: {
            Text("Select a new color")
        }
         */
        /*
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }.onAppear(perform: loadImage)
         */
        /*
        VStack {
            PhotosPicker("Select a photo", selection: $pickerItems, maxSelectionCount: 3, matching: .images)
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }.onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
        */
        /*
        let example = Image(.example)
        ShareLink(item: example, preview: SharePreview("Sajib", image: example)) {
            Label("Click to share", systemImage: "photo")
        }
        
        Button("Leave a review") {
            requestReview()
        }
         */
        
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    }else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to export a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                Spacer()
                
                    
                VStack {
                    HStack {
                        Text("Intensity")
                            .frame(width: 100, alignment: .leading)
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                    }
                    HStack {
                        Text("Radius")
                            .frame(width: 100, alignment: .leading)
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProcessing)
                    }
                }
                .disabled(selectedItem == nil)

                HStack {
                    Button("Change Filter", action: changeFilter)
                        .disabled(selectedItem == nil)
                    Spacer()
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }.padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystalise"){ setFilter(CIFilter.crystallize()) }
                Button("Edges"){ setFilter(CIFilter.edges()) }
                Button("Gaussian Blur"){ setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate"){ setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone"){ setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask"){ setFilter(CIFilter.unsharpMask()) }
                Button("Vignette"){ setFilter(CIFilter.vignette()) }
                Button("Bloom"){ setFilter(CIFilter.bloom()) }
                Button("Box Blur"){ setFilter(CIFilter.boxBlur()) }
                Button("Circular Wrap"){ setFilter(CIFilter.circularWrap()) }
                Button("Cancel", role: .cancel){  }
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }

    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
        
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
         filterCount += 1
        
        if filterCount >= 10 {
            requestReview()
        }
    }
    /*
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImg = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImg)
        image = Image(uiImage: uiImage)
    }
     */
}

#Preview {
    ContentView()
}
