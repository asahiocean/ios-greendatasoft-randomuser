import Foundation

extension TableViewController {
    func cellForRowAt_customCell(_ indexPath: IndexPath, _ cell: CustomCell) {
        if let results = storage.database?.results {
            let result = results[indexPath.row]
            //MARK: Name Block
            cell.idname = result.name.id
            cell.gender = result.name.title
            cell.firstname?.text = result.name.first
            cell.surname?.text = result.name.last
            
            //MARK: Picture Block
            DispatchQueue.main.async {
                API.loadImage(result.picture.largeUrl, { image in
                    cell.photo?.image = image
                })
            }
            cell.phone.text = result.phone
        }
    }
}
