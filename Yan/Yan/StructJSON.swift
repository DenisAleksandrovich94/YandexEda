

struct DataNews: Codable {
    
    var articles: [Article]
    
    
    struct Article: Codable {
        
        var author: String?
        var title: String
        var url: String
        var urlToImage: String?
        var publishedAt: String
        var content: String
        
    }
    
}
