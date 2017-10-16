//
//  RxFirebaseStorage.swift
//  RxFirebase
//
//  Created by Guilherme Souza on 25/07/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import RxSwift
import FirebaseStorage

public extension StorageReference {
    // MARK: UPLOAD

    /**
     Asynchronously uploads data to the currently specified FIRStorageReference.
     This is not recommended for large files, and one should instead upload a file from disk.

     @param uploadData The NSData to upload.
     @param metadata FIRStorageMetaData containing additional information (MIME type, etc.) about the object being uploaded.

     */
    func rx_putData(_ data: Data, metaData: StorageMetadata? = nil) -> Observable<StorageUploadTask> {
        return Observable.create { observer in
            observer.onNext(self.putData(data, metadata: metaData, completion: { (metadata, error) in }))
            return Disposables.create()
        }
    }

    /**
     Asynchronously upload data to the currently specified FIRStorageReference.
     This is not recommended for large files, and one should instead upload a file from disk.
     This method will output upload progress and success or failure states.

     @param uploadData The NSData to upload.
     @param metadata FIRStorageMetaData containing additional information (MIME type, etc.) about the object being uploaded.
     */
    func rx_putDataWithProgress(_ data: Data, metaData: StorageMetadata? = nil) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return rx_putData(data, metaData: metaData).rx_storageStatus()
    }

    /**
     Asynchronously uploads a file to the currently specified FIRStorageReference.

     @param fileURL A URL representing the system file path of the object to be uploaded.
     @param metadata FIRStorageMetadata containing additional information (MIME type, etc.) about the object being uploaded.
     */
    func rx_putFile(from path: URL, metadata: StorageMetadata? = nil) -> Observable<StorageUploadTask> {
        return Observable.create { observer in
            let uploadTask = self.putFile(from: path, metadata: metadata, completion: { (metadata, error) in })
            observer.onNext(uploadTask)
            return Disposables.create {
                uploadTask.cancel()
            }
        }
    }

    /**
     Asynchronously uploads a file to the currently specified FIRStorageReference.
     This method will output upload progress and success or failure states.

     @param fileURL A URL representing the system file path of the object to be uploaded.
     @param metadata FIRStorageMetadata containing additional information (MIME type, etc.) about the object being uploaded.
     */
    func rx_putFileWithProgress(path: URL, metadata: StorageMetadata? = nil) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return rx_putFile(from: path, metadata: metadata).rx_storageStatus()
    }

    // MARK: DOWNLOAD

    /**
     Asynchronously downloads the object at the FIRStorageReference to an NSData Object in memory.
     An NSData of the provided max size will be allocated, so ensure that the device has enough free
     memory to complete the download. For downloading large files, writeToFile may be a better option.

     @param size The maximum size in bytes to download.  If the download exceeds this size the task will be cancelled and an error will be returned.
     */
    func rx_getData(maxSize size: Int64) -> Observable<Data?> {
        return Observable.create { observer in
            let download = self.getData(maxSize: size, completion: { (data, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                download.cancel()
            }
        }
    }
    /**
     Asynchronously downloads the object at the FIRStorageReference to an NSData Object in memory.
     An NSData of the provided max size will be allocated, so ensure that the device has enough free
     memory to complete the download. For downloading large files, writeToFile may be a better option.

     This method will output upload progress and success states.

     @param size The maximum size in bytes to download.  If the download exceeds this size the task will be cancelled and an error will be returned.
     */
    func rx_getData(maxSize size: Int64) -> Observable<(Data?, StorageTaskSnapshot?, StorageTaskStatus?)> {
        return Observable.create { observer in
            let download = self.getData(maxSize: size, completion: { (data, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext((data, nil, .success))
                    observer.onCompleted()
                }
            })

            download.observe(.progress, handler: { (snapshot: StorageTaskSnapshot) in
                if let error = snapshot.error {
                    observer.onError(error)
                } else {
                    observer.onNext((nil, snapshot, .progress))
                }
            })

            return Disposables.create {
                download.cancel()
            }
        }
    }

    /**
     Asynchronously downloads the object at the current path to a specified system filepath.

     @param fileURL A file system URL representing the path the object should be downloaded to.
     */
    func rx_write(toFile fileURL: URL) -> Observable<URL?> {
        return Observable.create { observer in
            let download = self.write(toFile: fileURL, completion: { (url, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(url)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                download.cancel()
            }
        }
    }

    /**
     Asynchronously downloads the object at the current path to a specified system filepath.

     This method will output upload progress and success states.

     @param fileURL A file system URL representing the path the object should be downloaded to.
     */
    func rx_writeWithProgress(toFile fileURL: URL) -> Observable<(URL?, StorageTaskSnapshot?, StorageTaskStatus?)> {
        return Observable.create { observer in
            let download = self.write(toFile: fileURL, completion: { (url, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext((url, nil, .success))
                    observer.onCompleted()
                }
            })

            download.observe(.progress, handler: { (snapshot: StorageTaskSnapshot) in
                if let error = snapshot.error {
                    observer.onError(error)
                } else {
                    observer.onNext((nil, snapshot, .progress))
                }
            })

            return Disposables.create {
                download.cancel()
            }
        }
    }

    /**
     Asynchronously retrieves a long lived download URL with a revokable token.
     This can be used to share the file with others, but can be revoked by a developer
     in the Firebase Console if desired.
     */
    func rx_downloadURL() -> Observable<URL?> {
        return Observable.create { observable in
            self.downloadURL(completion: { (url, error) in
                if let error = error {
                    observable.onError(error)
                } else {
                    observable.onNext(url)
                    observable.onCompleted()
                }
            })
            return Disposables.create()
        }
    }

    // MARK: DELETE
    /**
     Deletes the object at the current path.
     */
    func rx_delete() -> Observable<Void> {
        return Observable.create { observable in
            self.delete(completion: { error in
                if let error = error {
                    observable.onError(error)
                } else {
                    observable.onNext()
                    observable.onCompleted()
                }
            })
            return Disposables.create()
        }
    }

    // MARK: METADATA
    /**
     Retrieves metadata associated with an object at the current path.
     */
    func rx_getMetadata() -> Observable<StorageMetadata?> {
        return Observable.create { observer in
            self.getMetadata(completion: { (metadata, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(metadata)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }

    /**
     Updates the metadata associated with an object at the current path.

     @param metadata An FIRStorageMetadata object with the metadata to update.
     */
    func rx_updateMetadata(_ metadata: StorageMetadata) -> Observable<StorageMetadata?> {
        return Observable.create { observer in
            self.updateMetadata(metadata, completion: { (metadata, error) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(metadata)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }

}

extension StorageUploadTask {
    func rx_observe(_ status: StorageTaskStatus) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return Observable.create { observer in
            let observeStatus = self.observe(status, handler: { (snapshot: StorageTaskSnapshot) in
                if let error = snapshot.error {
                    observer.onError(error)
                } else {
                    observer.onNext((snapshot, status))
                    if status == .success {
                        observer.onCompleted()
                    }
                }
            })
            return Disposables.create {
                self.removeObserver(withHandle: observeStatus)
            }
        }
    }
}

extension StorageDownloadTask {
    func rx_observe(_ status: StorageTaskStatus) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return Observable.create { observer in
            let observeStatus = self.observe(status, handler: { snapshot in
                if let error = snapshot.error {
                    observer.onError(error)
                } else {
                    observer.onNext((snapshot, status))
                    if status == .success {
                        observer.onCompleted()
                    }
                }
            })
            return Disposables.create {
                self.removeObserver(withHandle: observeStatus)
            }
        }
    }
}

extension ObservableType where E: StorageUploadTask {
    func rx_storageStatus() -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return self.flatMap { (uploadTask: StorageUploadTask) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> in
            let progressStatus = uploadTask.rx_observe(.progress)
            let successStatus = uploadTask.rx_observe(.success)
            let failureStatus = uploadTask.rx_observe(.failure)

            let merged = Observable.of(progressStatus, successStatus, failureStatus).merge()
            return merged
        }
    }
}

extension ObservableType where E: StorageDownloadTask {
    func rx_storageStatus() -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> {
        return self.flatMap { (downloadTask: StorageDownloadTask) -> Observable<(StorageTaskSnapshot, StorageTaskStatus)> in
            let progressStatus = downloadTask.rx_observe(.progress)
            let successStatus = downloadTask.rx_observe(.success)
            let failureStatus = downloadTask.rx_observe(.failure)

            let merged = Observable.of(progressStatus, successStatus, failureStatus).merge()
            return merged
        }
    }
}
