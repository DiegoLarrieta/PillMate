import SwiftUI
import AVFoundation

struct CameraView: View {
    @State private var isCameraReady = false
    @Binding var capturedImage: UIImage?
    @Binding var medicationName: String
    @Binding var dosage: String
    @Binding var frequency: String
    @Binding var duration:String

    var body: some View {
        VStack {
            if isCameraReady {
                CameraRepresentable(capturedImage: $capturedImage)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Camera is loading...")
            }
            
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                
                Button("Recognize Text") {
                    if let capturedImage = capturedImage {
                        TextRecognitionService.recognizeTextInImage(image: capturedImage) { recognizedMedication in
                            // Update the form fields with the recognized data
                            medicationName = recognizedMedication.name
                            dosage = recognizedMedication.dosage
                            frequency = recognizedMedication.frequency
                            duration = recognizedMedication.duration
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            AVCaptureDevice.requestAccess(for: .video) { response in
                DispatchQueue.main.async {
                    self.isCameraReady = response
                }
            }
        }
    }
}

