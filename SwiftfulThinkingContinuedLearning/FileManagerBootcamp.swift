//  FileManagerBootcamp.swift

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder. \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder. \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return "Error getting data."
        }
        
        
        // Data that can be downloaded again or regenerated should be saved in cachesDirectory
//        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        
        // Data that cannot be recreated by the application or downloaded
//        let directory2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // Data that is used temporarily should be stored in the /tmp folder
//        let directory3 = FileManager.default.temporaryDirectory
        
//        print(directory)
//        print(directory2)
//        print(directory3)
        
//        let path = directory?.appendingPathComponent("\(name).jpeg")
//        print(directory)
//        print(path)
        
        do {
            try data.write(to: path)
            print(path)
            return "Success saving!"
        }
        catch let error {
            return "Error saving! \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
         
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name),
            FileManager.default.fileExists(atPath: path.path) else {
            return "Error getting path."
            
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            return "Successfully deleted. "
        } catch let error {
            return "Error deleting image. \(error)"
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpeg") else {
            print("Error getting path")
            return nil
        }
        
        return path
    }
}

// The ViewModels should be specific to specific Views
// This ViewModel is specific to the FileManagerBootcamp View
class FileManagerViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let imageName: String = "klarna"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerBootcamp: View {
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button(action: {
                        vm.saveImage()
                    }, label: {
                        Text("Save to FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    
                    Button(action: {
                        vm.deleteImage()
                    }, label: {
                        Text("Delete from FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .navigationTitle("File Manager")
            
                
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
