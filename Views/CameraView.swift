import SwiftUI
import AVFoundation

struct CameraView: View {
    @Binding var capturedImage: UIImage? // Binding para la imagen capturada
    @State private var isCameraReady = false

    var body: some View {
        VStack {
            if isCameraReady {
                CameraRepresentable(capturedImage: $capturedImage)
                    .edgesIgnoringSafeArea(.all) // Asegura que la cámara ocupe toda la pantalla
            } else {
                Text("Camera is loading...")
                    .foregroundColor(.white)
                    .padding()
            }

            
            // Solo muestra el botón si se ha capturado una imagen
            if let image = capturedImage {
                Spacer() // Esto empuja el botón hacia la parte inferior
                Button(action: {
                    if let capturedImage = capturedImage {
                        TextRecognitionService.recognizeTextInImage(image: capturedImage)
                    }
                }) {
                    Text("Recognize Text")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 30) // Ajusta la distancia desde el fondo
            }
        }
        .onAppear {
            // Verificar acceso a la cámara
            AVCaptureDevice.requestAccess(for: .video) { response in
                DispatchQueue.main.async {
                    self.isCameraReady = response
                }
            }
        }
    }
}

