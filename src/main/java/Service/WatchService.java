package Service;

import Utility.Constants;
import Model.Video;
import Model.Server;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.List;


public class WatchService {

    private Video video;

    public WatchService(Video video) {
        this.video = video;
    }

    public List<Server> fetchServersForMovies() throws IOException, InterruptedException {
        String apiUrl = this.video.getLink();
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder()
                            .uri(URI.create(apiUrl))
                            .header("Accept", "application/json, text/javascript, */*; q=0.01")
                            .header("Accept-Language", "en-US,en;q=0.8")
                            .header("X-Requested-With", "XMLHttpRequest")
                            .header("cookie", Constants.COOKIE)
                            .build();

        System.out.println("Sending request to API with query: " + this.video.getTitle());


        HttpResponse<String> apiResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());


        // This only works for download links for movies
        String html = apiResponse.body();
        Document doc = Jsoup.parse(html);
        if(video.getType().equals("movie")) {
            Element listElement = doc.selectFirst(".WatchServersList");
            Elements elements = listElement.select("btn[data-xpage]");
            List<Server> servers = new ArrayList<>();
            for (Element elm : elements) {
                String encodedUrl = elm.attr("data-url");
                String cleaned = encodedUrl.replaceAll("\\+", "");
                String base64String = "aHR0c" + cleaned;
    
                byte[] decodedBytes = java.util.Base64.getDecoder().decode(base64String);
                String decodedUrl = new String(decodedBytes, java.nio.charset.StandardCharsets.UTF_8);
                servers.add(new Server(elm.text(), decodedUrl));
            }
            return servers;

        }

        return new ArrayList<>();
    }

}
